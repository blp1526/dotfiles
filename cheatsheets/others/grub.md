# grub

## Use eth0 style NIC names

Check that NICs have been renamed by boot.

```
$ dmesg | grep renamed
```

Update `GRUB_CMDLINE_LINUX` at `/etc/default/grub`.

```
GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"
```

Update grub.

```
$ update-grub2
```

Update initramfs.

```
$ update-initramfs -u
```

Reboot.

```
$ shutdown -h now
```
