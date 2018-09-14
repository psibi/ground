# $ as --32 test5.s -o test5.o
# $ ld -m elf_i386 test5.o -o test5
# $ ./test5
# $ echo $status
# 8
        .section .bss

        .lcomm SAMPLE_BUFFER, 8

        .section .text

        .globl _start

_start:

        movl $8,SAMPLE_BUFFER

        movl $SAMPLE_BUFFER, %ecx
        movl (%ecx), %ebx

        movl $1, %eax
        int $0x80
