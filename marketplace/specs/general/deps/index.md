# Dependency Capability Sheets

> **Purpose**: Source-verified facts about direct dependencies. Prevents LLM prior assumptions from overriding actual library behavior.

---

## Why This Exists

AI agents carry training-data assumptions about libraries that may be outdated or wrong. When research reports get archived with completed tasks, those verified facts disappear from future sessions. Capability sheets persist in spec/ and get injected via jsonl into every relevant task.

**Rule**: Every fact must cite `file:line` from the reference source code. README-only claims are marked `[unverified]`.

---

## Available Sheets

<!-- Add your dependency sheets here -->
| Dependency | Sheet | When to inject |
|-----------|-------|---------------|
| _example_ | [example.md](./example.md) | _Tasks touching this dependency_ |

---

## Research Quality Rule

When investigating direct dependencies (listed in `pyproject.toml` / `package.json`):
- If `reference/<dep>/` or local source exists, **read source code** to verify claims. Give `file:line` citations.
- README-only claims without source verification must be marked `[unverified]`.
- Do not rely on LLM training data for dependency behavior — libraries evolve faster than training cuts.

## Sheet Format

Each sheet should follow this structure (keep under 120 lines):

```markdown
# <Dependency Name> Capability Sheet

> Source-verified from reference/<dep>/ source code. Version: X.X.X

## Defaults (verified)
| Config | Default | Source |
|--------|---------|--------|
| ... | ... | `file.py:42` |

## API Surface
...

## Known Limitations
1. **issue** (source citation)

## Version Info
- Wrapper: X.X.X
- Python/Node: >=X.X
```

## Maintenance

- Update sheets when dependency source is pulled to a new version
- After any task that discovers new dep facts, check and update the sheet (workflow Phase 3.3)
- Keep each sheet concise — verified facts only, no tutorials
