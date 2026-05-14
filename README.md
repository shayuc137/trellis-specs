# trellis-specs

shayu's Trellis Spec Template Marketplace + workflow customizations.

## Quick Start

```bash
# New project: init with browser-agent template
trellis init --registry gh:shayuc137/trellis-specs/marketplace --template browser-agent

# Existing project: append missing specs
trellis init --registry gh:shayuc137/trellis-specs/marketplace --template browser-agent --append

# Apply workflow patches (brainstorm research-first + deps extraction)
bash <(curl -s https://raw.githubusercontent.com/shayuc137/trellis-specs/main/apply.sh)
```

## Templates

| ID | Description |
|----|-------------|
| `general` | Dependency capability sheets + research quality rules. Any project. |
| `browser-agent` | General + Proactive State Feedback principle for browser automation. |

## What's Included

### Via Marketplace (spec files)

- `deps/index.md` — Dependency capability sheet framework with research quality rules
- `guides/proactive-state-feedback.md` — (browser-agent only) Operations proactively report state changes

### Via apply.sh (workflow patches)

- Brainstorm skill: research sub-agents dispatched before design decisions
- Brainstorm skill: deps spec check in jsonl quality bar
- Workflow Phase 3.3: dependency knowledge extraction step

## Why

AI agents carry training-data assumptions about libraries that may be outdated. Research reports get archived with completed tasks, losing verified facts. These specs persist knowledge and enforce research quality.
