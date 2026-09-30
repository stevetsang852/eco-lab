# TODO — next AI follow-up

Check boxes in PRs. Do not skip the order.

## P0 — unblock runtime

- [ ] Fork https://github.com/cm-MMK-2/EcoServerEmulator to stevetsang852
- [ ] Point README / handoff at that fork URL
- [ ] Document local .NET 4.5.2 build steps (Windows)
- [ ] Import only Emulator `sql/eco.sql` into lab MySQL
- [ ] Owner: confirm `eco.ver` is 506; `server.lst` → 127.0.0.1 and matching ports

## P0 — packet ruler

- [ ] Decrypt-side dump: Login `001F` UserLogin
- [ ] Decrypt-side dump: Map `11FE` RequestMove and `11F8` CharaMove
- [ ] Capture template used once for login (file in `contract/captures/`, no secrets)
- [ ] Capture template used once for one-tile walk
- [ ] Reclassify those opcodes as `client-replayed` in notes (keep yaml status rules consistent)

## P1 — lab tooling

- [ ] Forward-only TCP proxy (log unknown opcodes; do not mutate packets)
- [ ] CI test that capture YAML required keys exist (`note` mandatory)
- [ ] Coordinate write-back ticket: Map move → `CharaData.X/Y/Dir`

## P2 — first new feature after ruler

- [ ] One NPC talk packet (guessed → handler → client confirm)
- [ ] Still no full Saga SQL import

## P3 — Airtest / ML (blocked until P0 ruler green)

- [ ] ML-0: Airtest script login + walk using **rules**, not LLM
- [ ] Every Airtest action writes a packet capture with `note`
- [ ] ML-1: OCR dialogue + scene label JSON schema
- [ ] `Brain` interface stub only after ML-0 works
- [ ] Do not train RL until backend events exist

## Done

- [x] eco-lab repo, contracts, docker-compose, GitHub Actions
- [x] opcodes.yaml from Emulator Interface.json
- [x] Dev/debug loop written into README + handoff
