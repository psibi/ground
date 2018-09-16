# $ as --32 check1.s -o check1.o
# $ ld -m elf_i386 check1.o -o check1
# $ ./check1
# $ echo $status
# 97

        .section .data

data_items:

        .ascii "aaa"

        .section .text

        .globl _start

_start:

        movl data_items, %ebx
        movl $1, %eax
        int $0x80
