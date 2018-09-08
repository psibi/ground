# ~/g/g/c/code (master) $ as --32 argc.s -o argc.o
# ~/g/g/c/code (master) $ ld -m elf_i386 argc.o -o argc
# ~/g/g/c/code (master) $ ./argc
# ~/g/g/c/code (master) $ echo $status
# 1
# ~/g/g/c/code (master) $ ./argc 1
# ~/g/g/c/code (master) $ echo $status
# 2
# ~/g/g/c/code (master) $ ./argc 1 2
# ~/g/g/c/code (master) $ echo $status
# 3

        .section .text

        .globl _start

_start:

        movl (%esp), %ebx
        movl $1, %eax
        int $0x80
