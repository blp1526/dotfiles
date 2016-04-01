# Storage

## MBR / GPT

| | MBR | GPT |
|:-:|:-:|:-:|
| Name | Master Boot Record | GUID Partition Table |
| Firmware | BIOS / UEFI | UEFI |
| Max Partition | 4 | 128 |
| Command | fdisk / parted | gdisk/ parted |

http://tooljp.com/linux/doc/01OS/007UEFI/UEFI.html

http://d.hatena.ne.jp/syuu1228/20130103/1357165915

## LVM commands

```
lvscan
vgscan
pvscan
lvdisplay
vgdisplay
pvdisplay
```

http://qiita.com/rsooo/items/be3b8c4ecc944393e2d9
