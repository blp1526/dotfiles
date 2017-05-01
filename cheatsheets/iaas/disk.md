# Disk

## Display a summary of partition types

```markdown
$ sgdisk -L
0700 Microsoft basic data  0c01 Microsoft reserved    2700 Windows RE
3000 ONIE boot             3001 ONIE config           3900 Plan 9
4100 PowerPC PReP boot     4200 Windows LDM data      4201 Windows LDM metadata
4202 Windows Storage Spac  7501 IBM GPFS              7f00 ChromeOS kernel
7f01 ChromeOS root         7f02 ChromeOS reserved     8200 Linux swap
8300 Linux filesystem      8301 Linux reserved        8302 Linux /home
8303 Linux x86 root (/)    8304 Linux x86-64 root (/  8305 Linux ARM64 root (/)
8306 Linux /srv            8307 Linux ARM32 root (/)  8400 Intel Rapid Start
8e00 Linux LVM             a500 FreeBSD disklabel     a501 FreeBSD boot
a502 FreeBSD swap          a503 FreeBSD UFS           a504 FreeBSD ZFS
a505 FreeBSD Vinum/RAID    a580 Midnight BSD data     a581 Midnight BSD boot
a582 Midnight BSD swap     a583 Midnight BSD UFS      a584 Midnight BSD ZFS
a585 Midnight BSD Vinum    a600 OpenBSD disklabel     a800 Apple UFS
a901 NetBSD swap           a902 NetBSD FFS            a903 NetBSD LFS
a904 NetBSD concatenated   a905 NetBSD encrypted      a906 NetBSD RAID
ab00 Recovery HD           af00 Apple HFS/HFS+        af01 Apple RAID
af02 Apple RAID offline    af03 Apple label           af04 AppleTV recovery
af05 Apple Core Storage    bc00 Acronis Secure Zone   be00 Solaris boot
bf00 Solaris root          bf01 Solaris /usr & Mac Z  bf02 Solaris swap
bf03 Solaris backup        bf04 Solaris /var          bf05 Solaris /home
bf06 Solaris alternate se  bf07 Solaris Reserved 1    bf08 Solaris Reserved 2
bf09 Solaris Reserved 3    bf0a Solaris Reserved 4    bf0b Solaris Reserved 5
c001 HP-UX data            c002 HP-UX service         ea00 Freedesktop $BOOT
eb00 Haiku BFS             ed00 Sony system partitio  ed01 Lenovo system partit
ef00 EFI System            ef01 MBR partition scheme  ef02 BIOS boot partition
f800 Ceph OSD              f801 Ceph dm-crypt OSD     f802 Ceph journal
f803 Ceph dm-crypt journa  f804 Ceph disk in creatio  f805 Ceph dm-crypt disk i
fb00 VMWare VMFS           fb01 VMWare reserved       fc00 VMWare kcore crash p
fd00 Linux RAID
```

## Query the udev database for device information

```markdown
$ udevadm info --query=all --name=sda
```
