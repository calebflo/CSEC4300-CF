; WannaCry File Encryption Loop
; Tool: Ghidra 11.x - File: tasksche.exe
; Documentation only - cannot be assembled or executed
; Unresolved symbolic references throughout

LEA     EAX, [EBP - sizeof_WIN32_FIND_DATA]
PUSH    EAX
PUSH    offset search_path
CALL    FindFirstFileW
MOV     [EBP + file_handle], EAX
CMP     EAX, 0FFFFFFFFh
JE      loc_done

loc_loop:
    LEA     EAX, [EBP + win32_find_data.cFileName]
    PUSH    EAX
    CALL    sub_check_extension
    ADD     ESP, 4
    TEST    EAX, EAX
    JZ      loc_next

    LEA     EAX, [EBP + win32_find_data.cFileName]
    PUSH    EAX
    PUSH    [EBP + current_dir]
    CALL    sub_encrypt_file
    ADD     ESP, 8

loc_next:
    LEA     EAX, [EBP - sizeof_WIN32_FIND_DATA]
    PUSH    EAX
    PUSH    [EBP + file_handle]
    CALL    FindNextFileW
    TEST    EAX, EAX
    JNZ     loc_loop

loc_done:
    PUSH    [EBP + file_handle]
    CALL    FindClose

; Pattern: LOOP - JNZ loc_loop iterates through all files
; Pattern: CONDITIONAL BRANCH - TEST EAX and JZ filters by extension
; Pattern: API CALLS - FindFirstFileW FindNextFileW FindClose
; sub_encrypt_file performs AES-128 then wraps key with RSA-2048
; Targets over 170 file extensions across all drives and network shares
