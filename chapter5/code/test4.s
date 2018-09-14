# $ as --32 test4.s -o test4.o
# $ ld -m elf_i386 test4.o -o test4
# $ ./test4
# $ echo $status
# 144 -- seems to be address
        .section .bss

        .lcomm SAMPLE_BUFFER, 8

        .section .text

        .globl _start

_start:

        movl $8,SAMPLE_BUFFER
        movl $SAMPLE_BUFFER, %ebx

        movl $1, %eax
        int $0x80
