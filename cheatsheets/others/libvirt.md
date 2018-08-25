# libvirt

## Use shared dir

via https://blog.etsukata.com/2013/07/virtfs-qemu.html

1. At host, run virt-manager(Edit => Virtual Machine Details => Add Hardware => Filesystem)
1. At host, set Filesystem(Source Path: `host dir`, Target path: `tag_name as guest VM, e.g. foo`)
1. At host, run `virsh start guest`
1. At guest, run `cat /sys/bus/virtio/drivers/9pnet_virtio/virtio*/mount_tag`
1. At guest, run `mount -t 9p -o trans=virtio foo /mnt`

## Set IP address

```
# Check mac address
cat /var/lib/libvirt/dnsmasq/default.hostsfile

# Check name
virsh net-list

# Edit xml
virsh net-edit default
```

```
<network>
  <name>default</name>
    <dhcp>
      <range start='192.168.122.100' end='192.168.122.254'/>
      <host mac='xx:xx:xx:xx:xx:xx' name='myvm.example.com' ip='192.168.122.2'/>
    </dhcp>
  </ip>
</network>

```

```
virsh net-destroy default
virsh net-start default
cat /var/lib/libvirt/dnsmasq/default.hostsfile
virsh start myvm
```
