# AI handoff — read this first

Date: 2026-09-30
Repo: https://github.com/stevetsang852/eco-lab
GitHub user: stevetsang852

## What this project is

Research lab for a discontinued JP MMORPG server emulator.
Owner has a **black-box official client** (target `eco.ver` 506).
This repo is contracts + CI. Runtime code lives in a **fork** of EcoServerEmulator (not created yet).

## Do / do not

Do:
- Update contracts, tests, notes, capture templates here.
- Propose C# handler changes for the Emulator fork only.
- Compare opcodes to Emulator `*Interface.json` and Saga scripts as `guessed` until owner replay.

Do not:
- Ship or link pirated client archives.
- Merge Emulator + Saga + tarathep into one binary or one MySQL schema.
- Copy GPL files from tarathep/SagaECO into this Apache-2.0 tree.
- Mark opcodes `confirmed` without an owner client replay.
- Implement game cheats, item-dupe, or attacks on third-party private servers.
- Let Airtest/LLM write the game database.

## Current truth

- Ports: World 17831, Login 17832, Map 17833.
- Known Interface.json ids are in `contract/opcodes.yaml` (status confirmed = seen in Emulator JSON, **not** yet replayed on owner client).
- CI: GitHub Actions `ci.yml` runs pytest on contracts.
- Client: owner has it locally. You cannot attach to it remotely.

## Immediate next work (do in this order)

See [TODO.md](TODO.md). First code tasks:

1. Fork `cm-MMK-2/EcoServerEmulator` → `stevetsang852/EcoServerEmulator`.
2. Add post-decrypt hex dump on Login UserLogin (`001F`) and Map RequestMove (`11FE`).
3. Add `tests/test_captures.py` if capture YAML samples grow.
4. Do **not** start Airtest/LLM until login+walk packet ruler works.

## How owner will give you data

They paste a capture with a human `note` (e.g. “walk one tile north”).
Sanitize passwords. Store under `contract/captures/`.

## Airtest / ML later

Planned only. ML-0 = Airtest rules for login/walk.
ML-1 = OCR + scene class.
Brain.decide(screenshot, task) comes after packet ruler is green.
Reward later from server events, not from clicking pixels alone.
