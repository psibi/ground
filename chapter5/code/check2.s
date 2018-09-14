# $ as --32 check.s -o check.o
# $ ld -m elf_i386 check.o -o check
# $ ./check
# $ echo $status
# 97 -- ascii value

      .section .text

      .globl _start

_start:

        .equ TEST, 'a'
        
        movl $TEST, %ebx

        movl $1, %eax
        int $0x80
