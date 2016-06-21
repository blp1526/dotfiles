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
