# $ as factorialmain.s -o factorialmain.o
# $ as factorial.s -o factorial.o
# $ ld -shared factorial.o -o libfactorial.so
# $ ld -L .  factorialmain.o -o factorialmain -lfactorial -dynamic-linker /lib/ld-linux.so.2
# $ env LD_LIBRARY_PATH="." ./factorialmain
# $ echo $?
# 24

        .section .data

        .section .text

        .globl _start

_start:

        pushl $4
        call factorial
        addl $4, %esp

        movl %eax, %ebx
        movl $1, %eax
        int $0x80

