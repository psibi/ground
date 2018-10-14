# How a Computer Views memory

* A computer looks at memory as a long sequence of numbered storage
  locations. Everything is stored in these locations. These storage
  locations are called bytes.
* Byte: Size of storage location. On x86 processors, a byte can store
  numbers between 0 and 255.
* Word: Size of normal register. On x86 processors, a word is four
  bytes long. Most operations handle a word at a time.
* Address: Is a number that refers to abyte in a memory.
* Pointer: is a register or memory word whose value is an address.

# Memory Layout of a Linux Program

* When your program is loaded into memory, each `.section` is loaded
  into its own region of memory. All of the code and data declared in
  each section is brough together, even if the were separated in your
  source code.
* The actual instructions (the `.text` section) are loaded at the
  address `0x0804800`. The `.data` secion is loaded immediately after
  that followed by the `.bss` section.
* The last byte that can be addressed on Linux is location
  `0xffffff`. Linux starts the stack here and grows it downward toward
  the other sections.

![Memory layout of a Linux Program](https://user-images.githubusercontent.com/737477/46909651-82e3c300-cf53-11e8-8645-f8b771f08e84.png)

* Your program's data region starts at the bottom of the memory and goes up.
* The stack starts at the top of the memory and moves downard with each push.
* The last accessible memory address to your program is called the system break.

# Every Memory Address is a Lie

* From the above model, it may seem that every program gets loaded
  into the same place in memoy. Don't they step on each other or
  overwrite ?
* As a program write, we only access virtual memory.
* Physical memory refers to the actual RAM chips inside your computer
  and what they contain.
* Before loading your program, Linux finds an empty physical memory
  space large enough to fit your program and then tells the processor
  to pretend that this memory is actually at the address `0x0804800`
  to load your program into.

Overview of the way memory access are handled under Linux
- The program tries to load memory from a virtual address.
- The processor, using tables supplied by Linux transforms the virtual
  memory address into a physical memory address on the fly.
- If the processor doesn not have a physical address listed for the
  memory address, it sends a request to Linux to load it.
- Linux looks at thte adress. If it is mapped to a disk location, it
  continues on to the next step. Otherwise, it terminates the program
  with a segmentation fault error.
- If there is not enough room to load the memory from disk, Linux will
  move another part of the program or another program onto disk to
  make room.
* Linux then moves the data into a free physical meomry address.
* Linux updates the processor's virtual-to-physical meomry mapping
  tables to reflect the changes.
* Linux restores control to the program, causing it to re-issue the
  instruction wchich caued this process to happen.
* The processor can now handle the instruction using the newly loaed
  memory and transition tables.

Now in order to make the process more efficient, memory is seprated
into groups called pages. When running Linux on x86 processors, a page
is 4096 bytes of memory. All of the memory mappings are done a page at
a time.

* Resident Set size: The amount of memory that your program currently
  has in physical memory is called its resident set size. The `top`
  Unix program has a column named `RES` for this.

# Getting more Memory

* If you need more memory, you can just tell Linux where you want the
  new break point to be, and Linux will map all the memory you need
  between the current and new break point and then move the break
  point to the spot you specify.
* The way we tell Linux to move the break point is through the `brk`
  system call.
* `brk` system call details:
  - System call number: 45 (should be in `%eax`)
  - `%ebx` should be loaded with the requested breakpoint.
  - Linux will returnn the new break point in `%eax`.
  - New break point might be larger than what you asked for, because
    Linux rounds up to the nearest page. If there is not enough
    physical memory or swap to fulfill your request, Linux will return
    a zero in `%eax`.
  - If you call `brk` with zero in `%ebx`, it will simply return the
    last usuable memory address.
* You need memory manager to avoid fragmentation. Memory manager has
  two basic functions - `allocate` and `deallocate`. The pool of
  memory used by memory managers is commonly referred to as the
  `heap`.
