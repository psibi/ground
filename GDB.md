## Debugging Assembly with GDB:

``` shellsession
$ as --gen-debug --gdwarf-2 --32 argv.s -o argv.o
$ ld -m elf_i386 argv.o -o argv
```

## Sample code for debugging

        ``` assembly
        .section .text

        .globl _start

_start:

break1: 
        movl 8(%esp), %ebx
break2: 
        movl $1, %eax
break3: 
        int $0x80
        ```

## Breakpoints

``` gdb
(gdb) break break1
Breakpoint 1 at 0x8048054: file argv.s, line 8.
(gdb) info break
Num     Type           Disp Enb Address    What
1       breakpoint     keep y   0x08048054 argv.s:8
2       breakpoint     keep y   0x08048058 argv.s:10
3       breakpoint     keep y   0x0804805d argv.s:12
```

## Pass command line arguments, Inspect registers

``` gdb
(gdb) run 3 2
Starting program: /home/sibi/github/ground/chapter5/code/argv 3 2

Breakpoint 1, break1 () at argv.s:8
8               movl 8(%esp), %ebx
```

Note that argc is three (Name of the program and two arguments passed)

Let's see `argc` by seeing the value of `%esp`:

``` gdb
(gdb) info r
eax            0x0      0
ecx            0x0      0
edx            0x0      0
ebx            0x0      0
esp            0xffffcae0       0xffffcae0
ebp            0x0      0x0
esi            0x0      0
edi            0x0      0
eip            0x8048054        0x8048054 <break1>
eflags         0x202    [ IF ]
cs             0x23     35
ss             0x2b     43
ds             0x2b     43
es             0x2b     43
fs             0x0      0
gs             0x0      0
(gdb) x/d 0xffffcae0
0xffffcae0:     3
(gdb) print {int}0xffffcae0
$1 = 3
(gdb) print $1
$2 = 3
```

## GHCi

Have other session in ghci for doing hex operations:

``` shellsession
$ stack ghci
λ> import Numeric
λ> let hex n = showHex n ""
λ> hex 10
"a"
λ> 0xa + 0x5
15
λ> hex $ 0xa + 0x5
"f"
```

## Let's find **argv in assembly

``` shellsession
$ gdb argv
(gdb) run aaaaaaa
Starting program: /home/sibi/github/ground/chapter5/code/argv aaaaaaa

Breakpoint 1, break1 () at argv.s:8
8               movl 8(%esp), %ebx
(gdb) info break
Num     Type           Disp Enb Address    What
1       breakpoint     keep y   0x08048054 argv.s:8
        breakpoint already hit 1 time
2       breakpoint     keep y   0x08048058 argv.s:10
3       breakpoint     keep y   0x0804805a argv.s:12
(gdb) info r esp
esp            0xffffcaf0       0xffffcaf0
(gdb) print {char*} 0xffffcaf8   --- (Adding 8 bytes)
$1 = 0xffffccbd "aaaaaaa"
```

Similarly, you can find the program's name:

``` gdb
(gdb) info r esp
esp            0xffffcaf0       0xffffcaf0
(gdb) print {char*} 0xffffcaf4
$6 = 0xffffcc91 "/home/sibi/github/ground/chapter5/code/argv"
```



