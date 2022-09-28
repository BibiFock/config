# FUNCTIONS_DEFINITION
COLOR_RESET="\\033[0m"
COLOR_YELLOW="\\033[33m"
COLOR_GREEN="\\033[32m"
COLOR_RED="\\033[31m"
COLOR_MAGENTA="\\033[35m"
COLOR_BOLD="\\e[1m"

function findit {
    find . -iname "*$1*" -print|grep -i "$1"
}

function mktouch() {
  mkdir -p "$(dirname "$1")" && touch "$1"
}

function Go {
    home=~
    dir=/Documents/dev/
    subdir=
    if [ -n "$1" ]; then
        dest=$home$dir$1/
        if [ $subdir ]; then
            dest=$dest$subdir
        fi
        if [ -d "$dest" ] ; then
            cd $dest
        fi

        if [ -n "$2" ]; then
            # split teminator screen + open vim in the right side
            sleep 0.2
            xdotool key ctrl+shift+E
            sleep 0.2
            xdotool key --delay 5 --repeat 15 ctrl+shift+Left
            sleep 0.2
            xdotool key super+Up
            sleep 0.2
            xdotool type --delay 15 vim
            xdotool key Return
        fi
    else
        ls $dir/www/
    fi
}

# Create function that will run when a certain phrase is typed in terminal
# and tab key is pressed twice
function _Go() {
    # fill local variable with a list of completions
     if [ $COMP_CWORD -eq 1 ]; then
         local COMPLETES=$(ls ~/Documents/dev/)
     elif [ $COMP_CWORD -eq 2 ]; then
         local COMPLETES=$(ls /Users/)
     fi

    # we put the completions into $COMPREPLY using compgen
    COMPREPLY=( $(compgen -W "$COMPLETES" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}
if [ -n "$BASH_VERSION" ]; then
    complete -F _Go Go

    # complete -F _Go publish
    # complete -F _Go publishns
fi

function DlYtList {
    mkdir -p ./$2/
    cd ./$2/

    START=${4:-1}

    youtube-dl -x --audio-format "mp3" --add-metadata --restrict-filenames \
        -o "%(playlist_index)s_%(artist)s-%(title)s.%(ext)s" $1 --playlist-start $START

    count=$START
    for file in $(ls)
    do
        tmpFile=$(basename -s mp3 $file).tmp.mp3
        ffmpeg -loglevel quiet -i $file -codec copy \
            -metadata Genre=$3 \
            -metadata Album=$2 \
            -metadata Track=$count \
            $tmpFile
        mv $tmpFile $file
        ((count++))
    done
}

function DlRendevList {
    cPath=$(pwd)
    finalPath=~/Music/rendev-uke

    cd $finalPath

    DlYtList $1 $2 "rendev-uke" $3

    cd $cPath
}

GIT_FZF_DEFAULT_OPTS="
$FZF_DEFAULT_OPTS
--ansi
--bind='alt-k:preview-up,alt-p:preview-up'
--bind='alt-j:preview-down,alt-n:preview-down'
--bind='ctrl-r:toggle-all'
--bind='ctrl-s:toggle-sort'
--bind='?:toggle-preview'
--bind='alt-w:toggle-preview-wrap'
--preview-window='right:60%'
+1
"

gco() {
  git branch --all --color=always |sed -e 's/remotes\///g' | FZF_DEFAULT_OPTS="$GIT_FZF_DEFAULT_OPTS" fzf|awk '{print $1}'|xargs git co
}

alias glFzf='git log --graph --color=always --date=relative --format="%C(yellow)%h %C(white)%s %C(green)%cd %C(red bold)%an%Creset %C(auto)%d" "$@" '
GIT_FZF_LOG_OPTS="
$GIT_FZF_DEFAULT_OPTS
 --no-sort
 --reverse
 --tiebreak=index
 --preview-window=\"down:30%\"
 --preview=\"echo {2}|xargs git show --stat --color=always\"
"

gshow() {
  glFzf |

  FZF_DEFAULT_OPTS="$GIT_FZF_LOG_OPTS" fzf \
      --bind "ctrl-m:execute:
              (grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
              {}
FZF-EOF"
}

gri() {
 commit=$(
    glFzf |
    FZF_DEFAULT_OPTS="$GIT_FZF_LOG_OPTS" fzf |
    awk '{print $2}'
 );

 git rebase -i $commit~1
}

function ywkVal() {
    for i in $@
    do
        echo -e "$COLOR_YELLOW----------------------------------- [$i]$COLOR_RESET"
        ywk $i validate
        [ $? -ne 0 ] && echo -e "$COLOR_RED\n----------------------------------- [$i]$COLOR_RESET" && break
    done
}

function ywkLintAll() {
    for i in $(yarn -s workspaces info|jq 'keys[]'|sed -e 's/"//g')
    do
        echo -e "$COLOR_YELLOW----------------------------------- [$i]$COLOR_RESET"
        ywk $i lint
        [ $? -ne 0 ] && echo -e "$COLOR_RED\n----------------------------------- [$i]$COLOR_RESET" && break
    done
}


function _Ywk() {
    # fill local variable with a list of completions
    local COMPLETES=$(yarn -s workspaces info|jq 'keys[]'|sed -e 's/"//g')

    # we put the completions into $COMPREPLY using compgen
    COMPREPLY=( $(compgen -W "$COMPLETES" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}

if [ -n "$BASH_VERSION" ]; then
    complete -F _Ywk ywk

    complete -F _Ywk yarn workspace

    complete -F _Ywk ywkVal
fi

