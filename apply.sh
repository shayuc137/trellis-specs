#!/bin/bash
# Apply shayu's trellis customizations that can't go through Spec Template Marketplace.
# Run after `trellis init --registry` or `trellis update`.
#
# What this does:
#   1. Patches brainstorm skill — adds research-first planning flow + deps check
#   2. Patches workflow.md — adds dependency knowledge extraction to Phase 3.3
#
# Usage:
#   curl -s https://raw.githubusercontent.com/shayuc137/trellis-specs/main/apply.sh | bash
#   # or
#   git clone https://github.com/shayuc137/trellis-specs /tmp/trellis-specs
#   bash /tmp/trellis-specs/apply.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Applying shayu's trellis customizations..."

# --- 1. Patch brainstorm skill: research-first + deps check ---

BRAINSTORM_TARGETS=(
  ".claude/skills/trellis-brainstorm/SKILL.md"
  ".agents/skills/trellis-brainstorm/SKILL.md"
)

for target in "${BRAINSTORM_TARGETS[@]}"; do
  if [ -f "$target" ]; then
    # Add research dispatch to planning flow (if not already present)
    if ! grep -q "Dispatch research subagents" "$target" 2>/dev/null; then
      sed -i '/^2\. Inspect available evidence/a\3. **Dispatch research subagents** (background, non-blocking) to investigate how reference projects handle the modules under discussion. This ensures design decisions are evidence-backed rather than assumption-based. Research should land in `{task_dir}/research/` and cover: implementation approach, API design, trade-offs, and concrete file:line references.' "$target"
      echo "  + Patched $target: research-first planning"
    fi

    # Add deps check to quality bar (if not already present)
    if ! grep -q "deps/" "$target" 2>/dev/null; then
      sed -i '/Do not start implementation/i\- If task touches direct dependencies, relevant `.trellis/spec/deps/` sheets are listed in jsonl.' "$target"
      echo "  + Patched $target: deps check in quality bar"
    fi
  fi
done

# --- 2. Patch workflow.md: dependency knowledge extraction ---

WORKFLOW=".trellis/workflow.md"
if [ -f "$WORKFLOW" ]; then
  if ! grep -q "Dependency knowledge extraction" "$WORKFLOW" 2>/dev/null; then
    sed -i '/Update the docs under.*accordingly/a\\n**Dependency knowledge extraction** `[required when task touched deps]`:\nIf this task'\''s research discovered facts about direct dependencies (packages in `pyproject.toml` / `package.json`), check whether `.trellis/spec/deps/<dep>.md` exists and is current. Update or create the capability sheet with source-verified facts (file path + line number). Research reports in `{task}/research/` get archived — deps specs persist.' "$WORKFLOW"
    echo "  + Patched $WORKFLOW: dependency knowledge extraction in Phase 3.3"
  fi
fi

echo "Done. Customizations applied."
echo ""
echo "Next steps:"
echo "  1. Fill .trellis/spec/deps/ with capability sheets for your direct dependencies"
echo "  2. Reference deps sheets in implement.jsonl/check.jsonl for relevant tasks"
