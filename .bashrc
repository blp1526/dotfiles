# ssh-agent
## http://qiita.com/sonots/items/2d7950a68da0a02ba7e4
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
GIT_PS1_SHOWDIRTYSTATE=true
## https://jp.linux.com/news/linuxcom-exclusive/416957-lco20140519
## http://ambiesoft.fam.cx/blog/archives/1122
## http://news.mynavi.jp/articles/2009/09/09/bash/
PS1_USER='\[\033[32m\]\u'
PS1_OS='\[\033[35m\]{$(uname)}'
PS1_JOBS='\[\033[33m\][jobs:\j]'
PS1_SEPARATOR='\[\033[37m\]:'
PS1_DIR='\[\033[34m\]\W'
PS1_BRANCH='\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
PS1="${PS1_USER}${PS1_OS}${PS1_JOBS}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}"

# disable tty lock
## http://qiita.com/quwa/items/3a23c9dbe510e3e0f58e
stty stop undef

# functions
jman() {
  LANG=ja_JP.UTF-8 man $1 $2
}

manselect() {
  if [ $# -ne 1 ]; then
    echo 'ArgumentError: wrong number of arguments (expected 1)'
    return 1
  fi
  man $1 > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "ArgumentError: no manual entry for $1"
    return 1
  fi
  selected=$(man -aw $1 | peco)
  args=$(basename $selected | awk -F . '{ printf("%s %s\n", $2, $1) }')
  man $args
}

## http://qiita.com/spesnova/items/f90b14973120f19bcda1
change-repository-dir() {
  cd $(ghq list --full-path | peco)
}
alias c='change-repository-dir'
alias p='ps axfo user,pid,pgid,ppid,sid,stat,cmd'

if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# npm-completion
if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
