# Client — backend tap and protocol RE

Goal: reverse **network protocol + client behaviour**, not the whole game.
Maps, drops, quests, economy are not complete inside `eco.exe`. Fill those later from data/scripts, not from one binary.

## Boundary

- Lab only (`127.0.0.1`). No third-party private servers.
- Do not commit client binaries, keys, or passwords.
- Interoperability research for a discontinued title. Public commercial private servers are a copyright risk — owner decides.
- No cheats, no item-dupe design.

## Three tracks

| Track | What | Output |
| --- | --- | --- |
| Static | Ghidra / strings on `eco.exe` | crypto constants, opcode hints |
| Dynamic | hook `send`/`recv` after decrypt | plaintext opcode + payload |
| Network | Wireshark / forward-only proxy | raw TCP (often ciphertext) |

**Must dump after decrypt.** Match Emulator `Encryption.cs` / `PacketKey.cs`, or hook client after decrypt / before encrypt.

Typical frame (verify, do not assume): `size (2) + opcode (2) + payload`.

## Lab order

1. Client 506. `server.lst` → lab.
2. Server-side post-decrypt dump on Login `001F` and Map `11FE` (preferred first — no debugger required).
3. If dump is still garbage: static match vs Emulator crypto, then optional Frida/`send` hook on owner Windows.
4. One action per capture + required `note` → `contract/captures/`.
5. `guessed` in `opcodes.yaml` until owner replay matches screen → then `confirmed`.
6. Implement handler only on the **EcoServerEmulator fork**. Saga = read-only library.

## What client cannot give you

Mob AI, drop tables, quest predicates, economy formulas. Do not stall P0 looking for those in the exe.

## Tools (owner machine)

Ghidra, x64dbg, Frida, Wireshark, Process Monitor. Cheat Engine only as a memory *observer* in lab, not for publishing trainers.
