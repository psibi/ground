        .section .data

        .section .text

        .globl _start
        .globl square

_start:
        pushl $10

        call square
        addl $4, %esp

        movl %eax, %ebx
        movl $1, %eax
        int $0x80

        .type square,@function

square:
        pushl %ebp
        movl %esp, %ebp
        movl 8(%ebp), %eax

        imull %eax, %eax

# This code demonstrates how after execution of square section the code automatically jumps to end_square. So note that the ordering is important.        

end_square:
        movl %ebp, %esp
        popl %ebp
        ret        

