        .section .data

FILE_NAME:

        .ascii "heynow.txt\0"

FILE_CONTENT:

        .ascii "hello world"

        .equ NO_OF_BYTES, 11
        .equ SYS_OPEN, 5
        .equ SYS_WRITE, 4
        .equ SYS_CLOSE, 6
        .equ O_RDONLY, 0
        .equ O_CREATE_WRONLY_TRUNC, 03101

        .equ LINUX_SYSCALL, 0x80
        .equ END_OF_FILE, 0

        .section .text

        .equ ST_SIZE_RESERVE, 4
        .equ ST_FD_IN, -4

        .globl _start

_start:
        movl %esp, %ebp
        subl $ST_SIZE_RESERVE, %esp

        movl $SYS_OPEN, %eax
        movl $FILE_NAME, %ebx
        movl $O_CREATE_WRONLY_TRUNC, %ecx
        movl $0666, %edx
        int $LINUX_SYSCALL

        movl %eax, ST_FD_IN(%ebp)

        movl $SYS_WRITE, %eax
        movl ST_FD_IN(%ebp), %ebx
        movl $FILE_CONTENT, %ecx
        movl $NO_OF_BYTES, %edx
        int $LINUX_SYSCALL

        movl $SYS_CLOSE, %eax
        movl ST_FD_IN(%ebp), %ebx
        int $LINUX_SYSCALL
        
        movl $1, %eax
        int $LINUX_SYSCALL
