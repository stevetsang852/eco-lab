# Redis schema (draft — implement in P2)

Not started. Do not add Redis writes in C# until packet ruler works.

## Keys

| Key | Type | Purpose |
| --- | --- | --- |
| `eco:session:{account}` | Hash | connection + current char id |
| `eco:char:{char_id}:pos` | Hash | `x`, `y`, `map_id` |
| `eco:events` | Stream | backend events |
| `eco:actions:queue` | List | AI → Airtest (later) |
| `eco:memory:{session_id}` | List | last N steps, TTL |

## Stream `eco:events` fields

```text
ts          iso8601
type        login | move | create_chara | item_get | disconnect | unknown
opcode      001F | 11FE | 11F8 | ...
process     login | world | map
char_id     int or -
account     hashed or lab-only name, never a password
x,y,map_id  optional
note        human action if known
```

First publishers: `001F`, `11FE`, `11F8` only.

## Telemetry (read-only)

- `GET /health`
- `GET /events?count=50`
- `GET /char/{id}/pos`

No POST that mutates game state.
