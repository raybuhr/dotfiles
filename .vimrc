"" General Settings
set number			" Show line numbers
set showcmd             	" show command in bottom bar
set cursorline          	" highlight current line
set linebreak			" Break lines at word (requires Wrap lines)
set showbreak=+++		" Wrap-broken line prefix
set textwidth=120		" Line wrap (number of cols)
set showmatch			" Highlight matching brace
set visualbell			" Use visual bell (no beeping)
set hlsearch			" Highlight all search results
set smartcase			" Enable smart-case search
set ignorecase			" Always case-insensitive
set incsearch			" Searches for strings incrementally
set autoindent			" Auto-indent new lines
set shiftwidth=4		" Number of auto-indent spaces
set smartindent			" Enable smart-indent
set smarttab			" Enable smart-tabs
set tabstop=4       		" number of visual spaces per TAB
set softtabstop=4		" Number of spaces per Tab
set expandtab			" Use spaces instead of tabs
set ruler			" Show row and column ruler information
set undolevels=1000		" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

syntax enable			" enable syntax processing
filetype indent on      	" load filetype-specific indent files
set wildmenu            	" visual autocomplete for command menu
set lazyredraw          	" redraw only when we need to.

" super under using gundo
nnoremap <leader>u :GundoToggle<CR>

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'sjl/gundo.vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'godlygeek/csapprox'
Plug 'benmills/vimux'
Plug 'sheerun/vim-polyglot'
" Initialize plugin system
call plug#end()

" set colorscheme
set t_Co=256
set background=dark
colorscheme gruvbox8

" Clear Whitespace
function! Trim()
    %s/\s*$//
        ''
    endfunction
command! -nargs=0 Trim :call Trim()
nnoremap <silent> <Leader>cw :Trim<CR>

" Vimux
let g:VimuxUseNearestPane = 1
map <silent> <LocalLeader>vl :wa<CR> :VimuxRunLastCommand<CR>
map <silent> <LocalLeader>vi :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>vk :wa<CR> :VimuxInterruptRunner<CR>
map <silent> <LocalLeader>vx :wa<CR> :VimuxClosePanes<CR>
map <silent> <LocalLeader>vp :VimuxPromptCommand<CR>
vmap <silent> <LocalLeader>vs "vy :call VimuxRunCommand(@v)<CR>
nmap <silent> <LocalLeader>vs vip<LocalLeader>vs<CR>
map <silent> <LocalLeader>ds :call VimuxRunCommand('clear; grep -E "^ *describe[ \(]\|^ *context[ \(]\|^ *it[ \(]" ' . bufname("%"))<CR>
