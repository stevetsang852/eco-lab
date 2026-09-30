# Closed loop (planned)

```text
AI Brain (perception → decision → planner → memory)
    → Airtest (screenshot + input)
    → eco.exe 506 (black box)
    → optional proxy (decrypt log, forward only)
    → Login 17832 / World 17831 / Map 17833
    → MySQL (truth) + Redis (session, eco:events, action queue)
    → Telemetry read-only API
    → optional feedback to Brain
```

## Rules

- Brain and Airtest **never** write MySQL.
- Redis is cache / stream / queue only.
- Linux CI does not run Airtest or the client.
- 1–2 s per decision. Failures need note + ~20 log lines + disconnect flag.

## Stages (same as TODO)

0. Backend + client + MySQL manual login/walk
1. Packet ruler dumps
2. Redis `eco:events` for ruler opcodes
3. Airtest rules smoke
4. Perception VLM optional
5. LLM decision optional
6. One new system per week

## Perception JSON (later)

```json
{
  "scene": "login|field|battle|inventory",
  "char_pos": [0, 0],
  "ui_elements": [{"type": "button", "bbox": [0, 0, 0, 0], "label": ""}],
  "dialogue": ""
}
```

## Action JSON (later)

```json
{"type": "key_press", "key": "W", "duration": 0.5, "reason": "walk north"}
```
