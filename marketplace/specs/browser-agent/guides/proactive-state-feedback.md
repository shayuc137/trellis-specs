# Proactive State Feedback Principle

> The browser proactively presents information to humans. It should do the same for agents.

## Core Idea

When humans use a browser, all state changes are **proactively presented** — dialogs pop up in front of them, the address bar updates after navigation, new tabs appear in the tab bar, loading indicators spin. Humans don't need to "query" these things; they naturally appear in view.

Agents should have the same experience. Every operation's return value should **proactively include all state changes caused by the operation**. Agents should not need to guess, poll, or query.

## Design Rules

### 1. Return value = operation result + state changes

An operation's return value includes both "success/failure" and what changed in the browser:

```
Operation succeeded + dialog appeared:
  ok=true, action=click, dialog={type: confirm, message: "Delete this?"}

Operation succeeded + page navigated:
  ok=true, action=click, navigation={url: "https://...", title: "..."}

Operation succeeded + new tab opened:
  ok=true, action=click, new_tab={id: 2, url: "https://..."}
```

### 2. Blocking reasons must be explicit

When an operation fails because a prerequisite state was not handled, the return value must explain **why it's blocked** and **how to unblock**:

```
Blocked by dialog:
  ok=false, error=blocked_by_dialog,
  dialog={type: confirm, message: "..."}

Target in iframe:
  ok=false, error=element_in_frame,
  frame={name: "payment", url: "..."}
```

### 3. Don't decide for the agent

The browser layer provides complete information and lets the agent decide. Avoid timeout auto-handling, silently swallowing state changes, or other behaviors that decide for the agent.

Exception: `alert` and `beforeunload` can be auto-accepted (these rarely need agent judgment), but should still be recorded in the return value.

### 4. Information travels with the triggering operation

State changes ride along with the return value of the operation that triggered them. If a click triggered a dialog, the dialog info is in the click's return value — no need to call `dialog status` separately.

Query commands (`dialog status`, etc.) serve as backup (agent wants to re-check known pending state), not as the primary information source.

### 5. Sparse return values

- Null/empty fields: omit entirely (tool docs define: field absence = not applicable)
- Zero values: keep (`pending_requests: 0` means "confirmed none pending")
- Semantic false: keep (`expanded: false` is meaningful)
- Hints: don't repeat in return values — document in Skill/MCP tool descriptions

## Applicable Scenarios

| Scenario | State change | Return field |
|----------|-------------|-------------|
| Dialog appears | type + message + defaultValue | `dialog` |
| Page navigation | new URL + title | `navigation` |
| New tab opens | tab id + URL | `new_tab` |
| Page load state | loading / loaded / networkidle | load_state in navigate |
| Element in iframe | frame name + URL | error info on failure |
| Download triggered | filename + path | `download` |
| Fill/select value | confirmed current value | `current_value` |

## Boundary

This principle applies to **synchronous state changes** directly caused by an operation. For asynchronous events (WebSocket messages, timer-triggered DOM changes), the agent still needs to actively check via snapshot or wait.

## Origin

Distilled from Phase 5g brainstorm discussion on dialog handling approaches. The key insight: agent-browser-cli's "silently suppress all dialogs" approach is simple but strips the agent of decision-making power. This principle pushes further: state changes should be proactively presented, as naturally as a human experiences the browser.
