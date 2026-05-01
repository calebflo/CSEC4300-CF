# Process Monitor Findings

**Tool:** Sysinternals Process Monitor
**Filter:** wcry.exe and tasksche.exe
**Setup:** Clean snapshot restored. Kill switch domain blocked in hosts file.

---

## Process Execution Chain

wcry.exe
cmd.exe
vssadmin.exe  delete shadows /all /quiet
bcdedit.exe   set recoveryenabled No
bcdedit.exe   set bootstatuspolicy ignoreallfailures
icacls.exe    grant Everyone full permissions
tasksche.exe
@WanaDecryptor@.exe

All anti-recovery commands completed within 3 to 5 seconds of infection.
This occurred before the ransom note appeared and before significant encryption began.

---
## Files Dropped to Disk

| Path | Description |
|---|---|
| C:\ProgramData\tasksche.exe | Ransomware encryption payload |
| C:\ProgramData\r.wry | Attacker RSA-2048 public key |
| C:\ProgramData\s.wry | Encrypted session data |
| C:\ProgramData\t.wry | Encrypted configuration data |
| C:\Windows\mssecsvc.exe | Worm spreading service component |
| C:\Windows\tor\taskhsvc.exe | Bundled Tor client for C2 |
| Affected directories\@Please_Read_Me@.txt | Text format ransom note |
| Affected directories\@WanaDecryptor@.exe | Ransom note GUI executable |
| Affected directories\filename.WNCRY | Encrypted versions of victim files |

---

## Encryption Rate

tasksche.exe encrypted approximately 50 to 100 files per second.
Enumeration covered all user directories and mapped network drives.
Over 170 file extensions were targeted including documents images and databases.

---

## Registry Changes Observed

| Key | Value | Data |
|---|---|---|
| HKLM\...\Services\mssecsvc2.0 | DisplayName | Microsoft Security Center (2.0) Service |
| HKLM\...\Services\mssecsvc2.0 | Start | 2 meaning AUTO_START |
| HKLM\...\Services\mssecsvc2.0 | ImagePath | C:\Windows\mssecsvc.exe |
| HKCU\Software\WanaCrypt0r | wd | Working directory path |
| HKLM\SOFTWARE\WanaCrypt0r | wd | Working directory path |
