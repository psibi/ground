# $ as --32 eadd-year.s -o eadd-year.o
# $ as --32 error-exit.s -o error-exit.o
# $ as --32 count-chars.s -o count-chars.o
# $ as --32 write-newline.s.s -o write-newline.s.o
# $ ld -m elf_i386 eadd-year.o read.o write.o error-exit.o write-newline.o count-chars.o -o eadd-year1
# $ ./eadd-year
# 0001: Can't Open Input File I/O

        .include "linux.s"
        .include "record-def.s"

        .section .data
input_file_name:
        .ascii "test.datafka\0"

output_file_name:
        .ascii "testout.dat\0"

        .section .bss

        .lcomm record_buffer, RECORD_SIZE

        .equ ST_INPUT_DESCRIPTOR, -4
        .equ ST_OUTPUT_DESCRIPTOR, -8

        .section .text
        .globl _start
_start:
        movl %esp, %ebp
        subl $8, %esp

        movl $SYS_OPEN, %eax
        movl $input_file_name, %ebx
        movl $0, %ecx
        movl $0666, %edx
        int $LINUX_SYSCALL

        movl %eax, ST_INPUT_DESCRIPTOR(%ebp)

        cmpl $0, %eax
        jg continue_processing

        .section .data
no_open_file_code:
        .ascii "0001: \0"
no_open_file_msg:
        .ascii "Can't Open Input File I/O"

        .section .text
        pushl $no_open_file_msg
        pushl $no_open_file_code
        call error_exit

continue_processing:    

        movl $SYS_OPEN, %eax
        movl $output_file_name, %ebx
        movl $0101, %ecx
        movl $0666, %edx
        int $LINUX_SYSCALL

        movl %eax, ST_OUTPUT_DESCRIPTOR(%ebp)

loop_begin:
        pushl ST_INPUT_DESCRIPTOR(%ebp)
        pushl $record_buffer
        call read_record
        addl $8, %esp

        cmpl $RECORD_SIZE, %eax
        jne loop_end

        incl record_buffer + RECORD_AGE

        pushl ST_OUTPUT_DESCRIPTOR(%ebp)
        pushl $record_buffer
        call write_record
        addl $8, %esp

        jmp loop_begin

loop_end:
        movl $SYS_EXIT, %eax
        movl $0, %ebx
        int $LINUX_SYSCALL
