function findit {
    find . -iname "*$1*" -print|grep -i "$1"
}

function Go {
    home=~
    dir=/dev/
    subdir=
    if [ -n "$2" ]; then
        home=/home/$2
        if [[ $2 == "beta" ]]; then
            subdir=site/
        fi
    fi
    if [ -n "$1" ]; then
        dest=$home$dir$1/
        if [ $subdir ]; then
            dest=$dest$subdir
        fi
        if [ -d "$dest" ] ; then
            cd $dest
        elif [ -z "$2" ]; then
            echo -e "\e[33m$1 not found, if you want to clone a new repository, enter his name (or press enter to quit)\e[0m"
            read reponame
            if [ -n "$reponame" ] ; then
                cd $home$dir && git clone $reponame && cd $dest
            fi
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
