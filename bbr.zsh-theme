# AVIT ZSH Theme
#
#
source $HOME/config/git-prompt.sh
source $HOME/.bash_aliases

source $HOME/.bash_functions

PROMPT='${vim_mode}%{$reset_color%}$(_user_host) ${_current_dir}%{$fg_bold[magenta]%}$(__git_ps1)%{$reset_color%} %{$reset_color%}
'
PROMPT2=''
RPROMPT=''

local _current_dir="%{$fg[cyan]%}%d%{$reset_color%}"

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

#VIM mode
bindkey -v

vim_ins_mode=""
vim_cmd_mode="%{$fg_bold[red]%}+"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# LS colors, made with http://geoff.greer.fm/lscolors/
#export LSCOLORS="exfxcxdxbxegedabagacad"
#export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
#export GREP_COLOR='1;33'

function _go_complete() {
    local arg
    if (( CURRENT == 3 )); then
        reply=(${$(ls /home/)})
        return 0;
    fi

    reply=(${$(ls ~/www/)})
}
compctl -K _go_complete go
compctl -K _go_complete publish
compctl -K _go_complete publishns

#for manual title
DISABLE_AUTO_TITLE=true

# key bindings
#bindkey "e[1~" beginning-of-line
#bindkey "e[4~" end-of-line
#bindkey "e[5~" beginning-of-history
#bindkey "e[6~" end-of-history
bindkey "e[3~" delete-char
#bindkey "e[2~" quoted-insert
#bindkey "e[5C" forward-word
#bindkey "eOc" emacs-forward-word
#bindkey "e[5D" backward-word
#bindkey "eOd" emacs-backward-word
#bindkey "ee[C" forward-word
#bindkey "ee[D" backward-word
#bindkey "^H" backward-delete-word
## for rxvt
#bindkey "e[8~" end-of-line
#bindkey "e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
#bindkey "eOH" beginning-of-line
#bindkey "eOF" end-of-line
# for freebsd console
#bindkey "e[H" beginning-of-line
#bindkey "e[F" end-of-line
# completion in the middle of a line
#bindkey '^i' expand-or-complete-prefix
