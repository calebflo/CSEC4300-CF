# Registry Changes

**Tool:** Process Monitor registry filter and Autoruns
**Baseline:** Autoruns snapshot taken before execution

---

## Service Persistence Key Created

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mssecsvc2.0

| Value | Type | Data |
|---|---|---|
| DisplayName | REG_SZ | Microsoft Security Center (2.0) Service |
| ImagePath | REG_EXPAND_SZ | C:\Windows\mssecsvc.exe |
| ObjectName | REG_SZ | LocalSystem |
| Start | REG_DWORD | 2 meaning SERVICE_AUTO_START |

The display name deliberately mimics a legitimate Windows security service.
SERVICE_AUTO_START ensures the worm component runs on every system boot.
Running as LocalSystem provides maximum system privileges.

---

## Configuration Keys Created

HKEY_CURRENT_USER\Software\WanaCrypt0r
Value wd equals the working directory path

HKEY_LOCAL_MACHINE\SOFTWARE\WanaCrypt0r
Value wd equals the working directory path

The WanaCrypt0r key name is a highly distinctive IOC.
Its presence on any system definitively indicates infection.

---

## Remediation Commands

sc stop mssecsvc2.0
sc delete mssecsvc2.0
reg delete HKCU\Software\WanaCrypt0r /f
reg delete HKLM\SOFTWARE\WanaCrypt0r /f

Note: Registry cleanup alone does not decrypt files. Full system reimaging is recommended.
