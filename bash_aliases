alias tmux='TERM=xterm-256color tmux'
alias grepr='grep -Rin'

alias cron='ssh cron1'
alias search='ssh search1'
alias import='ssh import1'
alias syslog='ssh syslog1'

alias dev='ssh dev1.internal -t TERM=xterm-256color tmux a'
alias mdev='sshfs bbr@dev1.internal:/home/bbr/www /home/bbr/www'
alias umdev='sudo umount -l /home/bbr/www'
alias www-php='sudo -u www-data /usr/bin/php'
#publish
alias publish='cron sudo /var/shared4/scripts/publish $1'
##git
alias gitlist='ssh git@server-git'

##seelog
alias seelog='tail $1 | sed -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/\x1b[1;36m&\x1b[0m/g" -e "s/\[ERROR [^]]*]/\x1b[1;31m\n&\x1b[0m/;" -e "s/http_host:[^,]*/\x1b[1;32m\n&\x1b[0m/;" -e "s/Type:[^,]*/\x1b[1;33m\n&\x1b[0m/g" -e "s/request_uri:[^,]*/\x1b[1;35m&\x1b[0m/g" -e "s/referer/\n&/g" -e "s/^/------------------------------------------\n/g"'

