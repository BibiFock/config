""""""""""""""""""""""""""""""""""""""""""""""
"    INDEX
"        _GLOBAL_SETTINGS
"        _SYNTAX
"        _BUNDLES
"        _BUNDLES_TEST
"        _EDITOR
"        _BACKUP
"        _COLORSCHEME
"        _FUNCTIONS
"        _COMMANDS
"        _COMMANDS_QUICK_FILES
"        _SHORTCUTS
"        _SHORTCUTS_LEADER
""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""
" _GLOBAL_SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""
filetype on              " filetype detection
filetype plugin on
filetype indent on
" K on php native function show man page of function
autocmd FileType php set keywordprg=pman

""""""""""""""""""""""""""""""""""""""""""""""
" _SYNTAX
""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.conf set filetype=dosini
au BufNewFile,BufRead *.ts set filetype=typescript
au BufNewFile,BufRead *.vue set filetype=vue
au BufNewFile,BufRead *.go set filetype=go
au BufNewFile,BufRead *.twig set filetype=html.twig
au BufNewFile,BufRead *.styl set filetype=stylus
"autocmd FileType typescript :set makeprg=tsc
""""""""""""""""""""""""""""""""""""""""""""""
" _BUNDLES
""""""""""""""""""""""""""""""""""""""""""""""
"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'smarty-syntax'
"Bundle 'lunaru/vim-less'
Bundle 'groenewege/vim-less'
Bundle 'matchit.zip'

Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['html', '.ctrlp', '.env', 'readme.md']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|_cache\|branches\|tags\|nodejs\|build\|node_modules\|vendors\|coverage\|dist\.dev\|dist\.prod\|framework\|vendor$',
  \ 'file': '\.exe$\|\.so$\|\.dat\|\.jpg\|\.png$'
  \ }
let g:ctrlp_clear_cache_on_exit=0
Bundle 'tacahiroy/ctrlp-funky'
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1
Bundle 'd11wtq/ctrlp_bdelete.vim'
call ctrlp_bdelete#init()

Bundle 'bufexplorer.zip'

Bundle 'The-NERD-Commenter'
let g:NERDSpaceDelims = 1
Bundle 'The-NERD-tree'
" NERDTree
let g:NERDTreeWinPos = "right"
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
let NERDTreeIgnore=['\.svn$','\.git$']

Bundle 'Toggle'

Bundle 'snipMate'

"git tool for vim
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'

"Fast inner selector
Bundle 'gcmt/wildfire.vim'

Bundle 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump = 1
let g:syntastic_loc_list_height = 5
" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_typescript_args = ['-r node_modules/codelyzer']
let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_javascript_eslint_exe='[ -f $(npm bin)/eslint ]
    " \ && vimSyntasticExe=$(npm bin)/eslint
    " \ || vimSyntasticExe=eslint; $vimSyntasticExe'
let g:syntastic_javascript_checkers=['eslint']

"javascript
Bundle 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'jquery'
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1

Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
let g:javascript_enable_domhtmlcss=1
Bundle 'nathanaelkane/vim-indent-guides'

"bottom bar
Bundle 'bling/vim-airline'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
call airline#parts#define_accent('%{$USER}@', 'blue')
let g:airline_section_c = airline#section#create(['%{$USER}@','%{getcwd()}','/%f'])

"colorscheme
Bundle 'Solarized'
Bundle 'xoria256.vim'

"php fixer
Bundle 'php-cs-fixer'
" If php-cs-fixer is in $PATH, you don't need to define line below
let g:php_cs_fixer_path = "~/bin/php-cs-fixer.phar" " define the path to the
" php-cs-fixer.phar
 let g:php_cs_fixer_level = "all"                  " which level ?
 let g:php_cs_fixer_config = "default"             " configuration
 let g:php_cs_fixer_php_path = "php"               " Path to PHP
" If you want to define specific fixers:
"let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
 let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by
" default (<leader>pc + d for dir or f for file)
let g:php_cs_fixer_dry_run = 0                    " Call command with
" dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of
" command if 1, else an inline information.

Bundle 'Shutnik/jshint2.vim'
let jshint2_read = 1
"Lint JavaScript files after saving it:
let jshint2_save = 1
"Do not automatically close orphaned error lists:
let jshint2_close = 0
"Skip lint confirmation for non JavaScript files:
let jshint2_confirm = 0
"Do not use colored messages:
let jshint2_color = 0
"Hide error codes in error list (if you don't use error ignoring or error codes
"confuses you):
let jshint2_error = 0
"Set min and max height of error list:
let jshint2_height = 3
let jshint2_height = 12

Bundle 'editorconfig/editorconfig-vim'
""""""""""""""""""""""""""""""""""""""""""""""
" _BUNDLES_TEST
""""""""""""""""""""""""""""""""""""""""""""""
" shortcut -> (ctrl y ,)
Bundle 'mattn/emmet-vim'

Bundle 'iloginow/vim-stylus'
Bundle 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" vim resizer
Bundle 'simeji/winresizer'
let g:winresizer_start_key = '<leader>r'

" Bundle 'beyondwords/vim-twig'
Bundle 'lumiliet/vim-twig'

Bundle 'luochen1990/rainbow'
let g:rainbow_active = 0 " 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': [
\        'lightblue','blue',
\        'lightyellow', 'yellow',
\        'lightcyan', 'cyan',
\        'lightmagenta', 'magenta'
\    ],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'smarty': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       }
\   }
\}

Bundle 'rhysd/committia.vim'
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

    " Scroll the diff window from insert
    mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

"function list
Bundle 'functionlist.vim'

" typescript
Bundle 'leafgarland/typescript-vim'
" visiblement ya des couilles avec l'indentation donc en cas de besoin la
" ligne ci-dessous la désactive
" let g:typescript_indent_disable = 1
" let g:typescript_compiler_binary = 'tslint'
" let g:typescript_compiler_options = ''

Bundle 'fatih/vim-go'

Bundle 'posva/vim-vue'

" Plante comme un batard ---
" Bundle 'gabrielelana/vim-m-arkdown'
" <leader> + e: for edit code with good syntax
" ----
" Bundle 'tpope/vim-markdown'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""""""
" _EDITOR
""""""""""""""""""""""""""""""""""""""""""""""
set nocp  " sets vi compatible mode : (nocp|cp)
set wrap  " long lines wrap : (nowrap|wrap)
set nu    " line numbering : (nu\nonu)
set ru    " ruler : show cursor position below each window (noru|ru)
set lazyredraw "optimize redrawing
" Height of the command bar

"Explore
let g:netrw_liststyle=3
"status line
set laststatus=2

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "11  :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"11,:20,%,n~/.viminfo

" SEARCH"
set ignorecase      " ignorecase : ignore case when using a search pattern (noic|ic)
set smartcase       " smartcase : override 'ignorecase' when pattern has upper case characters (noscs|scs)
set hls             " hlsearch : highlight all matches for the last used search pattern (nohls|hls)""
set winminheight=0  " windows can be 0 line high

"indentation
set list
set ai                  " autoindent : automatically set the indent of a new line
set si                  " do clever autoindenting
set softtabstop=4       " tab = 4 space
set shiftwidth=4
set expandtab           " no more tabs, only spaces!
set shiftround          " when at 3 spaces, and I hit > ... go to 4, not 7"
set noswapfile          " No more swap file!
set colorcolumn=80,120  " Highlight column 80

au FileType javascript setl softtabstop=2 shiftwidth=2
au FileType yaml setl softtabstop=2 shiftwidth=2

" FONTS
syntax on
let php_sql_query = 1      " SQL queries
let php_htmlInStrings = 1  " HTML

" DISPLAY"
set foldenable              " set to display all folds open
set foldmethod=marker       " folding type: (manual|indent|expr|marker|syntax)
set lsp=9                   " linespace : number of pixel lines to use between characters
set ts=4                    " tabstop: number of spaces a <Tab> in the text stands for
set sw=4                    " shiftwidth : number of spaces used for each step of (auto)indent
set scrolloff=1000          " number of screen lines to show around the cursor
set listchars=trail:¤,tab:>-,nbsp:•     " Show blank spaces and tabs at the end of a line
set enc=utf-8
set showcmd                 " Affiche la commande en cours de saisie en bas à droite
set cursorline              "Soulignement de la ligne courante
highlight Folded gui=bold   "Surligne la ligne courante en gris
set complete=.,w,b,i        " default: .,w,b,u,t,i
set splitbelow              " force split open below
set splitright              " force vsplit open right
set synmaxcol=3200           " limit for line coloration

""""""""""""""""""""""""""""""""""""""""""""""
" _BACKUP
""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""
" _COLORSCHEME
""""""""""""""""""""""""""""""""""""""""""""""
" Set extra options when running in GUI mode
set background=dark
if has("gui_running")
    set guioptions=Ace
    set guifont=Monospace\ 8
    colorscheme solarized
    set guitablabel=%M\ %t
else
    set t_Co=256
    colorscheme xoria256
    highlight ColorColumn ctermbg=darkgrey guibg=#666666
    "redef des msg de warning car trop discret par défaut
    hi WarningMsg ctermfg=15  guifg=#ffffff ctermbg=166   guibg=#800000
endif

"coloration command ligne for each mode
au InsertEnter * hi StatusLine term=reverse ctermbg=4 gui=undercurl guisp=Magenta
au InsertLeave * hi StatusLine term=reverse ctermfg=15 ctermbg=8 gui=bold,reverse
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

"reload snippet
function! SnippetsUpdate(snip_dir)
  call ResetSnippets()
  call GetSnippets(a:snip_dir, '_')
  call GetSnippets(g:snippets_dir, &ft)
  call GetSnippets(a:snip_dir, &ft)
endfunction

function! GoTo(site, ...)
    let str = $HOME.'/dev/'.a:site.'/'
    if !isdirectory(str)
        echoerr 'Directory not found: "'.str.'"'
        return
    endif

    if (a:0 > 0)
        exe 'NERDTree '.str
    else
        exe 'CtrlP '.str
    endif
endfunction

fun! GoToComplete(A,L,P)
    let path = expand('~/dev/')
    return split(substitute(globpath(path, a:A."*"), path, "", "g"), "\n")
endfun
""""""""""""""""""""""""""""""""""""""""""""""
" _COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""
"Go function
command! -nargs=+ -complete=customlist,GoToComplete Go call GoTo(<f-args>)

" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif


"switch dir to current open file
autocmd BufEnter * silent! lcd %:p:h

if has("gui_running")
    "finally we launch nerdtree
    autocmd VimEnter * NERDTree
endif

""""""""""""""""""""""""""""""""""""""""""""""
" _COMMANDS_QUICK_FILES
""""""""""""""""""""""""""""""""""""""""""""""
"use full file
:command! Myconf tabe ~/.vimrc

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
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>

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

"functionlist
map <F4> :Flisttoggle<CR>

" clean code
map <silent> <F7> :s:\t:    :eg<Bar>:%s:\%V[\t ]*$::eg<Bar>:noh<cr>
nmap <silent> <F8> :call CleanCode(0)<CR>
nmap <silent> <F9> :call CleanCode(1)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  _SHORTCUTS_LEADER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
let g:mapleader = " "

"relaod config
nnoremap <leader>c :so %<cr>

" Fast saving
nmap <leader>w :w!<cr>

" fast buffers opening
nmap <leader>pc :CtrlP<cr>
nmap <leader>bc :CtrlPBuffer<cr>

" Toggle list
map <leader><Space> :set list!<CR>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>ts :tab split<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>te :tabedit! %<cr>

map <leader>bt :tabnew +BufExplorer<cr>
map <leader>bb :BufExplorer<cr>
"map <leader>bv :vs +BufExplorer<cr>

" This command will cause SnippetsUpdate() with parameter <your_snip_dir>
map <leader>n :call SnippetsUpdate('~/.vim/snippets/')<CR>
"resize vertical split
" map <leader>f :vertical resize 200<CR>
" map <leader>r :vertical resize 90<CR>
" map <leader>s :vertical resize 10<CR>

"clear search hl
map <leader>h :noh<CR>

"retab selection
map <leader>t :retab<CR>

" list of functions
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fun :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"get current file full name
nmap <Leader>pwd :echo expand('%:p')<Cr>

nmap <leader>fo :r !fortune ~/config/fortune/quotes<Cr>

" next error
nmap <leader>e :lnext<Cr>

