# TODO — next AI follow-up

Do not skip the order.
Playbooks: [REVERSE.md](REVERSE.md) · [CLOSED_LOOP.md](CLOSED_LOOP.md) · [DEV_DEBUG.md](DEV_DEBUG.md)

## P0 — runtime + packet ruler (NOW)

- [ ] Confirm fork https://github.com/stevetsang852/EcoServerEmulator exists; if 404, fork cm-MMK-2/EcoServerEmulator
- [ ] Point README / handoff at that fork URL
- [ ] Document .NET 4.5.2 Windows build on the fork README
- [ ] Import only Emulator `sql/eco.sql`
- [ ] Owner: `eco.ver` 506; `server.lst` → 127.0.0.1 + ports 17831/17832/17833
- [ ] Post-decrypt dump: Login `001F` (server-side first; client hook only if needed)
- [ ] Post-decrypt dump: Map `11FE` / `11F8`
- [ ] One login + one walk YAML in `contract/captures/` (no secrets)

## P1 — proxy + coords

- [ ] Forward-only TCP proxy (log unknown opcodes; do not mutate)
- [ ] CI: capture YAML requires `note`
- [ ] Map move writes `CharaData.X/Y/Dir`

## P1b — RE only if server dump is ciphertext

- [ ] Static: locate crypto vs Emulator Encryption/PacketKey
- [ ] Optional Frida hook send/recv after decrypt on owner PC
- [ ] Do not start Ghidra marathon before trying server-side dump

## P2 — Redis events (after ruler works)

- [ ] Redis 7 in compose; publish `eco:events` for `001F`/`11FE`/`11F8` only
- [ ] Read-only Telemetry stub

## P3+ — Airtest / Brain blocked until P0 green

See previous TODO P3–P5. No LLM, no RL yet.

## Done

- [x] eco-lab contracts, CI, compose, closed-loop + Redis draft
- [x] RE / tap playbook
