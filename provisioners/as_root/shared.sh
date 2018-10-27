#!/bin/bash

# only root privilege
if [ "$(whoami)" != "root" ] || [ "${HOME}" != "/root" ]; then
  echo "fatal: Use sudo -H"
  exit
fi

echo "BIOS Vendor: $(dmidecode --string bios-vendor)"

user="user"
cat /etc/passwd | grep ^"${user}": >/dev/null 2>&1
if ! [ ${?} -eq 0 ]; then
  adduser "${user}"
  passwd "${user}"
  gpasswd -a "${user}" wheel
  # https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user
  # gpasswd -a "${user}" docker
fi

# goenv
if ! [ -e /usr/local/goenv ]; then
  cd /usr/local
  git clone https://github.com/syndbg/goenv.git

  groupadd goenv
  gpasswd -a $user goenv
  chown -R $user:goenv /usr/local/goenv

  cat << "__EOS__" > /etc/profile.d/goenv.sh
export GOENV_ROOT=/usr/local/goenv
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
__EOS__
fi

# rbenv
if ! [ -e /usr/local/rbenv ]; then
  cd /usr/local
  git clone https://github.com/sstephenson/rbenv.git
  mkdir /usr/local/rbenv/plugins
  cd /usr/local/rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git

  groupadd rbenv
  gpasswd -a $user rbenv
  chown -R $user:rbenv /usr/local/rbenv

  cat << "__EOS__" > /etc/profile.d/rbenv.sh
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
__EOS__
fi

# plenv
if ! [ -e /usr/local/plenv ]; then
  cd /usr/local
  git clone https://github.com/tokuhirom/plenv.git
  mkdir /usr/local/plenv/plugins
  cd /usr/local/plenv/plugins
  git clone https://github.com/tokuhirom/Perl-Build.git

  groupadd plenv
  gpasswd -a "${user}" plenv
  chown -R "${user}":plenv /usr/local/plenv

  cat << "__EOS__" > /etc/profile.d/plenv.sh
export PLENV_ROOT=/usr/local/plenv
export PATH="$PLENV_ROOT/bin:$PATH"
eval "$(plenv init -)"
__EOS__
fi

# pyenv
if ! [ -e /usr/local/pyenv ]; then
  cd /usr/local
  git clone https://github.com/pyenv/pyenv.git

  groupadd pyenv
  gpasswd -a "${user}" pyenv
  chown -R "${user}":pyenv /usr/local/pyenv

  cat << "__EOS__" > /etc/profile.d/pyenv.sh
export PYENV_ROOT=/usr/local/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
__EOS__
fi

# pip
if ! type pip >/dev/null 2>&1; then
  pip install --upgrade pip
  pip install grip
  pip install vim-vint
fi

# sshd
# systemctl enable sshd.service
# systemctl start  sshd.service

# firewalld
# firewall-cmd --get-default-zone
# firewall-cmd --list-all-zones
# firewall-cmd --set-default-zone=zone_name

# SELinux
# sed -i -e 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config
