# eco-lab

Lab workspace for **Emil Chronicle Online / 伊希歐之夢 / 埃米爾物語**.

**Not** a playable private server. **Does not** ship the official client.
Owner has a local black-box JP client (`eco.ver` 506, 2017-08-31).

Next-AI entry: **[notes/AI_HANDOFF.md](notes/AI_HANDOFF.md)** · TODO: **[notes/TODO.md](notes/TODO.md)**

## Roles of the three upstream repos

| Role | Upstream | Use |
| --- | --- | --- |
| **core** | [cm-MMK-2/EcoServerEmulator](https://github.com/cm-MMK-2/EcoServerEmulator) | Runtime. Login / World / Map. Apache-2.0. Fork before editing. |
| **ref-saga** | [karorogunso/SagaECO](https://github.com/karorogunso/SagaECO) | Scripts / jobs / maps. Read-only. |
| **ref-docker** | [tarathep/SagaECO](https://github.com/tarathep/SagaECO) | Compose ideas. GPL-3.0 — do not paste into this tree. |

Do **not** merge the three into one process or one SQL schema.

## Layout

```text
contract/            opcodes, boundaries, db-map, capture template
contract/captures/   packet logs (no secrets, no client binaries)
docker/              Dockerfile
tests/               contract + compose CI
scripts/             bootstrap three upstream clones
notes/               TODO, AI handoff, debug playbook
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
2. Dump **after decrypt** (Emulator `Encryption` / `PacketKey`). Raw Wireshark is usually ciphertext.
3. Log line: `ts, process, dir, opcode, len, hex, note` — `note` required.
4. Ruler packets first: login `001F`, create `00A0`, move `11FE` / `11F8`.
5. New opcode → `guessed` in `contract/opcodes.yaml` → handler in **forked** core → client screen confirms → `confirmed`.
6. CI green on eco-lab before merging contract PRs.

Do not mark `confirmed` from Discord / Bahamut / Saga6 tables alone.

## Airtest + ML (planned, not started)

Airtest = eyes/hands. Packet contract = ground truth. ML must not write DB.

Order: **ML-0 rules (login/walk)** → **ML-1 OCR/scene** → later BC / LLM / RL.
Every Airtest action must still produce a packet log that matches `opcodes.yaml`.

## Licence

This repo: Apache-2.0. Do not copy GPL Saga source here.

## Status

- [x] Contract templates + CI + compose
- [x] Dev/debug playbook written
- [ ] Fork EcoServerEmulator on `stevetsang852`
- [ ] Core compile (.NET 4.5.2)
- [ ] Handshake + move confirmed on owner client 506
- [ ] Decrypt-side hex dump on Login `001F` and Map `11FE`
- [ ] TCP proxy (forward-only)
- [ ] Airtest ML-0
