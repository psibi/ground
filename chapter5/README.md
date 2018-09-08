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

