# AI handoff — read this first

Date: 2026-09-30
Repo: https://github.com/stevetsang852/eco-lab
GitHub user: stevetsang852

## Order

1. [TODO.md](TODO.md) **P0 only**.
2. Protocol RE: [REVERSE.md](REVERSE.md) — server-side decrypt dump first, not Ghidra-first.
3. Later: [CLOSED_LOOP.md](CLOSED_LOOP.md), [../contract/redis-schema.md](../contract/redis-schema.md).

## Do not

- Ship client binaries or passwords.
- Merge three upstream servers / SQL dumps.
- Copy GPL Saga into this repo.
- Confirm opcodes without owner client replay.
- Let AI write MySQL.
- Connect to third-party private servers.
- Publish trainers / dupes.

## Immediate code

On fork `stevetsang852/EcoServerEmulator` (create if missing):
post-decrypt hex dump on Login `001F` and Map `11FE`.
Store sanitized captures in eco-lab `contract/captures/`.
