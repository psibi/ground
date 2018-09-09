# See https://stackoverflow.com/a/52241787/1651941
# $./argv
# fish: “./argv” terminated by signal SIGSEGV (Address boundary error)
# $ ./argv 1
# echo $status -- In fish shell
# 49
# $./argv 2
# echo $status
# 50

      .section .text

      .globl _start

_start:

        movl 8(%esp), %ebx
        movl (%ebx), %ebx

        movl $1, %eax
        int $0x80
