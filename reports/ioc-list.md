# WannaCry Consolidated IOC List

---

## File IOCs

| Indicator | Type |
|---|---|
| 24d004a104d4d54034dbcffc2a4b19a11f39008a575aa614ea04703480b1022c | SHA256 Hash |
| db349b97c37d22f5ea1d1841e3c89eb4 | MD5 Hash |
| e889544aff85ffaf8b0d0da705105dee7c97fe26 | SHA1 Hash |
| tasksche.exe | Filename |
| mssecsvc.exe | Filename |
| taskhsvc.exe | Filename |
| @WanaDecryptor@.exe | Filename |
| @Please_Read_Me@.txt | Filename |
| .WNCRY extension | Encrypted file extension |
| WANACRY! header | Magic bytes in encrypted files |
| C:\ProgramData\tasksche.exe | File path |
| C:\Windows\mssecsvc.exe | File path |
| C:\Windows\tor\taskhsvc.exe | File path |

---

## Registry IOCs

| Key | Description |
|---|---|
| HKLM\SYSTEM\CurrentControlSet\Services\mssecsvc2.0 | Persistence service key |
| HKCU\Software\WanaCrypt0r | Malware config user hive |
| HKLM\SOFTWARE\WanaCrypt0r | Malware config system hive |

---

## Network IOCs

| Indicator | Description |
|---|---|
| Kill switch domain HTTP port 80 | Anti-sandbox check domain |
| TCP port 445 | SMB exploit and worm scanning |
| TCP port 9001 | Tor C2 bootstrap |
| TCP port 9003 | Tor C2 fallback |

---

## Behavioral IOCs

| Behavior | Significance |
|---|---|
| Mass encrypted extension file creation | Active ransomware encryption in progress |
| Shadow copy deletion command | Backup destruction observed |
| Recovery mode disabled via bcdedit | Boot recovery suppressed |
| New auto-start service created | Persistence mechanism installed |
| High-volume SYN packets to port 445 | Worm propagation active |
| RWX memory region in running process | Runtime code unpacking confirmed |
| Mutex MsWinZonesCacheCounterMutexA present | Active infection confirmed |
