extern printf
section .data
ed db "hello nigger",0
len equ $-ed
key db 65
msg db "%d",10,0
section .bss
section .text
global main
    main:
push rbp
mov rbp,rsp
    mov rcx,len
    mov r14,ed
    mov r12,0
    jloop:
    mov r13,rcx
    mov rdi,msg
    movzx rsi,byte [r14+r12]
    movzx rax, byte [key]
    xor rsi,rax
    mov rax,0
    call printf
    mov rcx,r13
    inc r12
    loop jloop
leave
ret

