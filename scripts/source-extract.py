#!/usr/bin/env python3
"""Extract staged source text into a reusable BA-kit cache."""

from __future__ import annotations

import argparse
import hashlib
import json
import mimetypes
import os
import re
import shutil
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


@dataclass
class ExtractResult:
    text: str
    source_type: str
    page_count: int | None = None


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as fh:
        while True:
            chunk = fh.read(1024 * 1024)
            if not chunk:
                break
            digest.update(chunk)
    return digest.hexdigest()


def run_command(args: list[str], *, stdin: bytes | None = None) -> str:
    proc = subprocess.run(
        args,
        input=stdin,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if proc.returncode != 0:
        raise RuntimeError(proc.stderr.decode("utf-8", errors="replace").strip() or f"Command failed: {' '.join(args)}")
    return proc.stdout.decode("utf-8", errors="replace")


def extract_pdf(path: Path) -> ExtractResult:
    text = run_command(["pdftotext", "-layout", str(path), "-"])
    page_count = None
    try:
      info = run_command(["pdfinfo", str(path)])
      match = re.search(r"^Pages:\s+(\d+)$", info, re.MULTILINE)
      if match:
          page_count = int(match.group(1))
    except Exception:
      page_count = None
    return ExtractResult(text=text, source_type="pdf", page_count=page_count)


def extract_docx(path: Path) -> ExtractResult:
    text = run_command(["textutil", "-convert", "txt", "-stdout", str(path)])
    return ExtractResult(text=text, source_type="docx")


def extract_textual(path: Path) -> ExtractResult:
    return ExtractResult(text=path.read_text(encoding="utf-8", errors="replace"), source_type="text")


def extract_image(path: Path) -> ExtractResult:
    if shutil.which("tesseract"):
        text = run_command(["tesseract", str(path), "stdout"])
        return ExtractResult(text=text, source_type="image")
    raise RuntimeError("Image OCR is unavailable. Install 'tesseract' to use source-extract on images.")


def detect_kind(path: Path) -> str:
    suffix = path.suffix.lower()
    if suffix == ".pdf":
        return "pdf"
    if suffix == ".docx":
        return "docx"
    if suffix in {".md", ".txt", ".text", ".markdown", ".rst"}:
        return "text"
    mime, _ = mimetypes.guess_type(path.name)
    if mime and mime.startswith("image/"):
        return "image"
    return "text"


def iter_paragraphs(text: str) -> Iterable[str]:
    for block in re.split(r"\n\s*\n", text):
        clean = block.strip()
        if clean:
            yield clean


def chunk_text(text: str, max_chars: int) -> list[str]:
    paragraphs = list(iter_paragraphs(text))
    if not paragraphs:
        return []
    chunks: list[str] = []
    current: list[str] = []
    current_len = 0
    for para in paragraphs:
        addition = len(para) + (2 if current else 0)
        if current and current_len + addition > max_chars:
            chunks.append("\n\n".join(current))
            current = [para]
            current_len = len(para)
        else:
            current.append(para)
            current_len += addition
    if current:
        chunks.append("\n\n".join(current))
    return chunks


def candidate_headings(text: str, limit: int = 10) -> list[str]:
    headings: list[str] = []
    seen: set[str] = set()
    for line in text.splitlines():
        clean = line.strip()
        if not clean:
            continue
        is_heading = (
            clean.startswith("#")
            or bool(re.match(r"^(\d+(\.\d+)*)[\).\s-]+", clean))
            or (len(clean) <= 90 and clean.upper() == clean and re.search(r"[A-ZÀ-Ỹ]", clean))
        )
        if is_heading and clean not in seen:
            headings.append(clean)
            seen.add(clean)
        if len(headings) >= limit:
            break
    return headings


def first_sentences(text: str, limit: int = 8) -> list[str]:
    sentences = re.split(r"(?<=[.!?])\s+", re.sub(r"\s+", " ", text.strip()))
    result: list[str] = []
    for sentence in sentences:
        clean = sentence.strip()
        if clean:
            result.append(clean)
        if len(result) >= limit:
            break
    return result


def write_summary(cache_dir: Path, path: Path, result: ExtractResult, chunk_count: int) -> None:
    headings = candidate_headings(result.text)
    sentences = first_sentences(result.text)
    lines = [
        f"# Source Summary: {path.name}",
        "",
        f"- Source path: `{path}`",
        f"- Source type: `{result.source_type}`",
        f"- Cache dir: `{cache_dir}`",
        f"- Chunks: {chunk_count}",
    ]
    if result.page_count is not None:
        lines.append(f"- Pages: {result.page_count}")
    if headings:
        lines.extend(["", "## Candidate Headings"])
        lines.extend(f"- {heading}" for heading in headings)
    if sentences:
        lines.extend(["", "## Summary Excerpts"])
        lines.extend(f"- {sentence}" for sentence in sentences)
    (cache_dir / "summary.md").write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def write_chunks(cache_dir: Path, chunks: list[str]) -> list[str]:
    chunk_dir = cache_dir / "chunks"
    chunk_dir.mkdir(parents=True, exist_ok=True)
    paths: list[str] = []
    for index, chunk in enumerate(chunks, start=1):
        path = chunk_dir / f"chunk-{index:02d}.md"
        path.write_text(f"# Chunk {index:02d}\n\n{chunk.strip()}\n", encoding="utf-8")
        paths.append(str(path))
    return paths


def copy_to_promoted(cache_dir: Path, promoted_root: Path) -> None:
    promoted_root.mkdir(parents=True, exist_ok=True)
    for name in ("manifest.json", "summary.md"):
        shutil.copy2(cache_dir / name, promoted_root / name)
    target_chunks = promoted_root / "chunks"
    if target_chunks.exists():
        shutil.rmtree(target_chunks)
    shutil.copytree(cache_dir / "chunks", target_chunks)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("source")
    parser.add_argument("--cache-root", required=True)
    parser.add_argument("--promote-root")
    parser.add_argument("--chunk-chars", type=int, default=4000)
    parser.add_argument("--copy-raw", action="store_true")
    args = parser.parse_args()

    source = Path(args.source).expanduser().resolve()
    if not source.exists():
        raise SystemExit(f"Source file not found: {source}")

    source_hash = sha256_file(source)
    cache_dir = Path(args.cache_root.format(source_hash=source_hash)).expanduser()
    cache_dir.mkdir(parents=True, exist_ok=True)

    kind = detect_kind(source)
    try:
        if kind == "pdf":
            result = extract_pdf(source)
        elif kind == "docx":
            result = extract_docx(source)
        elif kind == "image":
            result = extract_image(source)
        else:
            result = extract_textual(source)
    except Exception as exc:
        raise SystemExit(str(exc))

    chunks = chunk_text(result.text, args.chunk_chars)
    if not chunks and result.text.strip():
        chunks = [result.text.strip()]
    chunk_paths = write_chunks(cache_dir, chunks)
    write_summary(cache_dir, source, result, len(chunk_paths))

    if args.copy_raw:
        raw_dir = cache_dir / "raw"
        raw_dir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, raw_dir / source.name)

    manifest = {
        "version": 1,
        "source_path": str(source),
        "source_name": source.name,
        "source_hash": source_hash,
        "source_type": result.source_type,
        "page_count": result.page_count,
        "cache_dir": str(cache_dir),
        "summary_path": str(cache_dir / "summary.md"),
        "chunk_count": len(chunk_paths),
        "chunk_paths": chunk_paths,
    }
    (cache_dir / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")

    if args.promote_root:
        copy_to_promoted(cache_dir, Path(args.promote_root).expanduser())
        manifest["promoted_root"] = str(Path(args.promote_root).expanduser())
        (cache_dir / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")

    print(json.dumps(manifest, indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main())
