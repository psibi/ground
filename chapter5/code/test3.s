# $ as --32 test3.s -o test3.o
# $ ld -m elf_i386 test3.o -o test3
# $ ./test3
# $ echo $status
# 8


        .section .bss

        .lcomm SAMPLE_BUFFER, 8

        .section .text

        .globl _start

_start:

        movl $8,SAMPLE_BUFFER
        mov $0, %ecx
        mov SAMPLE_BUFFER(,%ecx, 4), %ebx

        movl $1, %eax
        int $0x80
