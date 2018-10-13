# $ as printf-example.s -o printf-example.o
# $ ld printf-example.o -o printf-example -lc -dynamic-linker /lib/ld-linux.so.2
# $ ls /lib/ld-li*
# /lib/ld-linux.so.2
# $ ./printf-example
# Hello! Jonathan is a person who loves the number 3

        .section .data

firststring:

        .ascii "Hello! %s is a %s who loves the number %d\n\0"

name:
        .ascii "Jonathan\0"
personstring:
        .ascii "person\0"
numberloved:
        .long 3

        .section .text
        .globl _start
_start:
        pushl numberloved
        pushl $personstring
        pushl $name
        pushl $firststring

        call printf

        pushl $0
        call exit
