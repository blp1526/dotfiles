# .bashrc for OSX
# if [ $(uname) = 'Darwin' ]; then
#   if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
#   fi
#
#   if type rbenv >/dev/null 2>&1; then
#     eval "$(rbenv init -)"
#   fi
#
#   if type plenv >/dev/null 2>&1; then
#     eval "$(plenv init -)"
#   fi
#
#   if type pyenv >/dev/null 2>&1; then
#     eval "$(pyenv init -)"
#   fi
#
#   eval "$(hub alias -s)"
#
#   change-vagrant-dir() {
#     cd $(vagrant global-status | awk '/^[[:alnum:]]{7}\s/ { print $NF }' | peco)
#   }
#
#   alias cdv='change-vagrant-dir'
#   alias ls='ls -vGF'
#   alias ll='ls -l'
#   alias la='ll -a'
#   alias grep='grep --color=auto'
#   alias camera='screencapture -i $HOME/Desktop/$(date +%s).png'
# fi
