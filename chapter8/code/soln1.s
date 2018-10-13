# %edi - Holds index of the data item being examined
# %ebx - largest data item found
# %eax - Current data item
# as soln1.s -o soln1.o
# $ ld soln1.o -o soln1 -lc -dynamic-linker /lib/ld-linux.so.2
# $ ./soln1
# 52
        
        .section .data

data_items:

        .long 5,6,7,9,52,32,255

display_item:
        .ascii "The largest number is %d \n\0"

largest:
        .long 1

        .section .text

        .globl _start

_start:

        movl $0, %edi
        movl data_items(, %edi, 4), %eax
        movl %eax, %ebx

start_loop:

        cmpl $255, %eax
        je loop_exit
        incl %edi
        movl data_items(, %edi, 4), %eax
        cmpl $255, %eax
        je loop_exit
        cmpl %ebx, %eax
        jle start_loop
        movl %eax, %ebx
        jmp start_loop

loop_exit:

        movl %ebx, largest
        pushl largest
        pushl $display_item
        call printf
        
        movl $0, %ebx
        movl $1, %eax
        int $0x80
