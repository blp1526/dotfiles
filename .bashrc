export LANG=en_US.UTF-8
export PATH=$PATH:$HOME/.nodebrew/current/bin

SHELL='bash'
EDITOR='vim'
HISTSIZE='50000'
HISTTIMEFORMAT='%Y-%m-%dT%T%z '
HISTIGNORE='history:clear:pwd:ls'

alias ls='ls -G'
alias ll='ls -l'
alias la='ll -a'
alias grep='grep --color=auto'

# http://qiita.com/quwa/items/3a23c9dbe510e3e0f58e
stty stop undef

GIT_PS1_SHOWDIRTYSTATE=true

PS1_USER='\[\033[32m\]\u@\h'
PS1_DIR='\[\033[34m\]\W'
PS1_BRANCH='\[\033[31m\]$(__git_ps1)\n\[\033[00m\]\$ '
export PS1="${PS1_USER}:${PS1_DIR}${PS1_BRANCH}"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
