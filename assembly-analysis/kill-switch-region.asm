; WannaCry Kill Switch Assembly Region
; Tool: Ghidra 11.x - File: wcry.exe
; Documentation only - cannot be assembled or executed
; Unresolved symbolic references throughout

; Open internet session
PUSH    0
PUSH    0
PUSH    0
PUSH    1
PUSH    offset agent_string
CALL    InternetOpenA
MOV     [hInternet], EAX

; HTTP request to hardcoded domain
PUSH    0
PUSH    0
PUSH    0
PUSH    0
PUSH    offset kill_switch_url
PUSH    [hInternet]
CALL    InternetOpenUrlA

; Conditional branch - kill switch decision point
TEST    EAX, EAX
JNZ     loc_kill_switch
JMP     loc_payload_entry

loc_kill_switch:
PUSH    EAX
CALL    InternetCloseHandle
PUSH    0
CALL    ExitProcess

; Pattern: API Call InternetOpenUrlA performs network check
; Pattern: Conditional Branch TEST EAX and JNZ is the decision point
; If domain resolves handle is non-NULL and JNZ jumps to ExitProcess
; If domain not found EAX is NULL and execution falls to payload
; Authors intended this as anti-sandbox evasion
; Researcher registered the domain causing global termination
