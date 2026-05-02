# WannaCry Ransomware 

> **Course:** Malware Analysis  
> **Due Date:** April 29, 2026  
> **Subject:** WannaCry Ransomware (May 2017 Global Outbreak)  
> **Sample SHA256:** `24d004a104d4d54034dbcffc2a4b19a11f39008a575aa614ea04703480b1022c`

---

## Important Notice

**No malware binaries are stored in this repository.**  
All analysis was performed exclusively inside an isolated virtual machine environment.  
Malware was never executed on a host system at any point during this project.

---

## Project Overview

This repository documents a complete structured malware analysis of **WannaCry**, the self-propagating ransomware worm that infected over 200,000 systems across 150 countries on May 12, 2017. The analysis covers all five required project phases using industry-standard tools and methodology.

WannaCry is significant because it combined:
- A leaked NSA exploit (**EternalBlue / MS17-010**) for initial access via SMBv1
- A self-propagating **worm** component for lateral movement
- A **ransomware** payload encrypting files with hybrid AES-128 / RSA-2048 encryption
- An accidental **kill switch** discovered and triggered by researcher Marcus Hutchins

---

## Repository Structure
wannacry-analysis/
├── README.md

├── .gitignore

├── static-analysis/

│   ├── hashes.txt

│   ├── strings-output.txt

│   ├── pe-sections.txt

│   └── imports.txt

├── assembly-analysis/

│   ├── kill-switch-region.asm

│   ├── encryption-loop-region.asm

│   └── unpacking-stub.asm

├── dynamic-analysis/

│   ├── procmon-findings.md

│   ├── network-observations.md

│   ├── registry-changes.md

│   └── memory-analysis.md

├── reports/

│   └── ioc-list.md

├── tools/

│   └── tool-list.md

└── screenshots/

├── phase1/

├── phase2/

├── phase3/

├── phase4/

└── phase5/
---

## Analysis Phases

| Phase | Title | Status | Wiki Link |
|---|---|---|---|
| 1 | Environment Setup | ✅ Complete | [View →](../../wiki/Phase-1-Environment-Setup) |
| 2 | Static Analysis | ✅ Complete | [View →](../../wiki/Phase-2-Static-Analysis) |
| 3 | Assembly-Level Analysis | ✅ Complete | [View →](../../wiki/Phase-3-Assembly-Level-Analysis) |
| 4 | Dynamic and Memory Analysis | ✅ Complete | [View →](../../wiki/Phase-4-Dynamic-and-Memory-Analysis) |
| 5 | Behavior and Defense | ✅ Complete | [View →](../../wiki/Phase-5-Behavior-and-Defense) |

> Full technical documentation is in the **[GitHub Wiki](../../wiki)**.

---

## Key Findings Summary

| Finding | Detail |
|---|---|
| **Kill Switch** | Hardcoded domain — resolves → malware exits |
| **Embedded Payload** | Password-protected ZIP in `.rsrc` section (entropy ~7.9), password: `WNcry@2ol7` |
| **Encryption Scheme** | AES-128 per file, RSA-2048 wraps AES key |
| **Persistence** | Windows service `mssecsvc2.0` disguised as Microsoft Security Center |
| **Anti-Recovery** | `vssadmin delete shadows /all /quiet` destroys all Volume Shadow Copies |
| **Spreading** | EternalBlue (MS17-010) SMB exploit on port 445 |
| **C2 Channel** | Tor network via bundled client, ports 9001/9003 |

---

## Tools Used

| Tool | Phase | Purpose |
|---|---|---|
| PEStudio | Static | PE inspection, strings, entropy, imports |
| CFF Explorer | Static | Detailed PE header analysis |
| Ghidra | Assembly | Disassembly and decompilation |
| x64dbg | Assembly / Dynamic | Debugger |
| Process Monitor | Dynamic | File system and registry monitoring |
| Process Hacker | Dynamic | Process and memory inspection |
| Wireshark | Dynamic | Network traffic capture |
| FakeNet-NG | Dynamic | Network simulation |
| Autoruns | Dynamic | Persistence detection |

---

## Safe Handling Statement

This project was conducted in full compliance with safe malware handling practices:
- All analysis performed inside an isolated **Windows 7 SP1 x64** virtual machine
- VM network adapter set to **Host-Only** mode — no external connectivity
- Kill switch domain blocked via hosts file to allow payload observation
- **Clean snapshots** restored between each analysis run
- No malware binaries are stored in this repository at any time
