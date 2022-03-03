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

Each element of *iov* is a structure of the following form:
```c
struct iovec {
	void *iov_base; // start address of buffer
	size_t iov_len; // number of bytes to transfer to/from buffer
}
```

![[iovec.png]]

### scatter input
The *readv()* system call performs *scatter input*: it reads a contiguous sequence of bytes from the file referred to by the file descriptor into the buffers specified by *iov*.

> Note: Each of the buffer is completely filled before *readv()* proceeds to the next buffer.

Performing scatter input with *readv()*
```c
#include <sys/stat.h>
#include <sys/uio.h>
#include <fcntl.h>
#include "tlpi_hdr.h"

#define STR_SIZE 100

int main(int argc, char *argv[])
{
    int fd;
    struct iovec iov[3];
    struct stat myStruct; /* First buffer */
    int x; /* Second buffer */
    char str[STR_SIZE]; /*Third buffer*/
    ssize_t numRead, totRequired;

	if (argc != 2 || strcmp(argv[1], "--help") == 0) 
		usageErr("%s file\n", argv[0]);

	fd = open(argv[1], O_RDONLY);
	if (fd == -1)
	    errExit("open");

	totRequired = 0;

	iov[0].iov_base = &myStruct;
	iov[0].iov_len = sizeof(struct stat);
	totRequired += iov[0].iov_len;

	iov[1].iov_base = &x;
	iov[1].iov_len = sizeof(x);
	totRequired += iov[1].iov_len;

	iov[2].iov_base = str;
	iov[2].iov_len = STR_SIZE;
	totRequired += iov[2].iov_len;

	numRead = readv(fd, iov, 3);
	if (numRead == -1)
	    errExit("readv");

	if (numRead < totRequired)
		printf("Read fewer bytes than requested\n");

	printf("total bytes requested: %ld; bytes read: %ld\n", (long) totRequired, (long) numRead);
	exit(EXIT_SUCCESS);
}
```


### Gather output
The *writev()* system call performs *gather output*. It concatenates data from all of the buffers specified by *iov* and writes them as a sequence of contiguous bytes to the file referred to by the fd.

### Performing scatter-gather I/O at a specified offset

```c
#define _BSD_SOURCE
#include <sys/uio.h>

ssize_t preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset);
//Returns number of bytes read, 0 on EOF, or –1 on error

ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset);
//Returns number of bytes written, or –1 on error
```


## *truncate()* and *ftruncate()*
The *truncate()* and *ftruncate()* system calls set the size of a file to the value specified by *length*.

```c
#include <unistd.h>
int truncate(const char *pathname, off_t length); 

int ftruncate(int fd, off_t length);

// Both return 0 on success, or –1 on error
```

The *ftruncate()* system call takes a descriptor for a file that has **been opened for writing**. It doesn't change the file offset for the file.


> The *truncate()* system call is the only system call that can change the contents of a file without first obtaining a descriptor for the file via *open()*.

## Nonblocking I/O
