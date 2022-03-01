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


