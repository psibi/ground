# $ as --32 buffer.s -o buffer.o
# $ ld -m elf_i386 buffer.o -o buffer
# $ ./buffer
# fish: “./buffer” terminated by signal SIGSEGV (Address boundary error)
# This program demonstrates the wrong way of using SAMPLE_BUFFER
# https://stackoverflow.com/a/52247960/1651941
        
        .section .text

        .section .bss

        .lcomm SAMPLE_BUFFER, 8

        .globl _start

_start:

        movl $SAMPLE_BUFFER, %ebx

        movl $1, %eax
        int $0x80
