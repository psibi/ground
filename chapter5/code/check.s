# $ as --32 check.s -o check.o
# $ ld -m elf_i386 check.o -o check
# $ ./check
# $ echo $status
# 5

      .section .text

      .globl _start

_start:

        .equ TEST, 5
        
        movl $TEST, %ebx

        movl $1, %eax
        int $0x80
