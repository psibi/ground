# Dealing with Files

## The UNIX File Concept

* All files can be accesses as a sequential stream of bytes.
* Arguments to open system call
  - file name
  - number representing the mode (read, write, both read and write etc.)
  - permission
* Assembly setting for open system call
  - %eax will hold system call number. System call number is 5.
  - Address of the first character of the filename should be stored in %ebx.
  - mode number should be stored in %ecx.
    - 0 for files you want to read from
    - 03101 for files you want to write to
  - permission should be stored in %edx.
  - Linux will return the file descriptor on %eax
* Assembly setting for read system call
  - System call number: 3
  - %ebx will store the file descriptor
  - %ecx will store the address of a buffer for storing the data that is read in.
  - %edx will store the size of the buffer
* Assembly setting for write system call
  - System call number: 5
  - Shares the same parameters with read system call.
  - %eax will have the number of bytes written or the error code on execution of the system call.
* Assembly setting for close system call
  - System call number: 6
  - %ebx will store the file descriptor.

## Buffers and .bss

* A buffer is a continous blocks of bytes used for bulk data transfer.

### Static Storage

* Declared using `.long` and `.byte` directives.
* The above directive takes up space in your executable.

### .bss section

* `.bss` section is like `.data` section except it doesn't take up space in executable.
* This section reserves storage but can't initialize it.

```
.section .bss
.lcomm my_buffer, 500
```

The directive `.lcomm` will create a symbol `my_buffer` that refers to a 500 byte storage location

Understand these codes:

* [Sample code 1](./code/test.s)
* [Sample code 2](./code/test2.s)
* [Sample code 3](./code/test3.s)
* [Sample code 4](./code/test4.s)
* [Sample code 5](./code/test5.s)
* [Sample code 5](./code/check.s)
* [Sample code 6](./code/check2.s)
* [Sample code 7](./code/buffer.s)

## Standard and Special files

Linux programs usually have at least three open file descriptors when they begin.

* STDIN
  - Read only file usually represents your keyboard.
  - File descriptor number: 0
* STDOUT
  - Write only file usually represents your screen display.
  - File descriptor number: 1
* STDERR
  - Write only file usually represents your screen display.
  - File descriptor number: 2

* Communication between processes is usually done through special files called pipes.


External Resource:

* [argc and argv in x86](https://stackoverflow.com/a/16722942/1651941)
* [Sample argc code](./code/argc.s)
* [Sample argv code](./code/argv.s)

