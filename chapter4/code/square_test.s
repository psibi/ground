        # Instructions for running this program
        # $ as --32 isolated_square.s -o isolated_square.o
        # $ as --32 square_test.s -o square_test.o
        # $ ld -m elf_i386 isolated_square.o square_test.o -o square_test
        # $ ./square_test
        # $ echo $?
        # 144
        .section .data

        .section .text

        .globl _start

_start:

        pushl $12
        call square
        addl $4, %esp

        movl %eax, %ebx
        movl $1, %eax
        int $0x80
