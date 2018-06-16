        # %edi - Index of data item
        # %eax - Largest data item found
        .section .data

data_items:
        .long 81, 2, 10, 15, 8, 139, 100, 150, 87, 23, 48, 0 # 0 denotes the last number

second_list:

        .long 1,5,45,9,0

third_list:
        .long 20,98,43,45,32,43,0

        .section .text

        .globl _start
        .globl max

_start:
        pushl $data_items

        call maximum
        addl $4, %esp

        pushl $second_list

        call maximum
        addl $4, %esp

        pushl $third_list

        call maximum
        addl $4, %esp

        movl %eax, %ebx
        movl $1, %eax
        int $0x80

        .type maximum,@function

maximum:
        pushl %ebp
        movl %esp, %ebp

init:
        movl $0, %edi
        movl 8(%ebp), %ebx
        movl (%ebx,%edi,4), %ecx
        movl %ecx, %eax

loop:
        incl %edi
        movl 8(%ebp), %ebx
        movl (%ebx,%edi,4), %ecx
        cmpl $0, %ecx
        je end_maximum
        cmpl %eax, %ecx
        jle loop
        movl %ecx, %eax
        jmp loop
        
end_maximum:
        movl %ebp, %esp
        popl %ebp
        ret        

