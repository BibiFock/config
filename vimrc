" PLUGINS
"smipMates : http://www.vim.org/scripts/script.php?script_id=2715 // snippets Ts languages
"auto close hmtl tags : http://www.vim.org/scripts/script.php?script_id=2591 // html fermeture automatique des tags
"matchit.vim : http://www.vim.org/scripts/script.php?script_id=39 // amelioration du racourci %
"surround : http://www.vim.org/scripts/script.php?script_id=1697 // habillage d'une chaîne de caractére avec un tag html par exemple
" syntax
"php.wim : http://www.vim.org/scripts/script.php?script_id=1571 // amélioration de la prise en charge de la syntaxe php
" colorscheme
"solarized : http://www.vim.org/scripts/script.php?script_id=3520
" refresh browser
" https://github.com/mkitt/browser-refresh.vim
" plugin toggle
" http://www.vim.org/scripts/script.php?script_id=895

" .vimrc des tones d'exemples en ligne ' ultimate vimrc ' notamment.
" code to try for open big files
" Files become read only
"if !exists("my_auto_commands_loaded")
  "let my_auto_commands_loaded = 1
  "" Large files are > 10M
  "" Set options:
  "" eventignore+=FileType (no syntax highlighting etc
  "" assumes FileType always on)
  "" noswapfile (save copy of file)
  "" bufhidden=unload (save memory when other file is viewed)
  "" buftype=nowritefile (is read-only)
  "" undolevels=-1 (no undo possible)
  "let g:LargeFile = 1024 * 1024 * 10
  "augroup LargeFile
    "autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    "augroup END
  "endif

" vim bab: https://github.com/odolbeau/vim-config/blob/master/_vimrc#L69
" mon vimrc
" GLOBAL SETTINGS"
filetype on              " filetype detection
filetype plugin on
filetype indent on
"" syntax
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.conf set filetype=dosini

"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'smarty-syntax'
Bundle 'lunaru/vim-less'
Bundle 'matchit.zip'


Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['html']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.svn$\|_cache|_config\|branches\|tags$',
  \ 'file': '\.exe$\|\.so$\|\.dat\|\.jpg\|\.png$'
  \ }
let g:ctrlp_clear_cache_on_exit=0

Bundle 'mattn/emmet-vim'

"au BufRead,BufNewFile *.tpl set filetype=smarty

set nocp                    " sets vi compatible mode : (nocp|cp)
set wrap                    " long lines wrap : (nowrap|wrap)
set nu                        " line numbering : (nu\nonu)
set ch=3                    " number of lines used for the command-line
set    ru                        " ruler : show cursor position below each window (noru|ru)
" set noeb                    errorbells : ring the bell for error messages (noeb|eb)"
" Height of the command bar
set cmdheight=2

"Explore
let g:netrw_liststyle=3
"let g:netrw_browse_split = 2
"let g:netrw_altv = 1

"status line
set laststatus=2
set statusline+=%{SyntasticStatuslineFlag()}
set statusline=%f\ " Filename
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{&ff}/%Y] " Show filetype in statusline
set statusline+=\ [%<%{getcwd()}] " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info

"Editor
"
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
"set viminfo='10,\"100,:20,%,n~/.viminfo
"
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" SEARCH"
set ignorecase                " ignorecase : ignore case when using a search pattern (noic|ic)
set smartcase                " smartcase : override 'ignorecase' when pattern has upper case characters (noscs|scs)
set    hls                        " hlsearch : highlight all matches for the last used search pattern (nohls|hls)""
set winminheight=0              " windows can be 0 line high

"indentation
set list
set ai                        " autoindent : automatically set the indent of a new line
set si                        " do clever autoindenting
set softtabstop=4                       " tab = 4 space
set shiftwidth=4
set expandtab                           " no more tabs, only spaces!
set shiftround                          " when at 3 spaces, and I hit > ... go to 4, not 7"
set noswapfile                          " No more swap file!
set colorcolumn=80,120                      " Highlight column 80

" FONTS
syntax enable
"set background=light                    " dark background is better!
let php_sql_query = 1                   " SQL queries
let php_htmlInStrings = 1               " HTML
"let php_folding = 1               " folding function and class

" Set extra options when running in GUI mode
if has("gui_running")
    "set guioptions-=T
    "set guioptions+=e
    "set guioptions-=lrb
    "set guioptions-=L
    set guioptions=Ace
    set t_Co=256
    set guifont=Monospace\ 8
    colorscheme solarized
    set guitablabel=%M\ %t
else
    set t_Co=256
    set background=dark
    "let g:solarized_termcolors=256
    "colorscheme solarized
    colorscheme xoria256
    highlight ColorColumn ctermbg=darkgrey guibg=#666666
    "au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    "au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    "au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    "au VimEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
endif

"coloration command ligne for each mode
au InsertEnter * hi StatusLine term=reverse ctermbg=4 gui=undercurl guisp=Magenta
au InsertLeave * hi StatusLine term=reverse ctermfg=15 ctermbg=8 gui=bold,reverse
"tab coloration
hi TabLineFill ctermfg=0 ctermbg=0
hi TabLineSel ctermfg=15 ctermbg=8
hi TabLine ctermfg=lightGray ctermbg=0

" DISPLAY"
set foldenable                " set to display all folds open
set foldmethod=marker        " folding type: (manual|indent|expr|marker|syntax)
set lsp=9                   " linespace : number of pixel lines to use between characters
set ts=4                    " tabstop: number of spaces a <Tab> in the text stands for
set sw=4                    " shiftwidth : number of spaces used for each step of (auto)indent
set scrolloff=1000            " number of screen lines to show around the cursor
set listchars=trail:¤,tab:>-,nbsp:•     " Show blank spaces and tabs at the end of a line
set enc=utf-8
set showcmd                    " Affiche la commande en cours de saisie en bas à droite
set cursorline                 "Soulignement de la ligne courante
highlight Folded gui=bold "Surligne la ligne courante en gris
set complete=.,w,b,i    "       default: .,w,b,u,t,i

"show extra white space
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"switch dir to current open file
autocmd BufEnter * silent! lcd %:p:h

" Activer la sauvegarde
set backup
" Backup dans ~/.vim/backup
if filewritable("~/.vim/backup") == 2
    " comme le répertoire est accessible en écriture,
    " on va l'utiliser.
    set backupdir=$HOME/.vim/backup
else
    if has("unix") || has("win32unix")
        " C'est c'est un système compatible UNIX, on
        " va créer le répertoire et l'utiliser.
        call system("mkdir $HOME/.vim/backup -p")
        set backupdir=$HOME/.vim/backup
    endif
endif
"set noswapfile



" NERDTree
let g:NERDTreeWinPos = "right"
let NERDTreeMinimalUI = 1
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>

" Treat long lines as break lines (useful when moving around in them)
map k gk
map <Up> gk
map j gj
map <Down> gj

"Tab deal
map <C-Left> gT
map <C-Right> gt

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l"

"replace all tab
cmap cst %s:\%V\t:    :g<CR>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

"functionlist
"map <F2> :Flisttoggle<CR>
map <F9> :TlistToggle<CR>
let Tlist_Process_File_Always = 1
" set the names of flags
let tlist_php_settings = 'php;c:class;f:function;d:constant'
" close all folds except for current file
let Tlist_File_Fold_Auto_Close = 1
" make tlist pane active when opened
let Tlist_GainFocus_On_ToggleOpen = 1
" width of window
let Tlist_WinWidth = 40
" close tlist when a selection is made
let Tlist_Close_On_Select = 1

map <F8> :TagbarToggle<CR>

" HTML AUTO CLOSE TAG
au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim        " hmtl_autoclosetag.vim

"use full file
:command! Myconf tabe ~/.vimrc

if isdirectory(expand("~/.vim/snippets/"))
    :command! Mysnipp tabe $HOME/.vim/snippets/
endif

if filereadable(expand("~/.vim/usefull"))
    :command! Myuse tabe $HOME/.vim/usefull
endif

if filereadable(expand("~/usefull_var"))
    :command! Myvar tabe $HOME/usefull_var
endif

if isdirectory(expand("~/www/library"))
    :command! Dbconf tabe $HOME/www/library/trunk/php/classes/Wb/Controller/Action.php
endif

" Clean code function
function! CleanCode(all)
    "silent! %s#}\(while\|else\)#} \1#g
    "silent! %s#else if#elseif#g
    "silent! %s#\(foreach\|if\)(#\1 (#g
    "silent! %s#\()\|else\|if\){#\1 {#g
    " retab
    "if &expandtab
    "    silent! %retab " Replace tabs with spaces
    "    silent! %s/\r//eg " Turn DOS returns ^M into real returns
    "    silent! %s= *$==e " Delete end of line blanks
    "    silent! %s/\%u00a0/ /g
    "else
    "    silent! %s/\s\+$\| \+\ze\t//g
    "endif
    if a:all
        silent! %retab " Replace tabs with spaces
    endif

    "delete end of line
    silent! %s/\r//eg " Turn DOS returns ^M into real returns
    silent! %s= *$==e " Delete end of line blanks
    silent! %s/\%u00a0/ /g
    silent! %s/\s\+$\| \+\ze\t//g

    echo "Cleaned up this mess."
endfunction

"reload snippet
function! SnippetsUpdate(snip_dir)
  call ResetSnippets()
  call GetSnippets(a:snip_dir, '_')
  call GetSnippets(a:snip_dir, &ft)
endfunction

function! GoTo(site)
    let str = $HOME.'/www/'.a:site
    if isdirectory(str)
         exe 'NERDTree '.str.'/trunk/'
    else
        echoerr 'Directory not found: "'.str.'"'
    endif
endfunction
:command! -nargs=1 Go call GoTo(<f-args>)

if has("gui_running")
    "finally we launch nerdtree
    autocmd VimEnter * NERDTree
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader shortcut
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" fast buffers opening
map <leader>b :CtrlPBuffer<cr>

" Toggle list
map <leader><Space> :set list!<CR>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>ts :tab split<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" This command will cause SnippetsUpdate() with parameter <your_snip_dir>
:map <leader>n :call SnippetsUpdate('~/.vim/snippets/')<CR>
"resize vertical split
map <leader>f :vertical resize 200<CR>
map <leader>r :vertical resize 90<CR>
map <leader>s :vertical resize 10<CR>

"reload conf
map <leader>c :so %<CR>

" shortcut
nmap <silent> <F7> :call CleanCode(0)<CR>
nmap <silent> <F9> :call CleanCode(1)<CR>

