# VMware Fusion

## Fixed IP Address

Add settings to /Library/Preferences/VMware\ Fusion/vmnet8/dhcpd.conf

```markdown
####### VMNET DHCP Configuration. End of "DO NOT MODIFY SECTION" #######

host xxxx {
        hardware ethernet XX:XX:XX:XX:XX:XX;
        fixed-address XXX.XXX.XXX.XXX;
}
```

Restart VMware Fusion.
