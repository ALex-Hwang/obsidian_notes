# Ch5. FILE IO Further Details

## Atomic and Race Conditions

All the system calls are executed atomically.


## fcntl()
functionality of `fcntl()`.

### retrieve or modify the acess mode and open file status flags of an open file.(using `F_GETFIL`)

```c
int flags, accessMode;

flag = fcntl(fd, F_GETFL);

if (flag == -1)
	errExit("fcntl");

if (flags & O_SYNC)
	printf("some words");

accessMode = flags & O_ACCMODE;
if (accessMode == O_WRONLY)
	printf("some wrods");
```

### modify some of the open file status flags(using `F_SETFL`)

> The flags that can be modified are O_APPEND, O_NONBLOCK, O_NOATIME, O_ASYNC, and O_DIRECT. Attempts to modify other flags are ignored.

Using `fcntl()` to modify open file status flags is particularly useful in the following cases:
- The file was not opened by the calling program, so that it had no control over the flags used in the `open()` call.
- The file descriptor was obtained from a system call other than `open()`.

```c
int flags;

flags = fcntl(fd, F_GETFL);
if (flags == -1) 
	errExit("fcntl");
flags |= O_APPEND;
if (fcntl(fd, F_SETFL, flags) == -1)
	errExit("fcntl");
```

## Relationship Between File Descriptors and Open Files

three structures maintained by the kernel:
- the per-process file descriptor table
- the system-wide table of open file descriptions
- the file system i-node table

![[openFileDescriptor.png]]
> Fig.1: 
> In process A, descriptors 1 and 20 both refer to the same open file description. This situation may arise as a result of a call to *dup(*)*.
> Descriptor 2 of process A and descriptor 2 of process B refer to a single file description. This scenario could occur after a call to *fork()*.
> 
> 

#### open file descriptors( for each process)
Each entry in this table records information about a single file descriptor, including:
- a set of flags controlling the operation of the file descriptor
- a reference to the open file description

#### open file descriptions
> This table is sometimes referred to as the *open file table*, and its entries are sometimes called *open file handles*.

An open file description stores all information relating to an open file, including: 
- the current file offset
- status flag specified when opening the file
- the file access mode
- settings relating to signal-driven I/O
- a reference to the *i-node* object for this file


## Duplicating File Descriptors
`$ ./myscript > results.log 2>&1`
The shell achieves the redirection of standard error by duplicating file descriptor 2 so that it refers to the same open file description as file descriptor 1.

### dup()
The *dup()*  call takes *oldfd*, an open file descriptor, and returns a new descriptor that refers to the same **open file description**. The new descriptor is guaranteed to be the lowest unused file descriptor.

```c
#include <unistd.h>

int dup(int oldfd);
// Returns (new) file descriptor on success, or -1 on error
```

### dup2()
To ensure we always get the file descriptor we want, we can use *dup2()*;

```c
int dup2(int oldfd, int newfd);
```

If the *newfd* specified is used, *dup2()* closes it at first. (Any error that occcurs during this close is silently ignored.)

A further interface using *fcntl()* using `F_DUPFD`:
```c
newfd = fcntl(oldfd, F_DUPFD, startfd);
```

The duplicate is made using the lowest unused file descriptor greater than or equal to *startfd*, which provides a guarantee that the new fd falls in a certain range.

### dup3()
The dup3() system call performs the same task as dup2(), but adds an additional
argument, flags, that is a bit mask that modifies the behavior of the system call.

It can only set the [[O_CLOEXEC explained]] flag.

```c
#define _GNU_SOURCE
#include <unistd.h>

int dup3(int oldfd, int newfd, int flags);
```


## *pread()* and *pwrite()*

*read()* and *write()* at a specified offset, without changing the file offset.

```c
#include <unistd.h>
ssize_t pread(int fd, void *buf, size_t count, off_t offset);
// Returns number of bytes read, 0 on EOF, or –1 on error
ssize_t pwrite(int fd, const void *buf, size_t count, off_t offset);
// Returns number of bytes written, or –1 on error
```

> the file referred to by *fd* must be seakable.

The *pread()* and *pwrite()* is similar to using *read()*/*write()* and *lseek()*, but they offer a performance advantage.



## *readv()* and *writev()*
which perform  **scatter-gather** I/O.

```c
#include <sys/uio.h>
ssize_t readv(int fd, const struct iovec *iov, int iovcnt);
// Returns number of bytes read, 0 on EOF, or –1 on error
ssize_t writev(int fd, const struct iovec *iov, int iovcnt);
// Returns number of bytes written, or –1 on error
```

