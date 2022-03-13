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

> The *glibc free()* function calls *sbrk()* to lower the program break only when the free block at the top end is "sufficiently" large, where "sufficient" is determined by parameters controlling the operation of the *malloc()* package.

### Implementation of *malloc()* and *free()*

#### Implementation of *malloc()*
It first scans the list of memory blocks previously released by *free()* in order to find one whose size is larger or equal to its requirement. 

If the block is the same size, it is returned to the caller; if it is larger, then it is split, so that a block of exact size is returned to the caller.

If no block is large enough, then *malloc()* calls *sbrk()* to allocate more memory: to reduce the number of calls to *sbrk()*, *malloc()* increases the program break in larger units.


#### Implementation of *free(*)

![[free1.png]]

![[free2.png]]

Numerous problems will occur if we modify **Length of block** through *pointers*.

To avoid these types of errors, we should observe the following rules:
- After we allocate a block of memory, we should be careful not to touch any bytes outside the range of that block.
- It is an error to free the same piece of allocated memory more than once.
- We should never call *free()* with a pointer value that wasn't obtained by a call to one of the functions in the *malloc* package.
- If we are writing a long-running program that repeatedly allocated memory for various purposes, then we should ensure that we deallocate any memory after we have finished using it. Failure to do so will make further allocations fail. Such a condition is known as a **memory leak**.

### Tools and libraries for *malloc* debugging
Among the *malloc* debugging tools provided by *glibc* are the following:
- *mtrace()* and *muntrace()*
- *mcheck()* and *mprobe()*
- *MALLOC_CHECK_*
- *Valgrind*

### Controlling and monitoring the *malloc* package
Some nonstandard functions that can be used to monitor and control the allocation of memory by functions in the *malloc* package, including the following:
- *mallopt()*
- *mallinfo()*

## Other Methods of Allocating Memory on the Heap

### *calloc()* and *realloc()*

#### *calloc()* 
The *calloc()* function allocated memory for an array of identical items.

```c
#include <stdlib.h>

void *calloc(size_t numitems, size_t size);

// Returns pointer to allocated memroy on success, or NULL on error.
```
The *numitems* specifies how many items to allocate, and *size* specifies their size.
Unlike *malloc()*, *calloc*()* initializes the allocated memory to 0.

### *realloc()*
The *realloc()* function is used to resize (usually enlarge) a block of memory previously allocated by one of the functions in the *malloc* package.

```c
#include <stdlib.c>

void *realloc(void *ptr, size_t size);

// Returns pointers to allocated memory on success, or NULL on error.
```

The *size* argument specifies the desired new size of the block.

On success, *realloc()* returns a pointer to the location of the resized block. This may be different from its location before the call.

Memory allocated using *calloc()* or *realloc()* should be deallocated with *free()*.

> The call *realloc(ptr, 0)* is equivalent to calling *free(ptr)* followed by *malloc(0)*. If *ptr* is NULL, then *realloc()* is equivalent to calling *malloc(size)*

*realloc()* attempts to coalesce the block with an immediately following block of memory on the free list, if one exists and is large enough. If the block lies at the end of the heap, then *realloc()* expands the heap. If the block of memory lies in the middle of the heap, and there is insufficient free space immediately following it, *realloc()* allocates a new block of memory and copies free space following it, realloc() allocates a new block of memory and copies all existing data from the old block to the new block.

> In general, it is advisable to minimize the use of *realloc()*.

```c
nptr = realloc(ptr, newsize);
if (nptr == NULL) {
	/* Handle error */
} else {
	ptr = nptr;
}
```


### Allocating aligned memory: *memalign()* and *posix_memalign()*

They are designed to allocate memory starting at an address aligned at a specified power-of-two boundary, a feature useful for some applications.

```c
#include <malloc.h>

void *memalign(size_t boundary, size_t size);
// Returns pointer to allocated memory on success, or NULL on error
```

The *memalign()* function allocates *size* bytes starting at **an address aligned to a multiple of *boundary***, which must be a power of two. 

```c
#include <stdlib.h>

int posix_memalign(void **memptr, size_t alignment, size_t size);
// Returns 0 on success, or a positive error number on error.
```

> Blocks of memory allocated using *memalign()* or *posix_memalign()* should be deallocated with *free()*.


## Allocating Memory on the Stack: *alloca()*

*alloca()* obtains memory from the stack by increasing the size of the stack frame.

```c
#include <alloca.h>

void *alloca(size_t size);
// Returns pointer to allocated block of memory.
```

> We need not call *free()* to deallocate memory allocated with *alloca()*. Likewise, it is not possible to use realloc() to resize a block of memory allocated by *alloca()*.

We should not use *alloca*()* within a function argument list, we should code such as this:
```c
void *y;

y = alloca(size);
func(x, y, z);
```

### Advantages:
- faster than *malloc()*
- The memory allocated is automatically freed.
- It can be especially useful if we employ [[Ch6. Processes#Performing a Nonlocal Goto setjmp and longjmp | longjmp()]] or *siglongjmp()* to perform a  nonlocal go to from a signal handler.