# Know the concepts

* Comments
* Assembly language file: Human readable code passed to the assembler
  to produce object file.  Object file: The file containing machine
  code.
* Takes object file to produce executable. It add enough information
  so that kernel knows how to load and run it.
* `echo $?`
* `movl $1, %eax` moves the actual literal number `1` to the
  register. `movl 1, %eax` moves the actual data present in the
  address 1 to the register.
* `%eax`
* To get the particular data from a record.
* Usually for fetching the starting point.
* `3634 + (13 * 4) = 3686`
* `%eax`, `%ebx`, `%ecx`, `%edx`, `%edi`, `%esi`
* `movl` moves a word (4 bytes) whereas `movb` moves a byte.
* Instructions controlling the flow.
* Jump to a specific code path based on conditions.
* Memory, algorithm etc.
* TODO

# Use the concepts

* [./code/ans1.s](Code)
* [./code/ans2.s](Code)
* [./code/ans3.s](code)
* TODO
* [./code/ans5.s](code)
* `movl _start, %eax` will move the value at the address of the
  `_start` symbol into the register eax. `movl $start, %eax` will move
  the address of the symbol _start into eax.

Going futher

* TODO
* TODO
