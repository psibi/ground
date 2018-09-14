# $ as --32 test2.s -o test2.o
# $ ld -m elf_i386 test2.o -o test2
# $ ./test2
# $ echo $status
# 0

        .section .bss

        .lcomm SAMPLE_BUFFER, 8

        .section .text

        .globl _start

_start:

        movl $8,SAMPLE_BUFFER
        mov $1, %ecx
        mov SAMPLE_BUFFER(,%ecx, 4), %ebx

        movl $1, %eax
        int $0x80
