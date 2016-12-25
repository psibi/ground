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

Reference: http://stackoverflow.com/q/18429901/1651941

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
* `.long` directive causes the assembler to reserve memory for the
  list of numbers that follow it. `.byte` and `.int` are similar
  directive but they take up one and two storage location
  respectively. `.long` takes up four storage locations.
* `.ascii` directive is to enter in characters into memory. Each
  character takes up to one storage location.

## Instruction set

* The `l` in `movl` stands for move long.
* `je` - Jump if the values were equal
* `jg` - Jump if the second value was greater than the first
  value. For all other jump instructions the comparison is if from the
  second value.
* Other similar jump statements: `jge`, `jl`, `jle`, `jmp`
* `incl` - Increments the value of register by one.

## Addressing Modes

General form of memory address references is this:

``` assembly
ADDRESS_OR_OFFSET(%BASE_OR_OFFSET, %INDEX, MULTIPLIER)
```

All the fields are optional.

`Final address = ADDRESS_OR_OFFSET + %BASE_OR_OFFSET + (INDEX * MULTIPLIER)`

`ADDRESS_OR_OFFSET` and `MULTIPLIER` must both be constants while the
other two must be registers.

### Direct addressing mode

* Only uses `ADDRESS_OR_OFFSET` portion.
* Example: `movl ADDRESS, %eax`

### Indexed addressing mode

* Uses `ADDRESS_OR_OFFSET` and the `%INDEX` portion.
* Example: `movl string_start(, %ecx, 1), %eax`

### Indirect addressing mode

* Instruction contains a register that contains a address from the
  data is loaded.
* Example: `movl (%eax), %ebx`

### Base pointer addressing mode

* Base pointer addressing is similar to indirect addressing, except that it adds a constant value to the address in the register.
* Example: `movl 4(%eax), %ebx`

### Immediate mode

* Used to load direct values into register or memory locations.
* Example: `movl $4, %eax`

### Register addressing mode

* Register mode simply moves data in or out of a register. In all of our examples above, register addressing mode was used for the other operand.
* Example: `movl $4, %eax`

## Layout of register

* If we only want to move data a byte at a time, use `movb`.
* `%ax` is the least significant half of `%eax`. (Size - two bytes)
* `%al` is the least significant byte of `%ax`. (Size - one byte)
* `%ah` is the most significant byte of `%ax`. (Size - one byte)

## processor specific

* In case of `exit` system call, the operating system requires a
  status code be loaded in `%ebx`.
* See appendix for more details.
