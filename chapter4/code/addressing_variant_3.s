# ~/g/g/c/code (master) $ as --32 filename.s -o filename.o
# ~/g/g/c/code (master) $ ld -m elf_i386 filename.o -o filename
# ~/g/g/c/code (master) $ ./filename
# ~/g/g/c/code (master) $ echo $status
# 2

        .section .data

data_items:
        .long 81, 2, 10, 15, 8, 39, 100, 87, 23, 48, 0 # 0 denotes the last number

        .section .text

        .globl _start
        .globl max

_start:
        pushl $data_items

        call maximum
        addl $4, %esp

        movl %eax, %ebx
        movl $1, %eax
        int $0x80

        .type maximum,@function

maximum:
        pushl %ebp
        movl %esp, %ebp
        
        movl 8(%ebp), %ebx
        movl 4(%ebx), %eax # Change the number to 4,8,12,16,20 to see the iteration

end_square:
        movl %ebp, %esp
        popl %ebp
        ret        

