# Memory Analysis

**Tool:** Process Hacker 2.x
**Target Process:** tasksche.exe during active encryption

---

## Memory Region Map

| Region | Permissions | Description |
|---|---|---|
| PE image base approximately 350 KB | R-X | Normal PE code mapping |
| Heap variable size | RW- | File buffers and encryption key handles |
| Suspicious region approximately 512 KB | RWX | Runtime-unpacked payload code |
| Stack approximately 1 MB | RW- | Normal process stack |

---

## RWX Region - Key Finding

Legitimate code occupies R-X regions meaning readable and executable but not writable.
Legitimate data occupies RW- regions meaning readable and writable but not executable.
A region that is both writable and executable means code was written at runtime.
This is the defining signature of a self-unpacking malware stub.

This directly confirms the Phase 3 assembly finding where VirtualAlloc was called with
PAGE_EXECUTE_READWRITE permissions. The encrypted resource section ZIP was decrypted
into this region at runtime and execution transferred into it.

---

## Loaded Modules in tasksche.exe

| Module | Purpose |
|---|---|
| kernel32.dll | Core Windows API |
| advapi32.dll | Registry services and CryptoAPI |
| wininet.dll | Internet connectivity for kill switch check |
| msvcrt.dll | C runtime library |
| ws2_32.dll | Windows Sockets API for SMB port scanning |

No injected or unusual DLLs were observed.
WannaCry relies entirely on standard Windows APIs for all functionality.

---

## Mutex

Global\MsWinZonesCacheCounterMutexA
WannaCry creates this mutex to prevent multiple instances running simultaneously.
Its presence on any system is a definitive behavioral indicator of active infection.

---

## Encryption Key Material in Memory

AES-128 key handles and RSA-2048 key blobs were visible in heap memory during encryption.
Keys are destroyed via CryptDestroyKey after each file is processed.
Key material is not stored in plaintext on disk at any point.
