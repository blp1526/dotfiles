# CHEATSHEET

## Uncover a file

```markdown
$ file /usr/include/stdio.h
/usr/include/stdio.h: C source, ASCII text
```

## Search by a keyword

```markdown
$ man -k traffic
tc (8)               - show / manipulate traffic control settings
```

## Add a manual

```markdown
$ whereis bash
bash: /usr/bin/bash

$ sudo yum reinstall bash
Complete!

$ whereis bash
bash: /usr/bin/bash /usr/share/man/man1/bash.1.gz
```

## Get back to where once belonged

```markdown
$ pwd
/home/user

$ cd /tmp

$ cd -

$ pwd
/home/user
```

## As a trash box

```markdown
$ mv maybe_important_dir/ /tmp
```

## Read only

```markdown
$ vim -R important_file
```

## Show symbolic link

```markdown
$ ls -l /etc/rc0.d
lrwxrwxrwx 1 root root 10 Feb 24  2015 /etc/rc0.d -> rc.d/rc0.d

$ cd /etc/rc0.d/

$ pwd
/etc/rc0.d

$ pwd -P
/etc/rc.d/rc0.d
```

## Display all

```markdown
$ sudo cat /proc/:id/environ
LANG=en_US.UTF-8PATH=...

$ sudo cat -A /proc/:id/environ
LANG=en_US.UTF-8^@PATH=...
```

## Line break by null character

```markdown
$ sudo strings /proc/:id/environ
LANG=en_US.UTF-8
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
```

## Hexdump

```markdown
$ od -t x1 -c /proc/:id/environ
0000000  4c  41  4e  47  3d  65  6e  5f  55  53  2e  55  54  46  2d  38
          L   A   N   G   =   e   n   _   U   S   .   U   T   F   -   8
```

## Search file name

```markdown
$ ag -g stdio /usr/include/
/usr/include/bits/stdio_lim.h
/usr/include/bits/stdio-ldbl.h
/usr/include/bits/stdio.h
/usr/include/bits/stdio2.h
/usr/include/bits/stdio-lock.h
/usr/include/c++/4.9.2/cstdio
/usr/include/c++/4.9.2/tr1/cstdio
/usr/include/c++/4.9.2/tr1/stdio.h
/usr/include/c++/4.9.2/ext/stdio_sync_filebuf.h
/usr/include/c++/4.9.2/ext/stdio_filebuf.h
/usr/include/stdio_ext.h
/usr/include/stdio.h
```

## With command line

```markdown
top -c
```

## restrict max-depth

```markdown
du --max-depth=1 /var/
```

## Show top 10

```markdown
du -s * | sort -nr | head -10
```

## Dry run before delete

see http://www.slideshare.net/oinume/qpstudy01-rsync-4168853

```markdown
rsync --dry-run --delete
```

## Change keyboard type temporarily

```markdown
loadkeys us
```
