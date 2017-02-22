# git completion & prompt
if [ -e /etc/fedora-release ]; then
  . /usr/share/bash-completion/bash_completion
  . /usr/share/doc/git-core-doc/contrib/completion/git-completion.bash
  . /usr/share/doc/git-core-doc/contrib/completion/git-prompt.sh
fi

if [ -e /etc/lsb-release ]; then
  . /etc/profile.d/bash_completion.sh
  . /etc/bash_completion.d/git-prompt
fi

# shell variables
SHELL='bash'
HISTSIZE='1000'
HISTTIMEFORMAT='%Y-%m-%dT%T%z '
HISTIGNORE='history:clear:pwd:ls'

## https://jp.linux.com/news/linuxcom-exclusive/416957-lco20140519
## http://ambiesoft.fam.cx/blog/archives/1122
GIT_PS1_SHOWDIRTYSTATE=true
PS1_USER='\[\033[32m\]\u'
PS1_OS='\[\033[35m\]{$(uname)}'
PS1_JOBS='\[\033[33m\][jobs:\j]'
PS1_SEPARATOR='\[\033[37m\]:'
PS1_DIR='\[\033[34m\]\w'
PS1_BRANCH='\[\033[31m\]$(__git_ps1)\[\033[00m\]'
PS1_DOLLAR='\n\$ '
PS1="${PS1_USER}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}${PS1_DOLLAR}"

# disable tty lock
## http://qiita.com/quwa/items/3a23c9dbe510e3e0f58e
stty stop undef

## http://qiita.com/spesnova/items/f90b14973120f19bcda1
change-repository-dir() {
  cd $(ghq list --full-path | peco)
}

ssh-agent-add() {
  eval `ssh-agent`
  ssh-add
}

alias c='change-repository-dir'
alias ll='ls -li' # 'i' shows inode
alias la='ll -a'
alias tree='tree -I ".git|tags|vendor|node_modules"'
alias inode='stat -c %i'

if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

source ~/.npm-completion.sh
