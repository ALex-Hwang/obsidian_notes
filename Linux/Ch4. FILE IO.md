# Ch4. FILE I/O: The Universal I/O Model

## prerequisite
### c head files
- `unistd.h`
- `fcntl.h`
- `ctype.h`
- `sys/xxx`



## syscalls covered in this chapter

### open()


### creat()


### read()


### write()


### close()


### lseek()


### ioctl()


## concepts covered

### file holes/spare files
refs:
1.  [file holes, races, and mmap()](https://lwn.net/Articles/357767/)
2. [handling Sparse Files on Linux](https://www.systutorials.com/handling-sparse-files-on-linux/)
3. [Spare Files](https://wiki.archlinux.org/title/Sparse_file)



## Exercise

1. The tee command reads its standard input until end-of-file, writing a copy of the input
to standard output and to the file named in its command-line argument. (We show
an example of the use of this command when we discuss FIFOs in Section 44.7.)
Implement tee using I/O system calls. By default, tee overwrites any existing file with
the given name. Implement the –a command-line option (tee –a file), which causes tee
to append text to the end of a file if it already exists. (Refer to Appendix B for a
description of the getopt() function, which can be used to parse command-line
options.)


### useful functions 
- `getop()`

2. Write a program like cp that, when used to copy a regular file that contains holes (sequences of null bytes), also creates corresponding holes in the target file.