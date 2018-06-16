# Computer Architecture

## Summary

* Program Counter: Tells where to fetch the next instruction from.
* Size of a single storage location is called a *byte*.
* The size of a typical register is called a computer's *word*
  size. x86 processors have four byte words. (This means a single word
  has four bytes.)
* Instruction pointer: points to a memory word which is loaded as an
  instruction.

## Data Accessing Methods

* Immediate mode: Data is embedded in the instruction itself.
* Register Addressing mode: Instruction contains a register to access
  rather than a memory location.
* Direct Addressing mode: Instruction contains a memory address to
  access.
* Indexed addressing mode: Instruction contains a memory address to
  access.
  * Index register offsets the address in the mode. Example: memory
    address: 2002, Index register: 4 => Access address: 2006

On x86 processors, you can also specify a *multiplier* for the index
register.

Reference: https://lists.gnu.org/archive/html/pgubook-readers/2011-10/msg00000.html

* Indirect addressing mode: Instruction contains a register that
  contains a pointer to where the data should be accessed.

* Base pointer addressing mode: Similar to indirect addressing mode
  but also includes the offset.

## Registers

### General purpose

%eax, %ebx, %ecx, %edx, %edi, %esi

### Special purpose

%ebp, %esp, %eip, %eflags
