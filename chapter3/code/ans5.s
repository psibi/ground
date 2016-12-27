# %edi - Holds index of the data item being examined
# %ebx - largest data item found
# %eax - Current data item
# %esi - Has the length of data_items        
        

        .section .data

data_items:

        .long 5,6,7,9,52,32

total_elements:

        .long 5

        .section .text

        .globl _start

_start:

        movl $0, %edi
        movl data_items(, %edi, 4), %eax
        movl %eax, %ebx
        movl total_elements, %esi

start_loop:

        cmpl %esi, %edi
        je loop_exit
        incl %edi
        movl data_items(, %edi, 4), %eax
        cmpl %ebx, %eax
        jle start_loop
        movl %eax, %ebx
        jmp start_loop

loop_exit:

        movl $1, %eax
        int $0x80
