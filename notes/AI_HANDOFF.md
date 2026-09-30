# AI handoff — read this first

Date: 2026-09-30
Repo: https://github.com/stevetsang852/eco-lab
GitHub user: stevetsang852

## Order

1. [TODO.md](TODO.md) P0 only.
2. Do not implement Redis/Airtest/LLM until P0 packet ruler is green.
3. Architecture for later: [CLOSED_LOOP.md](CLOSED_LOOP.md), [../contract/redis-schema.md](../contract/redis-schema.md).

## Do not

- Ship client binaries or account passwords.
- Merge three upstream servers / SQL dumps.
- Copy GPL Saga into this repo.
- Confirm opcodes without owner client replay.
- Let AI write MySQL.
- Hit third-party private servers.

## Immediate code

Fork EcoServerEmulator → post-decrypt hex dump on `001F` and `11FE`.
