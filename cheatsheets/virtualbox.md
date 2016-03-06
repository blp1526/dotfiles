# VirtualBox

## Install Guest Additions

Example: Fedora 23

```markdown
dnf update
dnf install -y gcc
dnf install -y make
dnf install -y kernel-devel
dnf install -y kernel-headers
reboot
```

VirtualBox VM
* Devices
  * Insert Guest Additions CD image

```markdown
mkdir /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
./VBoxLinuxAdditions.run
```

## Network

VirtualBox Preferences

* Network
  * Host-only Network
    * Add vboxnet0

VirtualBox VM Settings

* Network
  * Adapter 1
    * NAT
  * Adapter 2
    * Attached to: Host-only Adapter
    * Name: vboxnet0

## Provisioning

```markdown
mkdir ~/.ghq/github.com/blp1526
cd    ~/.ghq/github.com/blp1526
git clone git@github.com:blp1526/dotfiles.git
cd dotfiles
./setup.sh
```
