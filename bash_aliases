#usefull
alias tmux='TERM=xterm-256color tmux'
alias grepr='grep -Rin --exclude-dir=library'

#bash
if [ -n "$BASH_VERSION" ]; then
    alias bash='. ~/.bashrc'
else
    alias bash='. ~/.zshrc'
fi

#connection
alias cron='ssh cron1.internal'
alias search='ssh search1.internal'
alias import='ssh import1.internal'
alias syslog='ssh syslog1.internal'

alias dev='ssh dev2-infra.eu1.internal -t TERM=xterm-256color tmux a'
alias mdev='sshfs bbr@dev2-infra.eu1.internal:/home/bbr/www /home/bbr/www'
alias umdev='sudo umount -l /home/bbr/www'
alias www-php='sudo -u www-data /usr/bin/php'

#publish
alias publish='sudo publish $1'
alias publishns='sudo publish --ns $1'
alias publishcron='sudo publish_crons'

##git
alias gitlist='ssh git@server-git'
#makelibrary link
alias linklib='ln -s ~/www/library/html/ html/library'
