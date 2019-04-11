# network

## display hostname

So as not to set hostname unintentionally, you should use `uname -n` instead of `hostname`.

## sample .ssh/config

```
ServerAliveInterval 15
ServerAliveCountMax 10
TCPKeepAlive yes
IdentitiesOnly yes
# StrictHostKeyChecking no
# UserKnownHostsFile=/dev/null

Host foo
  User bar
  HostName XXX.XXX.XXX.XXX
```
