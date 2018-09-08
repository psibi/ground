# All About Functions

Note that this book uses AT&T assembly syntax for code.

## How Functions work

A function is comprised of

* function name
* function parameters
* local variables
* static variables: are data storage that a function uses while
  processing that is not thrown away afterwards, but is reused for
  every time the function's code is activate.
* global variables
* return address: is a parameter which tells the function where to
  resume executing after the function is completed.
* return value

* The way the variables are stored and the parameters and return
values are transferred by the computer varies from language to
language. This variance is known as language's calling convention
because it describes how functions expect to get and receive data whey
they are called.

* Assembly language can use any calling convention it wants
  to. However, if you want to interoperate with functions written in
  other languages, you have to obey their calling conventions.

* Note that the book uses the `C` programming language calling
  convention as that's the most widely used.

## Assembly language functions using the C calling conventions

* Each computer program that runs uses a region of memory called the
  stack to enable functions to work properly.
* In memory, the stack starts at the top of the memory and grows
  downwards due to architectural considerations. (So "top of the
  stack" means bottom of the stack's memory.) [Read this article for understanding stack on x86](https://eli.thegreenplace.net/2011/02/04/where-the-top-of-the-stack-is-on-x86/)
* Instruction that operate on stack: `pushp`, `popl`.
* `%esp` - Stack register. Contains a pointer to the current top of
  the stack.
* `%ebp` - Base pointer register. Used for accessing function
  parameters and local variables.
* In the `C` language calling convention, the stack is the key element
  for implementing a function's local variables, parameters and return
  address.

* Before executing a function, a program pushes all of the parameters
  for the function onto the stack in the reverse order that they are
  documented. Then the program issues a `call` instruction indicating
  which function it wishes to start. The `call` instruction does two
  things:
  * It pushes the addres of the next instruction, which is the return
    address onto the stack.
  * Then it modifies the instruction pointer (`%eip`) to point to the
    start of the function.
* Now the function itself has to do some bookkeeping. It has to save
  the current base pointer register into stack via `pushl %ebp`. Next
  we have to copy the stack pointer to `%ebp` via `movl %esp,
  %ebp`. And then we reserves spaces on the stack for any local
  variables it needs.
* When the function is done executing, it does three things:
  * It stores it's return value in `%eax`.
  * It resets the stack to what it was when it was called.
  * It returns control back to wherever it was called from. This is
    done using the `ret` instruction which pops whatever value is at
    the top of the stack and sets the instruction pointer `%eip` to
    that value.

Therefore this needs to be done before a function returns control to
the code that called it:

``` assembly
movl %ebp, %esp
popl %ebp
ret
```

The above is done because the return address is not at the top of the
stack at that time.

[Ref: Factorial example in 64 bit architecture](https://picoledelimao.github.io/blog/2016/02/21/factorial-function-in-assembly/)
