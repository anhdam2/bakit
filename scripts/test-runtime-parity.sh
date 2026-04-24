#!/bin/sh
# test-runtime-parity.sh
#
# Parity harness entry point for BA-kit Adaptive Runtime Memory.
# Gates Phase 01/02/03 closure by verifying golden contracts exist and
# match fixture definitions across Claude Code, Codex, and Antigravity.
#
# Usage:
#   test-runtime-parity.sh [--list] [--check-structure] [fixture-id]
#
# Full parity testing (actual LLM execution) requires:
#   1. A runtime adapter per target (Claude Code CLI, Codex API, Antigravity API)
#   2. A replay driver that submits each fixture's Input Command to the runtime
#   3. A normalizer that maps raw runtime output to the Behavior Envelope table format
#   4. A diff engine that compares normalized output against the golden file
# Until those adapters exist, all checks report PENDING.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FIXTURES_DIR="$REPO_ROOT/tests/runtime-parity/fixtures"
GOLDENS_DIR="$REPO_ROOT/tests/runtime-parity/goldens"

# Fixture registry: id -> fixture_file:golden_file:description
# Add new fixtures here as phases progress.
FIXTURES="
f01:f01-summary-only-compact.md:g01-summary-only-compact.md:Summary-only compact mode (no shard tree)
f02:f02-freeform-routing-do.md:g02-freeform-routing-do.md:Freeform routing via ba-do → ba-impact
f03:f03-freeform-routing-impact.md:g03-freeform-routing-impact.md:Explicit ba-impact read scope and stop conditions
f04:f04-explicit-ba-start-step.md:g04-explicit-ba-start-step.md:Explicit ba-start backbone command
f05:f05-compact-fallback-missing-index.md:g05-compact-fallback-missing-index.md:Compact fallback on missing index.md
"

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS] [fixture-id]

Options:
  --list              List all available fixtures and their status
  --check-structure   Verify harness directory and file integrity
  fixture-id          Run parity check for a single fixture (e.g. f01)
  (no args)           Run all fixtures

Exit codes:
  0  All checks pass (or all PENDING with structure intact)
  1  Structure missing, golden absent, or parity failure detected
EOF
}

check_structure() {
    echo "Checking harness directory structure..."
    failed=0

    if [ ! -d "$FIXTURES_DIR" ]; then
        echo "  FAIL: fixtures dir missing: $FIXTURES_DIR"
        failed=1
    else
        echo "  OK:   $FIXTURES_DIR"
    fi

    if [ ! -d "$GOLDENS_DIR" ]; then
        echo "  FAIL: goldens dir missing: $GOLDENS_DIR"
        failed=1
    else
        echo "  OK:   $GOLDENS_DIR"
    fi

    echo "$FIXTURES" | grep -v '^$' | while IFS=: read -r id fixture golden desc; do
        fpath="$FIXTURES_DIR/$fixture"
        gpath="$GOLDENS_DIR/$golden"
        if [ ! -f "$fpath" ]; then
            echo "  FAIL: fixture missing: $fpath"
            failed=1
        else
            echo "  OK:   fixture $id: $fixture"
        fi
        if [ ! -f "$gpath" ]; then
            echo "  FAIL: golden missing: $gpath"
            failed=1
        else
            echo "  OK:   golden $id: $golden"
        fi
    done

    if [ "$failed" -eq 0 ]; then
        echo "Structure OK."
        return 0
    else
        echo "Structure check FAILED."
        return 1
    fi
}

list_fixtures() {
    echo "Available fixtures:"
    echo ""
    printf "  %-6s %-45s %s\n" "ID" "Fixture File" "Description"
    printf "  %-6s %-45s %s\n" "------" "---------------------------------------------" "-----------"
    echo "$FIXTURES" | grep -v '^$' | while IFS=: read -r id fixture golden desc; do
        gpath="$GOLDENS_DIR/$golden"
        if [ -f "$gpath" ]; then
            status="golden present"
        else
            status="GOLDEN MISSING"
        fi
        printf "  %-6s %-45s %s [%s]\n" "$id" "$fixture" "$desc" "$status"
    done
}

# Stub runner: checks golden exists, reports PENDING for actual parity.
# Replace this function body with runtime adapter calls when adapters are ready.
run_fixture() {
    target_id="$1"
    matched=0

    echo "$FIXTURES" | grep -v '^$' | while IFS=: read -r id fixture golden desc; do
        if [ "$target_id" != "ALL" ] && [ "$id" != "$target_id" ]; then
            continue
        fi
        matched=1

        fpath="$FIXTURES_DIR/$fixture"
        gpath="$GOLDENS_DIR/$golden"

        echo "---"
        echo "Fixture [$id]: $desc"

        if [ ! -f "$fpath" ]; then
            echo "  ERROR: fixture file not found: $fpath"
            exit 1
        fi

        if [ ! -f "$gpath" ]; then
            echo "  ERROR: golden file not found: $gpath"
            echo "  Cannot verify parity without a golden contract."
            exit 1
        fi

        # Actual parity check is PENDING until runtime adapters are implemented.
        # When adapters exist, this block should:
        #   1. Submit fixture Input Command to each runtime
        #   2. Normalize raw output to Behavior Envelope table format
        #   3. Diff normalized output against golden Behavior Envelope
        #   4. Report PASS / FAIL per runtime
        echo "  Claude Code  : PENDING (runtime adapter not yet implemented)"
        echo "  Codex        : PENDING (runtime adapter not yet implemented)"
        echo "  Antigravity  : PENDING (runtime adapter not yet implemented)"
    done

    if [ "$matched" -eq 0 ] && [ "$target_id" != "ALL" ]; then
        echo "ERROR: unknown fixture id '$target_id'. Use --list to see available fixtures."
        exit 1
    fi
}

# Main dispatch
case "${1:-}" in
    --help|-h)
        usage
        exit 0
        ;;
    --list)
        list_fixtures
        exit 0
        ;;
    --check-structure)
        check_structure
        exit $?
        ;;
    "")
        check_structure || exit 1
        echo ""
        run_fixture ALL
        echo ""
        echo "All fixture checks complete. Status: PENDING (runtime adapters not implemented)."
        echo "NOTE: Exiting 2 — parity not verified yet. 0=pass, 1=structural error, 2=pending."
        exit 2
        ;;
    f0[0-9])
        check_structure || exit 1
        run_fixture "$1"
        exit 2
        ;;
    *)
        echo "Unknown option: $1"
        usage
        exit 1
        ;;
esac
