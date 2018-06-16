# Know the Concepts

* Primitives are the functionalites which are provided by the OS. System calls are an example of primitives.
* [In notes](https://github.com/psibi/ground/tree/master/chapter4#how-functions-work)
* [In notes](https://github.com/psibi/ground/tree/master/chapter4#assembly-language-functions-using-the-c-calling-conventions)
* pushl - Pushes onto the top of the stack
  popl - Removes from the top of the stack
  They both affect the %esp register.
* Local variables are data storage that a function uses while processing that is thrown away when it returns.
* They are important in recursive function as those functions need their own copies of data while executing. This can be only provided by local variables.
* %ebp - Base pointer register
  %esp - Stack pointer
* Stack frame consists of all the stack variables used within a function including parameters, local variables, and the return address.

# Use the Concepts

* [square.s](./code/square.s)
* [isolated_square.s](./code/isolated_square.s) & [square_test.s](./code/square_test.s)
* [max.s](./code/max.s)
* Without stanard calling convention, you cannot interoperate with a different language.
