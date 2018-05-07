#usefull
alias tmux='TERM=xterm-256color tmux'
alias grepr='grep -Rin --exclude-dir={library,_cache,nodejs,node_modules,build,vendors,cache,dist.prod,dist.dev,vendor,coverage,statics,.git,public,storage}'

#bash
if [ -n "$BASH_VERSION" ]; then
    alias bash='. ~/.bashrc'
else
    alias bash='. ~/.zshrc'
fi

# other
alias vagsh="cd ~/projects/vagrant && vagrant ssh"
alias vag7sh="cd ~/projects/php7-dev && vagrant ssh"

#connection
alias cron='ssh cron1.internal'
alias search='ssh search1.internal'
alias import='ssh import1.internal'
alias syslog='ssh syslog1.internal'

alias dev='ssh dev2-infra.eu1.internal -t TERM=xterm-256color tmux a'
alias sdev='ssh dev2-infra.eu1.internal'
alias umdev='sudo umount -l /home/bbr/www'
alias www-php='sudo -u www-data /usr/bin/php'

alias vag='cd /home/bbr/projects/vagrant/ && vagrant up && cd -'

#publish
# alias pu='sudo publish $1'
# alias puns='sudo publish --ns $1'
# 
# alias apu='sudo /var/shared5/scripts/tools/ads/publish'
# alias aapu='sudo /var/shared5/scripts/tools/adsadmin/publish'

##git
alias gitlist='ssh git@server-git'
#makelibrary link
# alias linklib='ln -s ~/www/library/html/ html/library'

# fuck you sudo
alias fuck='sudo $(history -p !!)'


#fortune
alias myfort='fortune ~/config/fortune/quotes'

