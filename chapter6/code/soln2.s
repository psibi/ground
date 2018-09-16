# $ as --32 soln2.s -o soln2.o
# $ as --32 write.s -o write.o
# $ ld -m elf_i386 soln2.o write.o -o soln2
# $ ./soln2
# $ cat testsol2.dat

        .include "linux.s"
        .include "record-def.s"

        .section .data

record1:
        .ascii "Fredrick\0"
        .rept 31
        .byte 0
        .endr

        .ascii "Bartlett\0"
        .rept 31
        .byte 0
        .endr

        .ascii "4242 S Prairie\nTulsa, OK 55555\0"
        .rept 209
        .byte 0
        .endr

        .long 45

file_name:
        .ascii "testsol2.dat\0"

        .equ ST_FILE_DESCRIPTOR, -4
        .globl _start

_start:
        movl %esp, %ebp
        subl $4, %esp
        movl $SYS_OPEN, %eax
        movl $file_name, %ebx
        movl $0101, %ecx
        movl $0666, %edx
        int $LINUX_SYSCALL

        movl %eax, ST_FILE_DESCRIPTOR(%ebp)

        movl $0, %esi
start_loop:
        cmpl $30, %esi
        je loop_end

        pushl ST_FILE_DESCRIPTOR(%ebp)
        pushl $record1
        call write_record
        addl $8, %esp

        incl %esi
        jmp start_loop

loop_end:
        movl $SYS_CLOSE, %eax
        movl ST_FILE_DESCRIPTOR(%ebp), %ebx
        int $LINUX_SYSCALL

        movl $SYS_EXIT, %eax
        movl $0, %ebx
        int $LINUX_SYSCALL
        
       
