# %edi - Holds index of the data item being examined
# %ebx - largest data item found
# %eax - Current data item

        .section .data

data_items:

        .long 5,6,7,9,52,255,30

        .section .text

        .globl _start
_start:

        movl $0, %edi
        movl data_items(, %edi, 4), %eax
        movl %eax, %ebx
        movl $7, %ecx # No of items in the list

start_loop:

        cmpl data_items(, %ecx, 4), %eax
        je loop_exit
        incl %edi
        movl data_items(, %edi, 4), %eax
        cmpl data_items(, %ecx, 4), %eax
        je loop_exit
        cmpl %ebx, %eax
        jle start_loop
        movl %eax, %ebx
        jmp start_loop

loop_exit:

        movl $1, %eax
        int $0x80
