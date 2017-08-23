# filesystem

## autofs + sshfs

```markdown
# /etc/auto.master
/mnt/sshfs /etc/auto.sshfs --timeout 0 --ghost

# /etc/auto.sshfs
foobarbaz -fstype=fuse,allow_other :sshfs\#foobarbaz\:/root/Documents

systemctl enable autofs
systemctl start  autofs
```

## debugfs

```markdown
debugfs /dev/sda2

# stat inode
debugfs: stat <123400>

# output to file
debugfs: dump <123400> /tmp/inodedump.file
```

## Use loop device for filesystem test

```markdown
dd if=/dev/zero of=/path/to/test.img bs=1K count=20000
mkfs.ext4 /path/to/test.img
mount -o loop /path/to/test.img /mnt
```
