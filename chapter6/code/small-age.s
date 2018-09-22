#  $ as --32 read.s -o read.o
#  $ as --32 count-chars.s -o count-chars.o
#  $ as --32 write-newline.s -o write-newline.o
#  $ as --32 large-age.s -o large-age.o
#  $ ld -m elf_i386 read.o count-chars.o write-newline.o large-age.o -o large-age
#  $ ./large-age
#  $ echo $status 
#  45

        .include "linux.s"
        .include "record-def.s"

        .section .data
file_name:
        .ascii "test.dat\0"

        .section .bss
        .lcomm record_buffer, RECORD_SIZE
        .lcomm max_item, 4

        .section .text
        .globl _start
_start:
        .equ ST_INPUT_DESCRIPTOR, -4
        .equ ST_OUTPUT_DESCRIPTOR, -8

        movl %esp, %ebp
        subl $8, %esp

        movl $SYS_OPEN, %eax
        movl $file_name, %ebx
        movl $0, %ecx
        movl $0666, %edx
        int $LINUX_SYSCALL

        movl %eax, ST_INPUT_DESCRIPTOR(%ebp)
        movl $STDOUT, ST_OUTPUT_DESCRIPTOR(%ebp)

        movl $0, max_item

record_read_loop:
        pushl ST_INPUT_DESCRIPTOR(%ebp)
        pushl $record_buffer
        call read_record
        addl $8, %esp

        cmpl $RECORD_SIZE, %eax
        jne finished_reading

        movl $RECORD_AGE + record_buffer, %ebx
        movl (%ebx), %ebx

        movl max_item, %eax
        cmpl %eax, %ebx
        jge swap
        jmp record_read_loop

swap:
        movl %ebx, max_item
        jmp record_read_loop

finished_reading:
        movl max_item, %ebx
        
        movl $SYS_EXIT, %eax
        int $LINUX_SYSCALL
