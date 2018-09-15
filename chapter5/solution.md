# Know the Concepts

* You open a file to get a file descriptor, followed by which you will perform some operations on the file using it. You will finally close the file descriptor by which the lifecycle of it get's terminated.
* [In notes](./README.md#standard-and-special-files)
* [In notes](./README.md#buffers-and-bss)
* [In notes](./README.md#buffers-and-bss)
* [In notes](./README.md#the-unix-file-concept)

# Use the Concepts

* [./code/upperIO.s](./code/upperIO.s)
* Modify the size of the buffer in the code.
* [./code/upperNoStack.s](./code/upperNoStack.s) - This was the exact changes needed to make it work stack free: [83694b3fc64f696a75f4f1501502cc08ecf249ca](https://github.com/psibi/ground/commit/83694b3fc64f696a75f4f1501502cc08ecf249ca)
* [./code/heynow.s](./code/heynow.s)
