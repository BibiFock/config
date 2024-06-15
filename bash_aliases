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

# docker
alias dockUp='docker-compose up -d'
alias dockDown='docker-compose down'

# laravel
alias art='php artisan '

#publish

##git
alias gitlist='ssh git@server-git'
#makelibrary link

# fuck you sudo
#alias fuck='sudo $(history -p !!)'

#fortune
alias myfort='fortune ~/config/fortune/quotes'

# youtube-dl
alias yt-dl-mp3='yt-dlp -x --audio-format "mp3" --add-metadata -o "%(playlist_index)s.%(artist)s-%(title)s.%(ext)s" --restrict-filenames '

alias wget-list='count=1;for url in $(cat ./list.txt); do wget $url -O $(echo $count.$(basename $url) | sed -e "s/^[1-9]\\./0&/g") && ((count++)); done;'

alias nv='nvim'
