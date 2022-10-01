" Auto Load
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:nvim_plugins_installation_completed=1

if empty(glob($HOME.'/.config/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
    let g:nvim_plugins_installation_completed=0
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Global Config
syntax on
filetype on
filetype plugin on
filetype indent on

set clipboard+=unnamedplus
let &t_ut=''
set exrc
set secure
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set smartindent
set cindent
set number
set relativenumber
set autochdir
set autoread
set autowrite
set showmode
set showcmd
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set cursorline
set list
set listchars=tab:\|\ ,trail:▫
set textwidth=80
set wrap
set linebreak
set wrapmargin=2
set iskeyword+=_,$,@,%,#,-
set foldenable
set foldmethod=indent
set foldlevel=99
set scrolloff=5
set laststatus=2
set ruler
set history=1000
set lazyredraw
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set splitright
set splitbelow
set shortmess+=c
set inccommand=split
set virtualedit=block
set wildmenu
set wildmode=longest:list,full
set completeopt=longest,preview,menu
set colorcolumn=120
set updatetime=100
"set guifont=DroidSansMono\ Nerd\ Font\ 11

silent !mkdir -p $HOME/.config/nvim/tmp/backup

set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Basic Mappings
let mapleader = "\<SPACE>"
let maplocalleader = "\\"

" Install Plugins
call plug#begin('$HOME/.config/nvim/plugged')

" Editor Enhancement
" AsyncRun: https://github.com/skywind3000/asynctasks.vim/blob/master/README-cn.md
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'sbdchd/neoformat'
Plug 'preservim/nerdcommenter'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'matze/vim-move'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'
Plug 'easymotion/vim-easymotion'

" Pyhon
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug'] }

" LaTeX
Plug 'lervag/vimtex'

" Markdown
" Markdown Rules: https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown', { 'for': ['markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['markdown', 'vim-plug'] }
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }

" Visual Enhancement
"Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'theniceboy/nvim-deus'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" wildfire
nmap <Leader>s <Plug>(wildfire-quick-select)

let g:wildfire_objects = {
            \ "*" : ["i'", 'i"', "i)", "i]", "i}"],
            \ "html,xml" : ["at", "it"],
            \ }

" undotree
nnoremap UL :UndotreeToggle<CR>

if has("persistent_undo")
    let target_path = expand('$HOME/.config/nvim/.undo')

    " create the directory and any parent directories
    " if the location does not exist
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24

" neoformat
" augroup fmt
"     autocmd!
"     autocmd BufWritePre * undojoin | Neoformat
" augroup END

let g:neoformat_try_node_exe = 1
let g:shfmt_opt="-ci"
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

nnoremap <Leader>F :Neoformat clangformat<CR>

" nerdcommenter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'both'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'N1san'

" coc.nvim
let g:coc_global_extensions = [
            \       'coc-json',
            \       'coc-html',
            \       'coc-css',
            \       'coc-tsserver',
            \       'coc-pyright',
            \       'coc-java',
            \       'coc-ccls',
            \       'coc-cmake',
            \       'coc-gitignore',
            \       'coc-snippets',
            \       'coc-yank',
            \       'coc-xml',
            \       'coc-yaml',
            \       'coc-vimlsp',
            \       'coc-vimtex',
            \       'coc-markdownlint',
            \       'coc-sh',
            \       'coc-pairs'
            \ ]

" coc.nvim
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-SPACE> coc#refresh()

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

nmap <Leader>rn <Plug>(coc-rename)

" coc-yank
nnoremap <silent> <Leader>y  :<C-u>CocList -A --normal yank<cr>

" vim-move
let g:move_key_modifier = 'S'
let g:move_key_modifier_visualmode = 'S'

" asynctasks
noremap <silent> <Leader><Leader><F5> :AsyncTask file-run<cr>
noremap <silent> <Leader><Leader><F9> :AsyncTask file-build<cr>
noremap <silent> <Leader><Leader><F6> :AsyncTask project-run<cr>
noremap <silent> <Leader><Leader><F7> :AsyncTask project-build<cr>
noremap <silent> <Leader><Leader><F8> :AsyncTask project-clean<cr>
noremap <silent> <Leader><Leader><F10> :AsyncTask project-configure<cr>

" asyncrun
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asynctasks_term_pos = 'TAB'

" ale
let g:ale_disable_lsp = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap <silent> ap <Plug>(ale_previous_wrap)
nmap <silent> an <Plug>(ale_next_wrap)
nmap <Leader>ad :ALEDetail<CR>

let g:ale_open_list = 1
let g:ale_list_window_size = 6

" vimspector
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval

nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
nmap <LocalLeader><F12> <Plug>VimspectorDownFrame

let g:vimspector_enable_mappings = 'HUMAN'

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB', 'vscode-java-debug', 'vscode-bash-debug' ]

" vim-easymotion
nmap ss <Plug>(easymotion-s2)

" rainbow
"let g:rainbow_active = 1
"silent! RainbowToggleOn

" nvim-treesitter
"if g:nvim_plugins_installation_completed == 1
lua require('treesitter')
"silent! TSEnable highlight
"endif

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
nnoremap bn :bn<CR>
nnoremap bp :bp<CR>
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>

" nvim-deus
" set termguicolors
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" silent! color deus

" palenight.vim
set background=dark
colorscheme palenight
let g:airline_theme = "palenight"
let g:palenight_terminal_italics=1

" colorscheme dracula

" vimtex
let g:tex_flavor = 'latex'

" vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_edit_url_in = 'tab'

" vim-markdown-toc
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'
let g:vmt_list_indent_text = '  '

" vim-instant-markdown
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
let g:instant_markdown_mathjax = 1
let g:instant_markdown_mermaid = 1
let g:instant_markdown_autoscroll = 1

" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
" let g:instant_markdown_port = 8888
" let g:instant_markdown_python = 1

" vim-table-mode
noremap <Leader>tm :TableModeToggle<CR>
