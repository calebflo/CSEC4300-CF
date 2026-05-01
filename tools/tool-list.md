# WannaCry Analysis Toolchain

All tools installed on Windows 7 SP1 x64 analysis VM unless noted.

---

## Static Analysis

| Tool | Purpose | Why Selected |
|---|---|---|
| PEStudio | PE inspection strings entropy imports | All-in-one triage tool |
| CFF Explorer | PE header and resource inspection | Granular section analysis |
| Strings Sysinternals | Raw string extraction | Configurable minimum length |

---

## Disassembly and Debugging

| Tool | Purpose | Why Selected |
|---|---|---|
| Ghidra | Disassembly and decompilation | Free NSA-developed full decompiler |
| x64dbg | Dynamic debugging | Free actively maintained |

---

## Dynamic Analysis

| Tool | Purpose | Why Selected |
|---|---|---|
| Process Monitor | File and registry monitoring | Per-process filtering |
| Process Hacker | Process tree and memory regions | Reveals RWX memory regions |
| Wireshark | Packet capture | Industry standard |
| Autoruns | Persistence detection | Before and after comparison |
| FakeNet-NG on REMnux | Network simulation | Isolated environment capture |

---

## Utility

| Tool | Purpose |
|---|---|
| CertUtil built into Windows | Hash computation MD5 SHA1 SHA256 |
| HxD hex editor | Binary file inspection |
