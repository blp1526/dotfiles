#!/bin/bash
set -ux

# http://qiita.com/ftakao2007/items/b332f562b0ea74e9f97e

nmcli device show
read

nmcli connection show
read

nmcli connection modify "Wired connection 1" connection.id "enp0s8"
nmcli connection show
read

nmcli connection modify enp0s8 connection.interface-name "enp0s8"
# ipv4.method manual means not to use DHCP
echo "input 192.168.56.xxx's xxx"
read xxx
nmcli connection modify enp0s8 ipv4.method manual ipv4.address "192.168.56.$xxx/24"

nmcli device disconnect enp0s8
nmcli device connect enp0s8
