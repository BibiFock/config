function findit {
    find . -iname "*$1*" -print|grep -i "$1"
}

function Go {
    home=~
    dir=/dev/
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
         local COMPLETES=$(ls ~/dev/)
     elif [ $COMP_CWORD -eq 2 ]; then
         local COMPLETES=$(ls /home/)
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

function DlRendevList {
    finalPath=~/Music/rendev-uke/$2/

    mkdir -p $finalPath

    cd $finalPath

    youtube-dl -x --audio-format "mp3" --add-metadata --restrict-filenames \
        -o "%(playlist_index)s_%(artist)s-%(title)s.%(ext)s" $1

    count=1
    for file in $(ls)
    do
        tmpFile=$(basename -s mp3 $file).tmp.mp3
        ffmpeg -loglevel quiet -i $file -codec copy \
            -metadata Genre="rendev-uke" \
            -metadata Album=$2 \
            -metadata Track=$count \
            $tmpFile
        mv $tmpFile $file
        ((count++))
    done

    cd -
}


GIT_FZF_DEFAULT_OPTS="
$FZF_DEFAULT_OPTS
--ansi
--height='80%'
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
