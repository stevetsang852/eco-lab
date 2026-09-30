# Dev and debug playbook

## Failure table

| Symptom | Check first |
| --- | --- |
| Client drops instantly | VersionCheck `0001`, crypto key, ports |
| Login fail | Account row, legacy MD5 password field, `001F` reply |
| Char created, no map | `0032` RequestMapServer, Map 17833 up |
| Avatar stuck | `11FE` hit handler? coords written? `11F8` reply? |
| Packets but no UI | Reply opcode/length wrong |
| Only ciphertext | Dump is before decrypt |

Need three artifacts to change code: action note, ~20 log lines around it, disconnect yes/no.

## Capture line format

```text
ts,process,dir,opcode,len,hex,note
```

YAML wrapper: `contract/captures/TEMPLATE.yaml`.
