# TODO — next AI follow-up

Do not skip the order. Closed-loop details: [CLOSED_LOOP.md](CLOSED_LOOP.md).

## P0 — runtime + packet ruler (NOW)

- [ ] Fork https://github.com/cm-MMK-2/EcoServerEmulator to stevetsang852
- [ ] Point README / handoff at that fork URL
- [ ] Document .NET 4.5.2 Windows build
- [ ] Import only Emulator `sql/eco.sql`
- [ ] Owner: `eco.ver` 506; `server.lst` → 127.0.0.1 + ports
- [ ] Decrypt dump: Login `001F`
- [ ] Decrypt dump: Map `11FE` / `11F8`
- [ ] One login capture + one walk capture in `contract/captures/` (no secrets)

## P1 — proxy + coords

- [ ] Forward-only TCP proxy
- [ ] CI: capture YAML requires `note`
- [ ] Map move writes `CharaData.X/Y/Dir`

## P2 — Redis events (after ruler works)

- [ ] Add Redis 7 to docker-compose (not in CI game path)
- [ ] Backend publish to stream `eco:events` for `001F`, `11FE`, `11F8` only
- [ ] Follow [contract/redis-schema.md](../contract/redis-schema.md)
- [ ] Read-only Telemetry stub (`GET /events`, no writes)

## P3 — Airtest ML-0 (blocked until P0 green)

- [ ] Rules-only login + walk (`test_smoke.py` on owner Windows)
- [ ] Each action writes a capture with `note`
- [ ] Decision cycle ≥ 1s; no LLM yet

## P4 — Brain / VLM (blocked until P3)

- [ ] `Brain.decide(screenshot, goal)` stub
- [ ] Perception JSON schema in CLOSED_LOOP.md
- [ ] Optional read of Telemetry to compare screen vs server
- [ ] Mismatch → pause autoplay, do not auto-write DB

## P5 — later

- [ ] One NPC talk packet
- [ ] No full Saga SQL import
- [ ] No RL until events exist and rewards are defined from backend events

## Done

- [x] eco-lab contracts, CI, compose
- [x] Dev/debug + AI handoff
- [x] Closed-loop architecture + Redis key draft documented
