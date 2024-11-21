"""""""""""""""""""""""""""""""""""""""""""""""
"    INDEX
"        _SYNTAX
"        _PLUGINS
"        _PLUGINS_IN_TEST
"        _EDITOR
"        _COLORSCHEME
"        _BACKUP
"        _FUNCTIONS
"        _COMMANDS
"        _COMMANDS_QUICK_FILES
"        _SHORTCUTS
"        _SHORTCUTS_LEADER
"        _LUA_CONFIG
""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""
" _SYNTAX
""""""""""""""""""""""""""""""""""""""""""""""
filetype on              " filetype detection
filetype plugin on
filetype indent on

" fix to have file type
" autocmd BufReadPost * silent! execute 'edit!'
" autocmd BufEnter * silent! call s:reload_file()
""""""""""""""""""""""""""""""""""""""""""""""
" _PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/config/nvim/bundle')

" Colorscheme
Plug 'vim-scripts/xoria256.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'rafamadriz/neon'
Plug 'Mofiqul/vscode.nvim'

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

Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v3.5.4' }

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
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

" " vim resizer
Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>r'

Plug 'sheerun/vim-polyglot'

Plug 'prettier/vim-prettier'
autocmd BufWritePre *.tsx,*.ts,*.svelte Prettier

" _PLUGINS_IN_TEST
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/plenary.nvim'
Plug 'pmizio/typescript-tools.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'luckasRanarison/tailwind-tools.nvim'




" Post-update hook can be a lambda expression
" set rtp+=~/config/fzf
" set rtp+=/opt/homebrew/opt/fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
" let g:fzf_commits_log_options = '--color=always --format="%C(green)%cd %C(red bold)%an%Creset %C(yellow)%h %C(white)%s %C(auto)%d" --graph --date-order --date=relative'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" optional for icon support
Plug 'nvim-tree/nvim-web-devicons'

call plug#end()

call airline#parts#define_accent('%{$USER}@', 'blue')
let g:airline_section_c = airline#section#create(['%{$USER}@','%{getcwd()}','/%f'])

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
" set t_Co=256
" colorscheme xoria256 " toujours aussi cool
" colorscheme nightfox " pas mal pour du pastel
" colorscheme carbonfox "pas mal
" let g:neon_style = "dark" " pas mal bien sombre
" colorscheme neon
colorscheme vscode " bien mais trop pastel

hi ColorColumn ctermbg=237
" for ibl.config hilight
hi Whitespace ctermfg=244


"redef des msg de warning car trop discret par défaut
hi WarningMsg ctermfg=15  ctermbg=166

hi CursorLineNr ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi DiagnosticInfo ctermfg=242
hi DiagnosticError ctermfg=9
hi NormalFloat ctermbg=235

sign define DiagnosticSignError text=  texthl=DiagnosticSignError
sign define DiagnosticSignWarn text=   texthl=DiagnosticSignWarn
sign define DiagnosticSignInfo text=   texthl=DiagnosticSignInfo
sign define DiagnosticSignHint text=   texthl=DiagnosticSignHint

"coloration command ligne for each mode
au InsertEnter * hi StatusLine term=reverse ctermbg=4
au InsertLeave * hi StatusLine term=reverse ctermfg=15 ctermbg=8
"tab coloration
" hi TabLineFill ctermfg=0 ctermbg=0
" hi TabLineSel ctermfg=15 ctermbg=8
hi TabLineSel cterm=bold gui=bold
" hi TabLine ctermfg=lightGray ctermbg=0

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


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "11  :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
" set viminfo='10,\"11,:20,%,n~/.viminfo
"
" 1000: Maximum number of lines stored for each register.
" <50: Maximum number of items stored in the command-line history.
" s10: Maximum number of items stored in the search history.
" h: Include help file marks in the shada file.
set shada='10,\"11,:20,%

" Automatically save all buffers when they are written
autocmd BufWritePost * silent! wall

" Reload all buffers on Neovim startup
" autocmd VimEnter * silent! bufdo e!

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
    let str = $HOME.'/Documents/dev/'.a:site.'/'
    if !isdirectory(str)
        echoerr 'Directory not found: "'.str.'"'
        return
    endif

    if (a:0 > 0)
        exe 'Explore! '.str
    else
        exe ':FzfLua files cwd='.str
    endif
endfunction

fun! GoToComplete(A,L,P)
    let path = expand('~/Documents/dev/')
    return split(substitute(globpath(path, a:A."*"), path, "", "g"), "\n")
endfun


" Define a function to format with pg_format
function! PgFormat()
    silent! execute '%!pg_format --function-case 1 --keyword-case 2 --spaces 2 --wrap-limit 80 --wrap-after 0 --nogrouping'
endfunction

" Create an autocommand group
augroup PgFormatOnSave
    autocmd!
    " Apply pg_format on save for SQL files
    autocmd BufWritePost *.sql call PgFormat()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""
" _COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""
" automatically search in root project path
command! ProjectFiles execute 'FzfLua files cwd='.s:find_git_root()

"Go function
command! -nargs=+ -complete=customlist,GoToComplete Go call GoTo(<f-args>)

"switch dir to current open file
autocmd BufEnter * silent! lcd %:p:h

""""""""""""""""""""""""""""""""""""""""""""""
" _COMMANDS_QUICK_FILES
""""""""""""""""""""""""""""""""""""""""""""""
"use full file
:command! Myconf tabe $MYVIMRC
:command! Myoldconf tabe $HOME/.vimrc

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

set re=0
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
nmap <leader>oi :FzfLua buffers<cr>
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

function! OpenCurrentFileInNewTab()
  " Get the current cursor position
  let l:line = line('.')
  let l:col = col('.')
  
  " Open a new tab with the same file
  tabnew %
  
  " Restore the cursor position
  execute l:line
  call cursor(l:line, l:col)
endfunction
" " typescript command
nmap <Leader>a :TSToolsGoToSourceDefinition<CR>
nmap <Leader>as :split<CR>:TSToolsGoToSourceDefinition<CR>
nmap <Leader>at :call OpenCurrentFileInNewTab()<CR>:TSToolsGoToSourceDefinition<CR>
nmap <Leader>i :TSToolsAddMissingImports<CR>

"" clean all buffers
nnoremap <leader>db :w <bar> %bd <bar> e# <bar> bd# <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  _LUA_CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
-- Set up nvim-cmp.
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        before = require("tailwind-tools.cmp").lspkind_format
      })
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').clangd.setup {
  capabilities = capabilities
}

-- require('lspconfig').intelephense.setup({})


---@type TailwindTools.Option
require("tailwind-tools").setup({
  document_color = {
    enabled = true, -- can be toggled by commands
    kind = "background", -- "inline" | "foreground" | "background"
    inline_symbol = "󰝤 ", -- only used in inline mode
    debounce = 200, -- in milliseconds, only applied in insert mode
  },
  conceal = {
    enabled = false, -- can be toggled by commands
    min_length = nil, -- only conceal classes exceeding the provided length
    symbol = "󱏿", -- only a single character is allowed
    highlight = { -- extmark highlight options, see :h 'highlight'
      fg = "#38BDF8",
    },
  },
  custom_filetypes = {} -- see the extension section to learn how it works
})


require("typescript-tools").setup({
  autostart = true
})

local lspconfig =  require('lspconfig');
lspconfig.tsserver.setup({
  autostart = true,
  init_options = {
    preferences = {
      noErrorTruncation = true,
      importModuleSpecifierPreference = "relative",
    }
  }
})

-- lspconfig.sqlls.setup({
--   filetypes = { 'sql' },
--   root_dir = function(_)
--     return vim.loop.cwd()
--   end,
-- })

lspconfig.svelte.setup{}

local highlight = {
    "Whitespace",
}

require("ibl").setup({
  indent = { highlight = highlight, char = "╎" },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    -- key binding
    local map = vim.keymap.set
    local opts = { buffer = event.buf }
    map('n', '<leader>d', vim.diagnostic.open_float, opts)
    map('n', '<leader>df', vim.lsp.buf.hover, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    map('n', '<leader>re', vim.lsp.buf.references, opts)
    map("n", '<leader>f', vim.diagnostic.goto_next, opts)
  end,
})

require('lspconfig').eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- disable diag in insert mode
--vim.api.nvim_create_autocmd('ModeChanged', {
--  pattern = {'n:i', 'v:s'},
--  desc = 'Disable diagnostics in insert and select mode',
--  callback = function(e) vim.diagnostic.disable(e.buf) end
--})
--
--vim.api.nvim_create_autocmd('ModeChanged', {
--  pattern = 'i:n',
--  desc = 'Enable diagnostics when leaving insert mode',
--  callback = function(e) vim.diagnostic.enable(e.buf) end
--})

--  vim.api.nvim_create_autocmd({"BufNew", "InsertEnter"}, {
-- -- or vim.api.nvim_create_autocmd({"BufNew", "TextChanged", "TextChangedI", "TextChangedP", "TextChangedT"}, {
--   callback = function(args)
--     vim.diagnostic.disable(args.buf)
--   end
-- })
-- 
-- vim.api.nvim_create_autocmd({"BufWrite"}, {
--   callback = function(args)
--     vim.diagnostic.enable(args.buf)
--   end
-- })

vim.diagnostic.config({
  virtual_text = {
    prefix = '#',
    format = function(diagnostic)
      -- Append rule name to the message if available
      local rule = diagnostic.user_data and diagnostic.user_data.lsp and diagnostic.user_data.lsp.code
      if rule then
        return string.format('%s [%s]', diagnostic.message, rule)
      end
      return diagnostic.message
    end
  },
});

local function setup_lsp_diags()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      show_diagnostic_autocmds = { 'InsertLeave', 'TextChanged' },
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      underline = false,
    }
  )
end

setup_lsp_diags()

-- require("fzf-lua").setup({ "fzf-vim" })
require("fzf-lua").setup()

EOF
