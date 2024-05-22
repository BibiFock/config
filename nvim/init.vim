"""""""""""""""""""""""""""""""""""""""""""""""
"    INDEX
"        _PLUGINS
"        _EDITOR
"        _COLORSCHEME
"        _BACKUP
"        _FUNCTIONS
"        _COMMANDS
"        _COMMANDS_QUICK_FILES
"        _SHORTCUTS
"        _SHORTCUTS_LEADER
""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""
" _PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Post-update hook can be a lambda expression
set rtp+=~/config/fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
let g:fzf_commits_log_options = '--color=always --format="%C(green)%cd %C(red bold)%an%Creset %C(yellow)%h %C(white)%s %C(auto)%d" --graph --date-order --date=relative'


" Colorscheme
Plug 'vim-scripts/xoria256.vim'

Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims = 1

" bracket matchers
Plug 'andymass/vim-matchup'

" Bundle 'Toggle'
Plug 'lukelbd/vim-toggle'

"git tool for vim
Plug 'tpope/vim-fugitive'

" "Fast inner selector
Plug 'gcmt/wildfire.vim'

Plug 'jlanzarotta/bufexplorer'

Plug 'lukas-reineke/indent-blankline.nvim'

" Plug 'snipMate'
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit=expand("~/config/nvim/snippets")
let g:UltiSnipsSnippetDirectories=["UltiSnips", expand("~/config/nvim/snippets")]
let g:UltiSnipsEnableSnipMate=1

"bottom bar
Plug 'vim-airline/vim-airline'

" " vim resizer
Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>r'

Plug 'sheerun/vim-polyglot'

Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'pmizio/typescript-tools.nvim'


call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""
" _EDITOR
""""""""""""""""""""""""""""""""""""""""""""""
filetype on              " filetype detection
filetype plugin on
filetype indent on

set nocp  " sets vi compatible mode : (nocp|cp)
set wrap  " long lines wrap : (nowrap|wrap)
set nu    " line numbering : (nu\nonu)
set ru    " ruler : show cursor position below each window (noru|ru)
set lazyredraw "optimize redrawing

"Explore
let g:netrw_banner = 0
let g:netrw_liststyle=3
let g:netrw_altv=0
let g:netrw_winsize=100
let g:netrw_win=20

"status line
set laststatus=2

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "11  :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
" set viminfo='10,\"11,:20,%,n~/.viminfo

" SEARCH"
set ignorecase      " ignorecase : ignore case when using a search pattern (noic|ic)
set smartcase       " smartcase : override 'ignorecase' when pattern has upper case characters (noscs|scs)
set hls             " hlsearch : highlight all matches for the last used search pattern (nohls|hls)""
set winminheight=0  " windows can be 0 line high

"indentation
set list
set ai                  " autoindent : automatically set the indent of a new line
set si                  " do clever autoindenting
set softtabstop=2
set shiftwidth=2
set expandtab           " no more tabs, only spaces!
set shiftround          " when at 3 spaces, and I hit > ... go to 4, not 7"
set noswapfile          " No more swap file!
set colorcolumn=80,120  " Highlight column 80

" FONTS
syntax on

" DISPLAY"
set foldenable              " set to display all folds open
set foldmethod=marker       " folding type: (manual|indent|expr|marker|syntax)
set lsp=9                   " linespace : number of pixel lines to use between characters
set ts=2                    " tabstop: number of spaces a <Tab> in the text stands for
set sw=2                    " shiftwidth : number of spaces used for each step of (auto)indent
set scrolloff=1000          " number of screen lines to show around the cursor
set listchars=trail:¤,tab:>-,nbsp:•     " Show blank spaces and tabs at the end of a line
set enc=utf-8
set showcmd                 " Affiche la commande en cours de saisie en bas à droite
set cursorline              "Soulignement de la ligne courante
set complete=.,w,b,i        " default: .,w,b,u,t,i
set splitbelow              " force split open below
set splitright              " force vsplit open right
set synmaxcol=3200           " limit for line coloration


""""""""""""""""""""""""""""""""""""""""""""""
" _COLORSCHEME
""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
set t_Co=256
colorscheme xoria256
highlight ColorColumn ctermbg=237
" for ibl.config hilight
highlight Whitespace ctermfg=240

"redef des msg de warning car trop discret par défaut
" hi WarningMsg ctermfg=15  ctermbg=166

hi CursorLineNr ctermbg=237 guibg=#3a3a3a cterm=none gui=none
highlight DiagnosticInfo ctermfg=242
highlight DiagnosticError ctermfg=9

sign define DiagnosticSignError text= texthl=DiagnosticSignError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint

"coloration command ligne for each mode
au InsertEnter * hi StatusLine term=reverse ctermbg=4
au InsertLeave * hi StatusLine term=reverse ctermfg=15 ctermbg=8
"tab coloration
hi TabLineFill ctermfg=0 ctermbg=0
hi TabLineSel ctermfg=15 ctermbg=8
hi TabLine ctermfg=lightGray ctermbg=0

"show extra white space
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


""""""""""""""""""""""""""""""""""""""""""""""
" _BACKUP
""""""""""""""""""""""""""""""""""""""""""""""
" Activer la sauvegarde
set backup
" Backup dans ~/.vim/backup
if filewritable("~/config/nvim/backup") == 2
  " Since the directory is writable,
  " we'll use it.
  set backupdir=$HOME/config/nvim/backup
else
  if has('unix') || has('win32unix')
    " If it's a UNIX-compatible system, we'll
    " create the directory and use it.
    call mkdir($HOME . '/config/nvim/backup', 'p')
    set backupdir=$HOME/config/nvim/backup
  endif
endif


""""""""""""""""""""""""""""""""""""""""""""""
" _FUNCTIONS
""""""""""""""""""""""""""""""""""""""""""""""
" Clean code function
function! CleanCode(all)
    if a:all
        silent! %retab " Replace tabs with spaces
    endif

    "delete end of line
    silent! %s/\r//eg " Turn DOS returns ^M into real returns
    silent! %s/ *$//eg " Delete end of line blanks
    silent! %s/\%u00a0/ /g
    silent! %s/\s\+$\| \+\ze\t//g

    echo "Cleaned up this mess."
endfunction

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! GoTo(site, ...)
    let str = $HOME.'/dev/'.a:site.'/'
    if !isdirectory(str)
        echoerr 'Directory not found: "'.str.'"'
        return
    endif

    if (a:0 > 0)
        exe 'Explore! '.str
    else
        exe 'FZF '.str
    endif
endfunction

fun! GoToComplete(A,L,P)
    let path = expand('~/dev/')
    return split(substitute(globpath(path, a:A."*"), path, "", "g"), "\n")
endfun

""""""""""""""""""""""""""""""""""""""""""""""
" _COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""
" automatically search in root project path
command! ProjectFiles execute 'FZF' s:find_git_root()

"Go function
command! -nargs=+ -complete=customlist,GoToComplete Go call GoTo(<f-args>)

"switch dir to current open file
autocmd BufEnter * silent! lcd %:p:h

""""""""""""""""""""""""""""""""""""""""""""""
" _COMMANDS_QUICK_FILES
""""""""""""""""""""""""""""""""""""""""""""""
"use full file
:command! Myconf tabe $MYVIMRC

if isdirectory(expand("~/.vim/snippets/"))
  :command! Mysnipp tabe $HOME/.vim/snippets/
endif

if filereadable(expand("~/.vim/usefull"))
  :command! Myuse tabe $HOME/.vim/usefull
endif

if filereadable(expand("~/.vim/todo"))
  :command! Mytodo tabe $HOME/.vim/todo
endif

if filereadable(expand("~/dev/vpn/todo"))
  :command! Wtodo tabe $HOME/dev/vpn/todo
endif

if filereadable(expand("~/dev/divers/README.md"))
  :command! Myvar tabe $HOME/dev/divers/README.md
endif

if isdirectory(expand("~/www/library"))
  :command! Dbconf tabe $HOME/www/library/php/classes/Wb/Controller/Action.php
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" _SHORTCUTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F2> :20Lexplore!<CR>

" Treat long lines as break lines (useful when moving around in them)
map k gk
map <Up> gk
map j gj
map <Down> gj

"Tab deal
map ez gT
map ze gt

"on copy/paste go to the end of text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l"

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  _SHORTCUTS_LEADER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = " "
let g:mapleader = " "

" relaod config
nnoremap <leader>c :so %<cr>

" Fast saving
nmap <leader>w :w!<cr>

" fast buffers opening
nmap <leader>oi :Buffers<cr>
nmap <leader>io :ProjectFiles<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>ts :tab split<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>te :tabedit! %<cr>

" " This command will cause SnippetsUpdate() with parameter <your_snip_dir>
" map <leader>n :call SnippetsUpdate('~/.vim/snippets/')<CR>

" clean code
nmap <silent> <F7> :call CleanCode(1)<CR>


"clear search hl
map <leader>h :noh<CR>

"get current file full name
nmap <Leader>pwd :echo expand('%:p')<Cr>

nmap <leader>fo :r !fortune ~/config/fortune/quotes<Cr>

" " typescript command
nmap <Leader>a :ALEGoToDefinition<CR>
nmap <Leader>as :ALEGoToDefinition -split<CR>
nmap <Leader>aa :ALEGoToDefinition -vsplit<CR>
nmap <Leader>at :ALEGoToDefinition -tab<CR>
nmap <Leader>i :ALEImport<CR>
nmap <Leader>f :ALEFirst<CR>
nmap <Leader>fn :ALENext<CR>

lua << EOF
require("config")
EOF
