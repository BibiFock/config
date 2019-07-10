#usefull
alias tmux='TERM=xterm-256color tmux'
alias grepr='grep -Rin --exclude-dir={library,_cache,nodejs,node_modules,build,vendors,cache,dist.prod,dist.dev,vendor,coverage,statics,.git,public,storage}'
alias findit='find . -not -path "./node_modules/*" -iname '

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

# laravel
alias art='php artisan '

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

# youtube-dl
alias youtube-dl-mp3='youtube-dl -x --audio-format "mp3" --add-metadata -o "%(playlist_index)s.%(artist)s-%(title)s.%(ext)s" --restrict-filenames '

alias wget-list='count=1;for url in $(cat ./list.txt); do wget $url -O $count.$(basename $url) && ((count++)); done;'
