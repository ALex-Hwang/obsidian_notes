# Process Credentials
Every process has a set of associated numeric user identifies and group identifies. These are as follows:
- real user ID and group ID
- effective user ID and group ID
- saved set-user-ID and saved set-group-ID
- file-system user ID and group ID(Linux-specific); and 
- supplementary group IDs

## Real User ID and Real Group ID
The real user ID and group ID identify the user and group to which the process belongs. When a new process is created, it inherits these identifies from its parent.

## Effective User ID an Effective Group ID
Effective and supplementary IDs are used to determine the permissions granted to a process when it tries to perform various operations.

There are two ways to change effective User/Group IDs:
- through the user of system calls that we discuss later
- through the execution of set-user-ID and set-group-ID programs

## Set-User-ID and Set-Group-ID Programs
A set-user-ID program allows a process to gain privileges it would not normally have, by setting the process's effective user ID to the same value as the user ID (owner) of the executable file.
```shell
chmod u+s prog # turn on set-user-ID permission bit
chmod g+s prog # turn on set-group-ID permission bit
```

## Saved Set-User-ID and Saved-Group ID
