# $ as --32 check3.s -o check3.o
# $ ld -m elf_i386 check3.o -o check3
# $ ./check3
# fish: “./check3” terminated by signal SIGSEGV (Address boundary error)

      .section .text

      .globl _start

_start:

        .equ TEST, 5
        
        movl TEST, %ebx

        movl $1, %eax
        int $0x80
