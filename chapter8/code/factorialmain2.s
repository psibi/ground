# $ as factorialmain2.s -o factorialmain2.o
# $ as factorial.s -o factorial.o
# $ ld -shared factorial.o -o libfactorial.so
# $ ld -L .  factorialmain2.o -o factorialmain2 -lfactorial -lc -dynamic-linker /lib/ld-linux.so.2
# $ env LD_LIBRARY_PATH="." ./factorialmain2
# $ echo $?
# The factorial of 4 is 24

        .section .data

display_item:
        .ascii "The factorial of %d is %d \n\0"

        .section .text

        .globl _start

_start:

        pushl $4
        call factorial
        addl $4, %esp

        pushl %eax
        pushl $4
        pushl $display_item
        call printf

        movl $0, %ebx
        movl $1, %eax
        int $0x80

