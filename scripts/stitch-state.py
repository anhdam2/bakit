#!/usr/bin/env python3
"""Manage BA-kit stitch-state cache."""

from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def load_state(path: Path) -> dict:
    if path.exists():
        return json.loads(path.read_text(encoding="utf-8"))
    return {
        "version": 1,
        "project_id": None,
        "updated_at": None,
        "screens": {},
    }


def save_state(path: Path, state: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    state["updated_at"] = utc_now()
    path.write_text(json.dumps(state, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)

    init_p = subparsers.add_parser("init")
    init_p.add_argument("--path", required=True)
    init_p.add_argument("--project-id")

    show_p = subparsers.add_parser("show")
    show_p.add_argument("--path", required=True)

    upsert_p = subparsers.add_parser("upsert")
    upsert_p.add_argument("--path", required=True)
    upsert_p.add_argument("--screen", required=True)
    upsert_p.add_argument("--status", required=True)
    upsert_p.add_argument("--project-id")
    upsert_p.add_argument("--screen-ref")
    upsert_p.add_argument("--artifact")
    upsert_p.add_argument("--prompt")

    args = parser.parse_args()
    path = Path(args.path).expanduser()

    if args.command == "init":
        state = load_state(path)
        if args.project_id:
            state["project_id"] = args.project_id
        save_state(path, state)
        print(path)
        return 0

    if args.command == "show":
        state = load_state(path)
        print(json.dumps(state, indent=2, sort_keys=True))
        return 0

    if args.command == "upsert":
        state = load_state(path)
        if args.project_id:
            state["project_id"] = args.project_id
        state.setdefault("screens", {})
        state["screens"][args.screen] = {
            "artifact": args.artifact,
            "prompt": args.prompt,
            "screen_ref": args.screen_ref,
            "status": args.status,
            "updated_at": utc_now(),
        }
        save_state(path, state)
        print(path)
        return 0

    raise SystemExit("Unknown stitch-state command")


if __name__ == "__main__":
    sys.exit(main())
