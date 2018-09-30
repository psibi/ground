# Sharing Functions with Code Libraries

Several ways to write programs:
* Write code in high level language instead of assembly.
* Copy/Paste code into your project!
* Have a set of functions on the system that are shared among any
  program that wishes to use it. (i.e dynamic libraries)

Drawback of dynamic libraries:

* Dependency problem: You never know when you don't need a dynamic
  library. In the current computing scenario, this point is mostly
  moot as storage is not an issue.
* Fixing a bug on a shared function may cause further bugs (When other
  programs rely on that bug!)

# Using a Dynamic library

* [helloworld-nolib.s](./code/helloworld-nolib.s) - Code without using dynamic libray
* [helloworld-lib.s](./code/helloworld-lib.s) - Code using dynamic library

Running dynamically linked executable proved to be a challenge in my
64 bit machine and I wasn't able to make it work. Please send me a
pull request if you have exact instructions on how to do it.

I used [debian i386 image](https://hub.docker.com/r/i386/debian/) to run the program:

* docker pull i386/debian
* Get into bash of container: docker run -it i386/debian /bin/sh
* apt-get update && apt-get install gcc && apt-get --reinstall binutils

Using `docker cp` was useful to transfer your host programs:

``` shellsession
$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
483318aeb636        i386/debian         "/bin/sh"           About an hour ago   Up About an hour                        unruffled_williams
$ docker cp hellworld-lib.s 483318aeb636:/code/
```

Linker command:

``` shellsession
$ ls /lib/
cpp  hellworld-lib  hellworld-lib.o  hellworld-lib.s  i386-linux-gnu  init  ld-linux.so.2  lsb  systemd  terminfo  udev
$ # Note the file `ld-linux.so`
$ ld -dynamic-linker /lib/ld-linux.so.2 -o helloworld-lib helloworld-lib.o -lc
$ ./helloworld-lib
hello world
$ ldd hellworld-lib
        linux-gate.so.1 (0xf7eee000)
        libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xf7d2f000)
        /lib/i386-linux-gnu/libc.so.6 => /lib/ld-linux.so.2 (0xf7ef0000)
$ cat /etc/ld.so.conf
include /etc/ld.so.conf.d/*.conf

```

Options to `ld` command:

* `-dynamic-linker`: Sets the name of the dynamic linker.
* `-l` `-lc` translates to `libc.so` (ie. `lib` ++ `c` ++ `.so`)

# How Dynamic Libraries Work

* In our previous programs, all the code was contained within the
source file. Such programs are called statically linked executables as
they contained all the necessary functionality for the program.
* When you use dynamic libraies, your program is then dynamiclly
  linked which means that not all of the code needed to run the
  program is acutally contained within the program file itself, but in
  external libraries.
* The command `-lc` , instructs the linker to use the `c` library (`libc.so`)
* [printf-example.s](./code/printf-example.s) : Sample program using libc function

# Building a Dynamic Libray

You need to pass the appropriate options to the linker to build a dynamic library:

* `ld -shared obj1.o obj2.o -o librecord.so`
* The above command lins two object files togother into a dynamic library named `librecord.so`

Way to use your own dynamic library named `librecord.so`:

* `as program.s -o program.o`
* `ld -L . -dynamic-linker /lib/ld-linux.so.2 -o exe-name -lrecord program.o`
* `-L .` told the linker to look for libraries in the current directory.
* `-lrecord` tells the linkekr to search for functions in the file named `librecord.so`

For proper execution of the above program `exe-name`, you need to set
`LD_LIBRARY_PATH` environment variable properly to the location of
`librecord.so`
