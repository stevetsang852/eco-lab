# Database map

Authoritative schema for lab work is EcoServerEmulator `sql/eco.sql`.
Saga tables are a dictionary only. Never load both full dumps into one database.

## Minimum tables (core)

| Table | Purpose | Status |
| --- | --- | --- |
| Account | username / password / slots | confirmed in emulator SQL |
| Chara | appearance, job, map id | confirmed |
| CharaData | X/Y/Dir, HP/MP/SP | confirmed |

## Later (do not import yet)

Saga item / skill / quest tables stay in ref-saga until a single feature is ported into core.

## Account rule

Insert test accounts yourself. Do not reuse random internet dumps.
Password field in the upstream sample dump is an MD5 hex string — treat it as legacy, not as a production auth design.
