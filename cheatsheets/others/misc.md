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

## Dry run

### rsync

see http://www.slideshare.net/oinume/qpstudy01-rsync-4168853

```markdown
rsync --dry-run --delete
```

### chef-client

see http://d.hatena.ne.jp/rx7/20120910/p1

```markdown
chef-client --why-run
```

## Change keyboard type temporarily

```markdown
loadkeys us
```

## Check hash value by openssl

```markdown
openssl dgst -md5 file
openssl dgst -sha1 file
openssl dgst -sha256 file
```

## Show cwd list

```markdown
lsof -d cwd
```

see http://stackoverflow.com/questions/8327139/working-directory-of-running-process-on-mac-os

## ps o(user-defined format)

```markdown
ps axfo ppid,pid,cmd
```

## Parsable lscpu

```markdown
lscpu --parse=CPU,Core
# The following is the parsable format, which can be fed to other
# programs. Each different item in every column has an unique ID
# starting from zero.
# CPU,Core
0,0
1,1
```

## Change ssh passphrase

```markdown
ssh-keygen -p
```

## Available CPU size for current process

```markdown
# grep processor /proc/cpuinfo | wc -l
# Above result is not available CPU size for current process.
# Use following command.
nproc
```

see http://qiita.com/masami256/items/47163fefed7c1e337dec

## Show filesystem super block

```markdown
tune2fs -l /dev/xxx
```

## Show configuration values

```markdown
getconf -a
```

## Remove double quotation mark from jq result

```markdown
# Use -r
echo '{"items":[{"id":1,"name":"beer","price":200},{"id":2,"name":"water", price":100}]}' | jq -r '.items[].name'
```

## Force log logrotion

```markdown
# d: debug, v: verbose
logrotate -dv whenever

# f: force
logrotate -f whenever
```
