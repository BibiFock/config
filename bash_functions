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
	svn st -u | grep -v " _cache/" | grep -v "html/library" | grep -v ".ctrlp"
}

function xsvnstdiff {
	svn diff $@ -r BASE:HEAD | colordiff | less -R
}


function xmail {
    cat $1  | mail -s "... envoi de mon fichier" sr@webedia.fr
}


function go {
    if [ -n "$1" ]; then
    	cd ~/www/$1/trunk/
    fi
}