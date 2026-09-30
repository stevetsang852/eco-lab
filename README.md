# eco-lab

Lab workspace for **Emil Chronicle Online / 伊希歐之夢 / 埃米爾物語**.

**Not** a playable private server. **Does not** ship the official client.
Owner has a local black-box JP client (`eco.ver` 506, 2017-08-31).

Next-AI entry: **[notes/AI_HANDOFF.md](notes/AI_HANDOFF.md)** · TODO: **[notes/TODO.md](notes/TODO.md)**

Closed-loop (planned): **[notes/CLOSED_LOOP.md](notes/CLOSED_LOOP.md)** · Redis: **[contract/redis-schema.md](contract/redis-schema.md)**

## Roles of the three upstream repos

| Role | Upstream | Use |
| --- | --- | --- |
| **core** | [cm-MMK-2/EcoServerEmulator](https://github.com/cm-MMK-2/EcoServerEmulator) | Runtime. Login / World / Map. Apache-2.0. Fork before editing. |
| **ref-saga** | [karorogunso/SagaECO](https://github.com/karorogunso/SagaECO) | Scripts / jobs / maps. Read-only. |
| **ref-docker** | [tarathep/SagaECO](https://github.com/tarathep/SagaECO) | Compose ideas. GPL-3.0 — do not paste into this tree. |

Do **not** merge the three into one process or one SQL schema.

## Layout

```text
contract/            opcodes, boundaries, db-map, redis schema, captures
docker/              Dockerfile + compose (MySQL now; Redis later)
tests/               contract + compose CI
scripts/             bootstrap three upstream clones
notes/               TODO, AI handoff, debug, closed-loop plan
```

## Quick start

```bash
git clone https://github.com/stevetsang852/eco-lab.git
cd eco-lab
python3 -m pip install -r tests/requirements.txt
python3 -m pytest tests -q
./scripts/bootstrap.sh
docker compose up -d mysql
```

## Ports (EcoServerEmulator)

| Process | Port |
| --- | --- |
| WorldServer | 17831 |
| LoginServer | 17832 |
| MapServer | 17833 |

Start order: World → Login → Map.

## Dev + debug loop (locked)

1. Client `server.lst` → lab. Only your own server.
2. Dump **after decrypt**. Raw Wireshark is usually ciphertext.
3. Log: `ts, process, dir, opcode, len, hex, note` — `note` required.
4. Ruler first: login `001F`, create `00A0`, move `11FE` / `11F8`.
5. New opcode → `guessed` → handler in **forked** core → client confirms → `confirmed`.
6. CI green before merging contract PRs.

## Closed loop (planned, do not implement before P0)

```text
AI Brain → Airtest → eco.exe → [proxy] → Backend → MySQL + Redis Stream
                ↑________________ telemetry (read-only) _____________|
```

- AI / Airtest never writes MySQL.
- Redis = session, cache, `eco:events` stream, action queue.
- MySQL = account, char, items (source of truth).
- Linux CI cannot run Airtest GUI.

Order stays: packet ruler → Redis events for `001F`/`11FE`/`11F8` → Airtest ML-0 → VLM/LLM.

## Licence

Apache-2.0. No GPL Saga source in this tree.

## Status

- [x] Contracts + CI + compose + handoff + closed-loop docs
- [ ] Fork EcoServerEmulator on `stevetsang852`
- [ ] Handshake + move on owner client 506
- [ ] Decrypt-side dump `001F` / `11FE`
- [ ] Redis `eco:events` from backend
- [ ] Airtest ML-0
