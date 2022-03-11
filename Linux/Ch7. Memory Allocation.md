# Ch7. Memory Allocation

## Allocating Memory on the Heap

The current limit of the heap if referred to as the *program break*.

### Adjusting the Program Break: *brk()* and *sbrk()*

Initially, the program break lies just past the end of the uninitialized data segment.

![[memoryLayout.png]]

The kernel automatically allocates new physical pages on the first attempt by the process to access addresses in those pages.

```c
#include <unistd.h>

int brk(void *end_data_segment);
// Returns 0 on success, or -1 on error

void sbrk(intptr_t increment);
// Returns previous program break on success, or (void*) -1 on error

```

The *brk()* system call sets the program break to the location specified by *end_data_segment*.

The *sbrk()* adjusts the program break by adding *increment* to it.
*initptr_t* type is an integer data type. On success, *sbrk()* returns the previous address of the program break, which is the start of the newly allocated block of memory.
> On linux, *sbrk()* is a library function implemented on top of *brk()*.

### Allocating Memory on the Heap: *malloc()* and *free()*

```c
#include <stdlib.h>

void *malloc(size_t size);
// Returns pointer to allocated memory on success, or NULL on error.
```
> On linux, *malloc(0)* returns a pointer to a small piece of memory that can be freed with *free()*.


```c
#include <stdlib.h>

void free(void *ptr);
```

> In general, *free()* doesn't lower the program break, but instead adds the block of memory to a list of free blocks that are recycled by future calls to *malloc()*.

