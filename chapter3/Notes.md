# Your First Programs

## Preparing your 64 bit system for 32 bit assembly programming

Note that this section is not in the book. 

``` shellsession
$ as --32 filename.s -o filename.o
$ ld -m elf_i386 filename.o -o filename
$ file filename
filename: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, not stripped
```

--32 implies Intel i386 architecture
-m Is an switch for emulating the linker.
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

Reference: http://stackoverflow.com/q/18429901/1651941
