# $ as --32 test.s -o test.o
# $ ld -m elf_i386 test.o -o test
# $ ./test
# $ echo $status
# 8
        .section .bss

        .lcomm SAMPLE_BUFFER, 8

        .section .text

        .globl _start

_start:

        movl $8,SAMPLE_BUFFER
        movl SAMPLE_BUFFER, %ebx

        movl $1, %eax
        int $0x80
