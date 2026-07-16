extern printf
section .data
msgin db "Write your message:",0
len_msgin equ $-msgin-1
msgkey db "Write your key:",0
len_msgkey equ $-msgkey-1
msg db "%d/",0
section .bss
user_string resb 4096
user_key resq 16
section .text
global main
    main:
push rbp
mov rbp,rsp
    call write_number
    mov rax,1
    mov rdi,1
    mov rsi,msgin
    mov rdx,len_msgin
    syscall
    mov rax,0
    mov rdi,0
    mov rsi,user_string
    mov rdx,4096
    syscall
    
    mov rcx,rax
    dec rcx
    jz exit
    mov r14,user_string
    mov r12,0
    jloop:
    mov r13,rcx
    mov rdi,msg
    movzx rsi,byte [r14+r12]
    mov rax, [user_key]
    xor rsi,rax
    mov rax,0
    call printf
    mov rcx,r13
    inc r12
    loop jloop
    exit:
leave
ret

write_number:
push rbp
mov rbp,rsp
    mov rax,1
    mov rdi,1
    mov rsi,msgkey
    mov rdx,len_msgkey
syscall
    mov rax,0
    mov rdi,0
    mov rsi,user_key
    mov rdx,16
syscall
    mov rcx,rax
    dec rcx
    jz wr_exit
    mov r14,user_key
    mov r12,0
    mov r8,10
    mov r13,0
    poploop:
    movzx rbx,byte [r14+r12]
    sub rbx,48
    mov rax,r13
    mul r8
    mov r13, rax
    add r13,rbx
    inc r12
    loop poploop
    mov [user_key],r13
wr_exit:
leave
ret

