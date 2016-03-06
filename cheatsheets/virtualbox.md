# VirtualBox

## Guest Additions

### Installation

Fedora 23 Example

```
dnf update
dnf install -y gcc
dnf install -y make
dnf install -y kernel-devel
dnf install -y kernel-headers
reboot
```

Devices => Insert Guest Additions CD image...

```
mkdir /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
./VBoxLinuxAdditions.run
```

If any troubles, see [this](http://kaworu.jpn.org/kaworu/2013-07-29-1.php).
