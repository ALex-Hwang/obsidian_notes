# Ch8. Users and Groups
In this chapter, we look at the system files that are used to define the users and groups on the system, and then describe the library functions used to retrieve information from these files.

## The Password File: /etc/passwd
`mtk:x:1000:100:Michael Kerrisk:/home/mtk:/bin/bash`

Login name:Encrypted password:User ID:Group ID:Comment:Home directory:Login Shell

## The Shadow Password File: /etc/shadow
which is readable only by privileged programs.

## The Group File: /etc/group
The *group file* contains one line for each group in the system. 
```
users:x:100:
jambit:x:106:claus,felli,frank,harti,markus,martin,mtk,paul
```
Group name:Encrypted password:Group ID:User List

## Retrieving User and Group Information

### Retrieving records from the password file
```c
#include <pwd.h>

struct passwd *getpwnam(cosnt char *name);
struct passwd *getpwuid(uid_t uid);

// Both return a pointer on success, or NULL on error;
```

```c
struct passwd {
	char *pw_name;
	char *pw_passwd;
	uid_t pw_uid;
	gid_t pw_gid;
	char *pw_gecos; // Comment (user information)
	char *pw_dir;
	char *pw_shell;
};
```

### Retrieving records from the group file
```c
#include <grp.h>

struct group *getgrnam(const char *name);
struct group *getgrgid(gid_t gid);
```

```c
struct group {
	char *gr_name;
	char *gr_passwd;
	gid_t gr_gid;
	char **gr_mem;
};
```

### Scanning all records in the password and group files
```c
#include <pwd.h>

struct passwd *getpwent(void);
// Returns pointer on success, or NULL on end of stream or error

void setpwent(void);
void endpwent(void);
```

The *getpwent()* function returns records from the password file one by one, returning NULL when there are no more records. When we have finished with the file, we call *endpwent()* to close it.

```c
struct passwd *pwd;

while ((pwd = getpwent()) != NULL)
	printf("%-8s %5ld\n", pwd->pw_name, (long) pwd->pw_uid);

endpwent();
```

> The *endpwent()* call is necessary so that any subsequent *getpwent()* call will reopen the password file and start from the beginning. On the other had, if we are part-way through the file, we can use the *setpwent()* function to restart from the beginning.

### Retrieving records from the shadow password file
```c
#include <shadow.h>

struct spwd *getspnam(const char *name);
// Returns pointer on success, or NULL on not found or error

struct spwd *getspent(void);
// Returns pointer on success, or NULL on end of stream or error

void setspent(void);
void endspent(void);
```

```c
struct spwd {
	char *sp_namp;/* Login name (username) */
	char *sp_pwdp;/* Encrypted password */

	/* Remaining fields support "password aging", an optional
	feature that forces users to regularly change their
	passwords, so that even if an attacker manages to obtain
	a password, it will eventually cease to be usable. */

	long sp_lstchg;/* Time of last password change
					(days since 1 Jan 1970) */
	long sp_min;/* Min. number of days between password changes */
	long sp_max;/* Max. number of days before change required */
	long sp_warn;/* Number of days beforehand that user is
				warned of upcoming password expiration */
	long sp_inact;/* Number of days after expiration that account
	is considered inactive and locked */
	long sp_expire;/* Date when account expires
				(days since 1 Jan 1970) */
	unsigned long sp_flag;/* Reserved for future use */
};
```

## Password Encryption and User Authentication
The encryption algorithm is encapsulated in the *crypt()* function.

```c
#define _XOPEN_SOURCE
#inlcude <unistd.h>

char *crypt(const char *key, const char *salt);
// Returns pointer to statically allocated string containing encrypted password on success, or NULL on error.
```

The *salt* argument is a 2-character string whose value is used to perturb (vary) the algorithm, a technique to make it more difficult to crack. The function returns a pointer to a statically allocated 13-character string.

> The encrypted password returned by *crypt()* contains a copy of the original *salt* value as its first two characters.

```c
#define _BSD_SOURCE
#include <unistd.h>

char *getpass(const char *prompt);
// Returns pointer to statically allocated input password string
```
