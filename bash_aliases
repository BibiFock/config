#usefull
alias tmux='TERM=xterm-256color tmux'
alias grepr='grep -Rin'

#bash
alias bash='. ~/.bashrc'

#connection
alias cron='ssh cron1'
alias search='ssh search1'
alias import='ssh import1'
alias syslog='ssh syslog1'

alias dev='ssh dev2-infra.eu1.internal -t TERM=xterm-256color tmux a'
alias mdev='sshfs bbr@dev1.internal:/home/bbr/www /home/bbr/www'
alias umdev='sudo umount -l /home/bbr/www'
alias www-php='sudo -u www-data /usr/bin/php'

#publish
alias publish='cron sudo /var/shared4/scripts/publish $1'
alias publishns='cron sudo /var/shared4/scripts/publish --ns $1'
##git
alias gitlist='ssh git@server-git'
#makelibrary link
alias linklib='ln -s ~/www/library/html/ html/library'
