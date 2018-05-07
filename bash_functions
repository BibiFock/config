########################
# fonctions perso a seb
########################
function xgrep {
    find . -iname "*.$1" | xargs grep -i "$2"
}

function xsvnadd {
    svn status | grep '\?' | grep -v '_cache' | grep -v 'library' | awk '{print $2;}' | xargs svn add
}

function xsvnrm {
    svn status | grep '\!' | awk '{print $2;}' | xargs svn rm
}

function xsvnrevert {
    svn status | grep '\M' | awk '{print $2;}' | xargs svn revert
}

function xsvndiff {
    svn diff $@ | colordiff | less -R
}

function xsvnst {
    #svn st -q -u
    #svn st -u --ignore-externals | grep -v "_cache/" | grep -v "html/library" | grep -v ".ctrlp" | grep -v "^X"
    svn st -u --ignore-externals | grep -vE "_cache/|html/library|.ctrlp|^X"
}

function xsvnstdiff {
    svn diff $@ -r BASE:HEAD | colordiff | less -R
}


function xmail {
    cat $1  | mail -s "... envoi de mon fichier" bbr@mail.com
}


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

function seelog {
    tail "$1" | sed -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/\x1b[1;36m&\x1b[0m/g" \
    -e "s/\[ERROR [^]]*]/\x1b[1;31m\n&/;" \
    -e "s/Type:[^,]*/\x1b[1;33m\n&/g" \
    -e "s/http_host:[^,]*/\x1b[1;32m\n&\x1b[0m/;"  \
    -e "s/url:[^,]*/\x1b[1;32m\n&\x1b[0m/;" \
    -e "s/request_uri:[^,]*/\x1b[    1;35m&\x1b[0m/g" \
    -e "s/referer/\x1b[0m\n&/g" -e "s/^/-\x1b[1;31m\\\\\x1b[0m------------------------------------------\n/g" \
    -e "s/^\(.*\n\)\(.*\n\)\(.*\n\)\(.*\n\)\(.*\n\)\(.*\)/\x1b[0m\1 _\\\\,,        \2\"-=\\\\~     _  \3   \\\\\\\\~___( ~ \4  _|\/---\\\\\\\\_  \5 \\\\        \\\\  \6/g"
}
