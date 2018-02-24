scriptencoding utf-8

set nocompatible              " noc with old vi.

" ============ Vundle ============
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" ============ Vundle ============


" line buffer
set history=100


" ============ FILE ============
" Encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencodings=utf-8
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
set autochdir "auto change dir

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" ============ FILE ============


" ============ TEXT (Tab & Indent) ============
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set tabstop=2       " num of visual space per <TAB> char
set softtabstop=2   " num of spaces for TAB when editing, useful for backspace
set shiftwidth=2

" Linebreak on 500 characters
set linebreak
set tw=500
set wrap
set fo+=mB " Line break support for asian language

" Indentation
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" ============ TEXT (Tab & Indent) ============


" ============ UI/UX Tweaking ============
" UI
set display=lastline
set laststatus=2    " To display the status line always
set cursorline      " hilight current line
set showmode        " display current mode
set wildmenu        " show list instead of just completing

" line number
set number
set numberwidth=4

" change cursor type for terminal
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

" change cursor type for iterm2
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" highlight matching [{()}] 
set showmatch

" displaying tabs visually
set list
set listchars=tab:\ \ ,trail:·,extends:>,precedes:<  

" at least 7 lines visible - when scrolling vertically using j/k
set scrolloff=7

" Always show current position
set ruler

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells

" mouse support
set mouse=a

" ============ UI/UX Tweaking ============


" ============ SEARCH ============
set hlsearch "highlight
set incsearch "incremental search
set ignorecase
" doubly esc for clear search highlight
nnoremap <esc><esc> :noh<return>
" ============ SEARCH ============


" ============ THEME (Solarized Dark & Power Line) ============
" solarized
syntax enable
set background=dark
colorscheme solarized

" compatibility
if !has('gui_running')
    " Compatibility for Terminal
    let g:solarized_termtrans=1
    if (&t_Co >= 256 || $TERM == 'xterm-256color')
        " Do nothing, it handles itself.
    else
        " Make Solarized use 16 colors for Terminal support
        let g:solarized_termcolors=16
    endif
endif

" powerline symbols
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
"this line will break airline
"set ambiwidth=double
" ============ THEME (Solarized Dark & Power Line) ============


" ============ NERDTree ============
" NERDTree shortcut
map <C-n> : NERDTreeToggle<CR>
" auto-open by default
" au VimEnter *  NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" let NERDTreeQuitOnOpen = 1
" ============ NERDTree ============


" ============ KEY MAPPING ============
" system clipboard
:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d
" not using system clipboard as default register
"set clipboard=unnamed

" mapping tab switch
map <S-Right> :tabn<CR>
map <S-Left>  :tabp<CR>

" mapping window switch without maximizing
"set wmw=0
"set wmh=0
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-W>
map <c-h> <c-w>h<c-w>
map <c-l> <c-w>l<c-w>

" (not used, I map CAPS to ESC) insert mode mapping
" imap jk <Esc>

" multiple paste
xnoremap p pgvy

" move cursor by display lines when wrapping
" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
" ============ KEY MAPPING ============

" autocommand - file extension aliase
au bufnewfile,bufread *.imp setlocal filetype=lisp
