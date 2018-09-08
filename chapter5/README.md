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
* This takes up space in your executable.


