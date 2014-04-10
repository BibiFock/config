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
    cat $1  | mail -s "... envoi de mon fichier" sr@webedia.fr
}


function go {
    if [ -n "$1" ]; then
    	cd ~/www/$1/
    fi
}

# Create function that will run when a certain phrase is typed in terminal
# and tab key is pressed twice
function _go_complete() {
    # fill local variable with a list of completions
    local COMPLETES=$(ls ~/www/)

    # we put the completions into $COMPREPLY using compgen
    COMPREPLY=( $(compgen -W "$COMPLETES" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}
complete -F _go_complete go

complete -F _go_complete publish


