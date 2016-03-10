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

see http://www.kakiro-web.com/memo/virtualbox-create-virtual-machine-centos6-2.html

* Network
  * Host-only Network
    * Add vboxnet0
    * Adapter
      * IPv4 Address:             192.168.56.1
      * IPv4 Network Mask:        255.255.255.0
      * IPv6 Address:             (blank)
      * IPv6 Network Mask Length: 0
    * DHCP Server
      * Enable Server
      * Server Address:      192.168.56.100
      * Server Mask:         255.255.255.0
      * Lower Address Bound: 192.168.56.101
      * Upper Address Bound: 192.168.56.254

VirtualBox VM Settings

* Network
  * Adapter 1
    * NAT
  * Adapter 2
    * Attached to: Host-only Adapter
    * Name: vboxnet0
