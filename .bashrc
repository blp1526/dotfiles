if [ "$(uname)" == "Darwin" ]; then
  alias ll='gls -l --color=auto --group-directories-first'
  export BASH_SILENCE_DEPRECATION_WARNING=1
  if type brew >/dev/null 2>&1; then
    if type kubectl >/dev/null 2>&1; then
      if ! [ -f "$(brew --prefix)/etc/bash_completion.d/kubectl" ]; then
        kubectl completion bash > "$(brew --prefix)/etc/bash_completion.d/kubectl"
      fi
    fi
    source "$(brew --prefix)/etc/bash_completion"
  fi
else
  # Ubuntu
  alias ll='ls -l --color=auto --group-directories-first'
  source "/usr/lib/git-core/git-sh-prompt"
fi

# export
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GPG_TTY=$(tty)

export EDITOR='vim'
export IGNOREEOF=256

if [ "${PATH_ORIG}" == "" ]; then
  export PATH_ORIG="${PATH}"
fi

export PATH=${HOME}/bin:${PATH_ORIG}

c() {
  local previous_dir=$(pwd)
  local selected_dir=$(ghq list --full-path | peco)
  # XXX: case SIGINT
  if [ "${selected_dir}" = "" ]; then
    cd ${previous_dir}
  else
    cd ${selected_dir}
  fi
}

jobs_size() {
  local jobs_size=$(jobs | wc -l)
  if [ "${jobs_size}" -gt 0 ]; then
    echo "[jobs: ${jobs_size}] "
  else
    echo ""
  fi
}

# shell variables
SHELL='bash'
HISTSIZE='10000'
HISTTIMEFORMAT='%Y-%m-%dT%T%z '
HISTIGNORE='history:clear:pwd:ls'

FG_NORMAL='\e[m'
FG_BLACK='\e[30m'
FG_RED='\e[31m'
FG_GREEN='\e[32m'
FG_YELLOW='\e[33m'
FG_BLUE='\e[34m'
FG_MAGENTA='\e[35m'
FG_CYAN='\e[36m'
FG_LIGHT_GRAY='\e[37m'

GIT_PS1_SHOWDIRTYSTATE=true
PS1_JOBS_SIZE=${FG_YELLOW}'$(jobs_size)'
PS1_USER=${FG_GREEN}'\u@\H'
PS1_SEPARATOR=${FG_LIGHT_GRAY}':'
PS1_DIR=${FG_BLUE}'\W'
PS1_BRANCH=${FG_RED}'$(__git_ps1)'
PS1_DOLLAR=${FG_NORMAL}'\n\$ '
PS1="${PS1_JOBS_SIZE}${PS1_USER}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}${PS1_DOLLAR}"

# alias
alias la='ll -a'
alias base58='ruby -r active_support/all -e "puts SecureRandom.base58(24)"'

if [ -e "${HOME}/.asdf" ]; then
  source "${HOME}/.asdf/asdf.sh"
  source "${HOME}/.asdf/completions/asdf.bash"
fi

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# bash-it
if [ -e "${HOME}/src/github.com/Bash-it/bash-it" ]; then
  source "${HOME}/src/github.com/Bash-it/bash-it/completion/available/tmux.completion.bash"
  source "${HOME}/src/github.com/Bash-it/bash-it/completion/available/vagrant.completion.bash"
fi

# only server or Wayland desktop
if [ "$XDG_SESSION_TYPE" != "x11" ]; then
  # disable tty lock
  stty stop undef
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/user/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
