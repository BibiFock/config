# AVIT ZSH Theme
#
#

source $HOME/config/git-prompt.sh
source $HOME/.bash_aliases

source $HOME/.bash_functions

PROMPT='$(_user_host) ${_current_dir}%{$fg_bold[magenta]%}$(__git_ps1)%{$reset_color%}%{$reset_color%}
'
PROMPT2=''
RPROMPT=''

local _current_dir="%{$fg[cyan]%}%3~%{$reset_color%}"

function _user_host() {
    me="%n::%m"
    if [ "`id -u`" -eq 0 ]; then
        color="red"
    else
        color="green"
    fi

    if [[ -n $me ]]; then
        echo "%{$fg[$color]%}%n%{$fg[cyan]%}::%{$fg[yellow]%}%m%{$reset_color%}"
    fi
}

#for show staged an unstaged
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
#show status for head
export GIT_PS1_SHOWUPSTREAM="auto"

# LS colors, made with http://geoff.greer.fm/lscolors/
#export LSCOLORS="exfxcxdxbxegedabagacad"
#export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
#export GREP_COLOR='1;33'

