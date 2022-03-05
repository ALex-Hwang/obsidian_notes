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

