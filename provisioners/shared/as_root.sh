# non-root user
user=user
grep ^$user: /etc/passwd
if ! [ $? -eq 0 ]; then
  adduser $user
  passwd $user
  gpasswd -a $user wheel
fi

# rbenv
if ! [ -e /usr/local/rbenv/bin/rbenv ]; then
  cd /usr/local
  git clone https://github.com/sstephenson/rbenv.git
  mkdir /usr/local/rbenv/plugins
  cd /usr/local/rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git
fi

if ! cat /etc/group | awk -F : '{print $1}' | egrep ^rbenv$; then
  groupadd rbenv
fi
gpasswd -a $user rbenv
chown -R $user:rbenv /usr/local/rbenv

cat << "__EOS__" > /etc/profile.d/rbenv.sh
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
__EOS__

# plenv
if ! [ -e /usr/local/plenv/bin/plenv ]; then
  cd /usr/local
  git clone https://github.com/tokuhirom/plenv.git
  mkdir /usr/local/plenv/plugins
  cd /usr/local/plenv/plugins
  git clone https://github.com/tokuhirom/Perl-Build.git
fi

if ! cat /etc/group | awk -F : '{print $1}' | egrep ^plenv$; then
  groupadd plenv
fi
gpasswd -a $user plenv
chown -R $user:plenv /usr/local/plenv

cat << "__EOS__" > /etc/profile.d/plenv.sh
export PLENV_ROOT=/usr/local/plenv
export PATH="$PLENV_ROOT/bin:$PATH"
eval "$(plenv init -)"
__EOS__

# pip
if type pip >/dev/null 2>&1; then
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
