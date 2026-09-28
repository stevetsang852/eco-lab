# Process boundaries

Canonical runtime is EcoServerEmulator (three processes).
tarathep/SagaECO only has Login + Map — World duties must stay explicit.

| Process | Owns | Must not own |
| --- | --- | --- |
| LoginServer | account auth, character slots, hand-off token | live position, combat |
| WorldServer | which map a session belongs to, server list | packet-level movement |
| MapServer | movement, later NPC / combat | password verification |

Start order: WorldServer → LoginServer → MapServer.

Default ports (from EcoServerEmulator Program.cs):

- WorldServer: 17831
- LoginServer: 17832
- MapServer: 17833
