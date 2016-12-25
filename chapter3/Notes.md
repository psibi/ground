# Your First Programs

## Preparing your 64 bit system for 32 bit assembly programming

Note that this section is not in the book. 

``` shellsession
$ as --32 filename.s -o filename.o
$ ld -m elf_i386 filename.o -o filename
$ file filename
filename: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, not stripped
```

* --32 implies Intel i386 architecture
* -m Is an switch for emulating the linker.
You can use the `-V` option to find out the supported emulations.

``` shellsession
$ ld -V
GNU ld (GNU Binutils for Ubuntu) 2.26.1
  Supported emulations:
   elf_x86_64
   elf32_x86_64
   elf_i386
   elf_iamcu
   i386linux
   elf_l1om
   elf_k1om
   i386pep
   i386pe
```

## Assembly constructs

* Anything starting with a period is a instruction to the assembler
  itself. These are called assembler directives or pseudo
  operations. Example: `.section .data`
* The `.section` command breaks your program into section.
* The `.section .data` starts the data section where you list any
  memory storage you will need for data.
* `.globl` means that the assembler shouldn't discard the symbol after
  assembly because the linker will need it. `_start` is a special
  symbol that always needs to be marked with `.globl` because it marks
  the location of the start of the program.
* `_start:` defines the value of the `_start` label. A *label* is a
symbol followed by a colon.
* The `$` sign in `movl $1, %eax` indicates that we want to use
  immediate mode addressing.
* The `int` in `int $0x80` interrupts the normal program flow and
  transfers control from our program to Linux so that it will do a
  system call.

Reference: http://stackoverflow.com/q/18429901/1651941
