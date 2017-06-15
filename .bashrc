# ssh-agent settings
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
  case $SSH_AUTH_SOCK in
  /tmp/*/agent.[0-9]*)
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
  esac
elif [ -S $agent ]; then
  export SSH_AUTH_SOCK=$agent
else
  echo "no ssh-agent"
fi

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

if [ -e /etc/arch-release ]; then
  . /usr/share/bash-completion/bash_completion
  . /usr/share/git/completion/git-completion.bash
  . /usr/share/git/git-prompt.sh
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
PS1_DIR='\[\033[34m\]\W'
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

## https://wiki.archlinux.org/index.php/Color_output_in_console#man
cman() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

alias c='change-repository-dir'
alias ll='ls -lip --color=auto' # 'i' shows inode
alias la='ll -a'
alias tree='tree -I ".git|tags|vendor|node_modules"'
alias inode='stat -c %i'
alias dmesg='dmesg --human --color=always'

if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

source ~/.npm-completion.sh
