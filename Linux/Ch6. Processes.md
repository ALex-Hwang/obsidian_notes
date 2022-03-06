# Ch6. Processes

## Processes and Programs
A process is an instance of an executing program.

A program is a file containing a range of information:
- *Binary format identification*: metainformation describing the format of the format of the executable file.
- *Machine-language instructions*: encode the algorithm of the program.
- *Program entry-point address*
- *Data*: The program file contains values used to initialize variables and also literal constants used by the program.
- *Symbol and relocation tables*: describe the locations and names of functions and variables within the program. These tables are used for a variety of purposes, including debugging and run-time symbol resolution (dynamic linking).
- *Shared-library and dynamic-linking information*
- *Other information*

> A process is an abstract entity, defined by the kernel, to which system resources are allocated in order to execute a program.


## Process ID and Parent ID

```c
#include<unistd.h>

pid_t getpid(void);
```

> The linux kernel limits process IDs to being less than or equal to 32,767. Each time it reaches the limit, the kernel resets its process ID counter so that process IDs are assigned starting from low integer values.
1
```c
#include<unistd.h>

pid_t getppid(void);
```

> If a child process becomes orphaned, then the child process is adopted by the *init* process.


## Memory Layout of a Process
The memory allocated to each process is composed of a number of parts, usually referred to as *segments*. These are as follows:
- *text segment*: contains the machine-language instructions of the program, which is read-only.
- *initialized data segment*: contains global and static variables that are explicitly initialized.
- *uninitialized data segment*: contains global and static variables that are not explicitly initialized, which is also called the *bss* segment.
- *stack*:  a frame stores the function's local variables, arguments, and return value.
- *heap*: the top end of the heap is called the *program break*.


### global symbols
*etext, edata, end*: these can be used from within a program to obtain the addresses of the next byte past, respectively, the end of the program text, the end of the initialized data segment, and the end of the uninitialized data segment.

![[memoryLayout.png]]


## The Stack and Stack Frames
A special-purpose register, the *stack pointer*, tracks the current top of the stack.

Each user stack frame contains the following information:
- *Function arguments and local variables*
- *Call linkage information*: Each function uses certain CPU registers, such as the program counter, which points to the next machine-language instruction to be executed. Each time one function calls another, a copy of these registers is saved in the called function's frame so that when the function returns, the appropriate register values can be restored for the calling function.

![[stack.png]]

## Command-Line Arguments (argc, argv)

> argv[0] contains the name used to invoke the program.

There are a couple of nonportable methods of accessing part of all of this information from anywhere from anywhere in a program:
-  The arguments can be read via `/proc/PID/cmdline`. (A program can access its own command-line arguments via `/proc/self/cmdline`)
- *program_invocation_name* and *program_invocation_short_name*

## Environment List

The following syntax can be used to add values to the environment used to execute a single program, without affecting the parent shell (and subsequent commands):
`$ NAME=value program`

> The environment list of any process can be examined via the Linux-specific `/proc/PID/environ` file.


### Accessing the environment from a program

Within a C program, the environment list can be accessed using the global variable `char **environ`.

![[environ.png]]

Two ways to process environment:
1. environ:
```c
#include "tlpi_hdr.h"

extern char **environ;

int main(int argc, char *argv[]) {

	char **ep;

	for (ep = environ; *ep != NULL; ep++)
		puts(*ep);

	exit(EXIT_SUCCESS);
}
```

2. declare a third argument to the *main()* function:

`int main(int argc, char *argv[], char *envp[])`


### getenv()

The *getenv()* function retrieves individual values from the process environment.
```c
#include<stdlib.h>

char *getenv(const char *name);

// Returns pointer to (value) string, or NULL if no such variable
```

## Modifying the environment

### putenv()

The *putenv()* function adds a new variable to the calling process's environment or modifies the value of an existing variable:

```c
#include <stdlib.h>

int puenv(char *string);

// Returns 0 on success, or nonzero on error
```

> The *string* argument is a pointer to a string of the form *name=value*.