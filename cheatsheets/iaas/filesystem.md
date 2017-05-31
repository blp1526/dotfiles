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
