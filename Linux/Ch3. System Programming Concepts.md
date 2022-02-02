# Terminology
## errno
errno: number of last error

> The _<errno.h>_ header file defines the integer variable _errno_,
       which is set by system calls and some library functions in the
       event of an error to indicate what went wrong.

ref: https://www.man7.org/linux/man-pages/man3/errno.3.html


## exit() and \_exit()
exit() is \_exit() without performing cleanup tasks.


## lvalue and rvalue in C
> An lvalue (locator value) represents an object that occupies some identifiable location in memory (i.e. has an address).

> rvalues are defined by exclusion. Every expression is either an lvalue or an rvalue, so, an rvalue is an expression that does not represent an object occupying some identifiable location in memory.

## va_list
> from <stdarg.h>

### example
```c
#include <stdarg.h>
#include <stdio.h>
 
/* this function will take the number of values to average
   followed by all of the numbers to average */
double average ( int num, ... )
{
    va_list arguments;                     
    double sum = 0;
 
    /* Initializing arguments to store all values after num */
    va_start ( arguments, num );           
    /* Sum all the inputs; we still rely on the function caller to tell us how
     * many there are */
    for ( int x = 0; x < num; x++ )        
    {
        sum += va_arg ( arguments, double ); 
    }
    va_end ( arguments );                  // Cleans up the list
 
    return sum / num;                      
}
 
int main()
{
    /* this computes the average of 13.2, 22.3 and 4.5 (3 indicates the number of values to average) */
    printf( "%f\n", average ( 3, 12.2, 22.3, 4.5 ) );
    /* here it computes the average of the 5 values 3.3, 2.2, 1.1, 5.5 and 3.3 */
    printf( "%f\n", average ( 5, 3.3, 2.2, 1.1, 5.5, 3.3 ) );
}
```

## fflush()
> ostream points to an output stream or an update stream in which the most recent operation was not input, the fflush function causes any unwritten data for that stream to be delivered to the host environment to be written to the file; otherwise, the behavior is **undefined**.

## Magic Number
>  Magic numbers are the first few bytes of a file that are unique to a particular file type. These unique bits are referred to as magic numbers,  also sometimes referred to as a  file signature.

These bytes can be used by the system to “**differentiate between and recognize different files**” without a file extension.

# Exercise
> When using the Linux-specific *reboot()* system call to reboot the system, the second argument, *magic2*, must be specified as one of a set of magic numbers (e.g. LINUX_REBOOT_MAGIC2). What is the significance of these numbers? (Converting them to hexadecimal provides a clue.)

**Answer**:
LINUX_REBOOT_MAGIC2: 672274793, which in hex is 28121969, Linus Torvalds' birthday.

