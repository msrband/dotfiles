"" Package Manager : vim-plug (https://github.com/junegunn/vim-plug)
"" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
"" Other Dependencies
"" npm install -g js-beautify (vim-autoformat)
"" gem install rubocop (vim-autoformat)
call plug#begin('~/.local/share/nvim/plugged')
"" LSP
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"" Auto Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"" Snippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

"" Fuzzy Find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Code Formatting
Plug 'Chiel92/vim-autoformat'

"" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-haml'

Plug 'slim-template/vim-slim'

"" Javascript
Plug 'pangloss/vim-javascript'
Plug 'isRuslan/vim-es6'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

"" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" Colorscheme
Plug 'junegunn/seoul256.vim'
Plug 'savq/melange-nvim'

Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'janko-m/vim-test'

"" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

Plug 'metakirby5/codi.vim'

"" Comment
Plug 'numToStr/Comment.nvim'

Plug 'easymotion/vim-easymotion'
Plug 'eandrju/cellular-automaton.nvim' 

"" Avante
"Plug 'nvim-treesitter/nvim-treesitter'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

" Optional deps
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
Plug 'HakonHarnes/img-clip.nvim'
"Plug 'zbirenbaum/copilot.lua'

Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
call plug#end()

set nocompatible " be iMproved, required
set encoding=utf-8
set fileencoding=utf-8
let mapleader = ','
set nopaste
set clipboard=unnamed
set noswapfile  " Git handles version controlling
set nobackup
set nowritebackup
set noshowmode  " Airline shows the mode
set shiftround

syntax on " Enable syntax highlighting
filetype on " Enable filetype detection
filetype indent on  " Enable filetype-specific indenting
filetype plugin on  " Enable filetype-specific plugins

"" Whitespace
set tabstop=2 shiftwidth=2  " a tab is two spaces
set expandtab " Use spaces instead of tabs
set smarttab  " Be smart when using tabs
set list listchars=tab:»·,trail:·
set linebreak
set nolist
set wildmode=full
" set lazyredraw          " redraw only when we need to.
set number
set numberwidth=5

set undofile
set undodir="$HOME/.VIM_UNDO_FILES"
set updatetime=500

"" Searching
"set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
"" Toggle search highlighting
map <Leader>h :set invhls <CR>

set complete=.,w,b,u,t,k

"" Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
"" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

"" autocmd
" autocmd BufWritePre * %s/\s\+$//e
" augroup configgroup
"   autocmd!
"   autocmd VimEnter * highlight clear SignColumn
"   " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
"   "             \:call <SID>StripTrailingWhitespaces()
"   autocmd FileType java setlocal noexpandtab
"   autocmd FileType java setlocal list
"   autocmd FileType java setlocal listchars=tab:+\ ,eol:-
"   autocmd FileType java setlocal formatprg=par\ -w80\ -T4
"   autocmd FileType php setlocal expandtab
"   autocmd FileType php setlocal list
"   autocmd FileType php setlocal listchars=tab:+\ ,eol:-
"   autocmd FileType php setlocal formatprg=par\ -w80\ -T4
"   autocmd FileType ruby setlocal tabstop=2
"   autocmd FileType ruby setlocal shiftwidth=2
"   autocmd FileType ruby setlocal softtabstop=2
"   autocmd FileType ruby setlocal commentstring=#\ %s
"   autocmd FileType python setlocal commentstring=#\ %s
"   autocmd BufEnter *.cls setlocal filetype=java
"   autocmd BufEnter *.zsh-theme setlocal filetype=zsh
"   autocmd BufEnter Makefile setlocal noexpandtab
"   autocmd BufEnter *.sh setlocal tabstop=2
"   autocmd BufEnter *.sh setlocal shiftwidth=2
"   autocmd BufEnter *.sh setlocal softtabstop=2
" augroup END

"" Color
let g:seoul256_background = 236
colo seoul256
set termguicolors
"colorscheme melange

"" Deoplete
let g:deoplete#enable_at_startup = 1

"" Code formatting
noremap <F3> :Autoformat<CR>

"" FZF
map <c-p> :FZF<CR>
map <c-s> :Ag<CR>
map <c-b> :Buffers<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_nvim_statusline = 0
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

"" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

"" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
"
" function! s:fzf_statusline()
"   "" Override statusline as you like
"   highlight fzf1 ctermfg=161 ctermbg=251
"   highlight fzf2 ctermfg=23 ctermbg=251
"   highlight fzf3 ctermfg=237 ctermbg=251
"   setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
" endfunction
"
" autocmd! User FzfStatusLine call <SID>fzf_statusline()
"
" "" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }


"" File Explorer
map <C-\> :Lexplore<CR>

" vim-airline ---------------------------------------------------------------{{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_skip_empty_sections = 1
set hidden
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'kalisi'
" cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
nmap <leader>n :enew<CR>
nmap <leader>. :bnext<CR>
tmap <leader>. <C-\><C-n>:bnext<cr>
nmap <leader>, :bprevious<CR>
tmap <leader>, <C-\><C-n>:bprevious<CR>
tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '0 ',
      \ '1': '1 ',
      \ '2': '2 ',
      \ '3': '3 ',
      \ '4': '4 ',
      \ '5': '5 ',
      \ '6': '6 ',
      \ '7': '7 ',
      \ '8': '8 ',
      \ '9': '9 '
      \}

"" window key mapping
if has('nvim')
  :tnoremap <A-h> <C-\><C-n><C-w>h
  :tnoremap <A-j> <C-\><C-n><C-w>j
  :tnoremap <A-k> <C-\><C-n><C-w>k
  :tnoremap <A-l> <C-\><C-n><C-w>l
endif
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

"" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "neovim"

"" netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

"" vim-ruby
" For standardrb
let g:ruby_indent_assignment_style = 'variable'

" Required for operations modifying multiple buffers like rename.
set hidden

"" neosnippet 
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


lua << EOF
---Comment
require('Comment').setup()

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.ruby_lsp.setup({
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
})
lspconfig.pyright.setup {}
lspconfig.ts_ls.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
ensure_installed = {"ruby", "go", "python", "javascript", "html", "css", "lua", "typescript", "rust", "vim", "vue"},

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('avante').setup()
vim.opt.laststatus = 3
EOF

" treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"" vim-go
let g:go_fmt_command = "goimports"


"" Disable Perl provider 
let g:loaded_perl_provider = 0
