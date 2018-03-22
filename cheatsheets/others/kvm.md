# KVM

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
