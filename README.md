# eco-lab

Lab workspace for **Emil Chronicle Online / 伊希歐之夢 / 埃米爾物語** server research.

This repository is **not** a playable private server and **does not** include the official game client.

Upstream emulator authors already state the open-source core is incomplete (login, create character, move). This lab keeps three public codebases usable together **without merging them into one process**.

## Roles of the three upstream repos

| Role | Upstream | Why it is here |
| --- | --- | --- |
| **core** (runtime) | [cm-MMK-2/EcoServerEmulator](https://github.com/cm-MMK-2/EcoServerEmulator) | Clean Login / World / Map split, Apache-2.0, targets 2017-08-31 JP client |
| **ref-saga** (library) | [karorogunso/SagaECO](https://github.com/karorogunso/SagaECO) | Historical scripts, jobs, maps — read-only reference |
| **ref-docker** (ops) | [tarathep/SagaECO](https://github.com/tarathep/SagaECO) | Compose / config layout ideas — GPL-3.0, do not paste into core |

Do **not** compile the three solutions into one binary.  
Do **not** import both Emulator SQL and Saga SQL into the same schema.

Target client (when you already have it): JP end-of-service build (`eco.ver` = 506, 2017-08-31). This repo does not distribute that client.

## Layout

```text
contract/     shared contracts (opcodes, process boundaries, DB map)
docker/       container definitions
tests/        contract + compose tests (run in CI)
scripts/      clone / bootstrap helpers
notes/        week-1 checklist
```

## Quick start

```bash
git clone https://github.com/stevetsang852/eco-lab.git
cd eco-lab
python3 -m pip install -r tests/requirements.txt
python3 -m pytest tests -q
```

Clone the three upstream trees next to this repo (not vendored, so licences stay separate):

```bash
./scripts/bootstrap.sh
```

MySQL only (no game binaries in CI):

```bash
docker compose up -d mysql
```

## Runtime ports (EcoServerEmulator)

| Process | Port |
| --- | --- |
| WorldServer | 17831 |
| LoginServer | 17832 |
| MapServer | 17833 |

Start order after you build core yourself: World → Login → Map.

## Licence

Original files in this repository are **Apache-2.0**.

- EcoServerEmulator is Apache-2.0.
- tarathep/SagaECO is GPL-3.0 — use it as a reference, do not copy source into this tree if you want to keep Apache-2.0.

## Status

- [x] Contract templates
- [x] Docker Compose (MySQL + test runner)
- [x] GitHub Actions CI
- [ ] Local core compile (needs .NET Framework 4.5.2 / Windows or a compatible toolchain)
- [ ] Confirmed handshake against a 2017 client you already own
