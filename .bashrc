# OSX settings
if [ $(uname) = 'Darwin' ]; then
  PS1_USER='\[\033[32m\]\u'
  PS1_DIR='\[\033[34m\]\W'
  PS1_BRANCH='\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

  if type rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
  fi

  if type plenv >/dev/null 2>&1; then
    eval "$(plenv init -)"
  fi

  if type direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
  fi

  eval "$(hub alias -s)"

  change-vagrant-dir() {
    cd $(vagrant global-status | awk '/^[[:alnum:]]{7}\s/ { print $NF }' | peco)
  }

  alias cdv='change-vagrant-dir'
  alias ls='ls -vGF'
  alias ll='ls -l'
  alias la='ll -a'
  alias grep='grep --color=auto'
fi

# Linux settings
if [ $(uname) = 'Linux' ]; then
  PS1_USER='\[\033[47;32m\]\u'
  PS1_DIR='\[\033[47;34m\]\W'
  PS1_BRANCH='\[\033[47;31m\]$(__git_ps1)\[\033[47;00m\]\$ '

  . /usr/share/doc/git/contrib/completion/git-completion.bash
  . /usr/share/doc/git/contrib/completion/git-prompt.sh

  jman() {
    LANG=ja_JP.UTF-8 man $1 $2
  }
fi

# Shared settings

# http://qiita.com/quwa/items/3a23c9dbe510e3e0f58e
stty stop undef

SHELL='bash'
HISTSIZE='1000'
HISTTIMEFORMAT='%Y-%m-%dT%T%z '
HISTIGNORE='history:clear:pwd:ls'
GIT_PS1_SHOWDIRTYSTATE=true
# http://ambiesoft.fam.cx/blog/archives/1122
PS1="${PS1_USER}:${PS1_DIR}${PS1_BRANCH}"

# http://qiita.com/spesnova/items/f90b14973120f19bcda1
change-repository-dir() {
  cd $(ghq list --full-path | peco)
}
alias cdr='change-repository-dir'

# peco-history() {
#   history | awk '{ for(i = 3; i < NF; i++) { printf("%s%s", $i, OFS=" "); }; print $NF; }' | sort | uniq | peco | xargs -I {} bash -c {}
# }
# bind -x '"\C-r": peco-history'

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

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
###-end-npm-completion-###
