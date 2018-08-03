scriptencoding utf-8

set ffs=unix,dos
set nocompatible              " Disable Vi compatibility

" ============ Vundle ============
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'rhysd/clever-f.vim'
Plugin 'majutsushi/tagbar'
Plugin 'reasonml-editor/vim-reason-plus'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'rakr/vim-one'
Plugin 'jordwalke/vim-one'

" the legacy reason plugin.
Plugin 'reasonml-editor/vim-reason'

" the new-one doesn't work:
"Plugin 'roxma/vim-hug-neovim-rpc'
"Plugin 'roxma/nvim-yarp'
"Plugin 'autozimu/LanguageClient-neovim'

" Follow the installation guide to compile language server. It's good
" https://github.com/Valloric/YouCompleteMe#mac-os-x
Plugin 'Valloric/YouCompleteMe'

Plugin 'tpope/vim-commentary'

" https://github.com/w0rp/ale
Plugin 'w0rp/ale'

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

" Insert \t char literally 
:inoremap <S-Tab> <C-V><Tab>

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
if has("cmdline_info")
    " Show the cursor line and column number
    set ruler
    " Show partial commands in status line
    set showcmd
    " Show whether in insert or replace mode
    set showmode
endif

if has('statusline')
    " Always show status line
    set laststatus=2
    " Broken down into easily includeable segments
    " Filename
    set statusline=%<%f\
    " Options
    set statusline+=%w%h%m%r
    " Current dir
    set statusline+=\ [%{getcwd()}]
    " Right aligned file nav info
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%
endif


if has("wildmenu")
    " Show a list of possible completions
    set wildmenu
    " Tab autocomplete longest possible part of a string, then list
    set wildmode=longest,list
    if has ("wildignore")
        set wildignore+=*.a,*.pyc,*.o,*.orig
        set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
        set wildignore+=.DS_Store,.git,.hg,.svn
        set wildignore+=*~,*.sw?,*.tmp
    endif
endif

" UI
set display=lastline
set laststatus=2    " To display the status line always
set cursorline      " hilight current line

" line number
set number
set numberwidth=4

" change cursor type for terminal
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

" change cursor type for iterm2
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" highlight matching [{()}] 
set showmatch

" Show 'invisible' characters
set list
set showbreak=\\
" Set characters used to indicate 'invisible' characters
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<
set listchars+=nbsp:_
"set listchars+=eol:¬

" at least 7 lines visible - when scrolling vertically using j/k
set scrolloff=5

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells

" mouse support
set mouse=a

" timeout
set timeoutlen=1000 ttimeoutlen=0
" ============ UI/UX Tweaking ============


" ============ SEARCH ============
if has("extra_search")
    " Highlight searches [use :noh to clear]
    set hlsearch
    " Highlight dynamically as pattern is typed
    set incsearch
    " Ignore case of searches...
    set ignorecase
    " ...unless has mixed case
    set smartcase
endif

" doubly esc for clear search highlight
nnoremap <esc><esc> :noh<return>
" ============ SEARCH ============


" ============ THEME (Solarized Dark & Power Line) ============
if has("syntax")
    " Enable syntax highlighting
    syntax enable
    " Set 256 color terminal support
    set t_Co=256

    " For dark version
    set background=dark
    " For light version
    "set background=light
    
    " Set default colorscheme to solarized
    " Noted that solarized theme require iterm use solarized as well.
    silent! colorscheme solarized
endif

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
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"this line will break airline
"set ambiwidth=double
" ============ THEME (Solarized Dark & Power Line) ============


" ============ THEME (One) ============
" If you want to use Solarized, you must delete this section

"TRUE COLOR SUPPORT FOR ONE
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
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
endif

if has("syntax")
    " Override theme to one
    " Noted that One theme can use with any itermcolor
    silent! colorscheme one
endif

let g:airline_theme='one'
" ============ THEME (One) ============


" ============ NERDTree ============
" NERDTree shortcut
map <C-n> : NERDTreeToggle<CR>
" auto-open by default
" au VimEnter *  NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden= 1
" let NERDTreeQuitOnOpen = 1
" ============ NERDTree ============


" ============ CtrlP ============
" Show hidden files when using ctrlp
let g:ctrlp_show_hidden = 1
" ============ CtrlP ============


" ============ Tagbar ============
" shortcut
map <C-b> : TagbarToggle<CR>
" ============ Tagbar ============


" ============ Clever-f ============
let g:clever_f_smart_case = 1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)
" ============ Clever-f ============


" ============ Vim-commentary ============
" <C_/>
map <C-_> : Commentary<cr>
" ============ Vim-commentary ============


" ============ Merlin for OCaml / Reason ============
map gd : MerlinLocate<cr>
map gf : ReasonPrettyPrint<cr>
map <cr> : MerlinTypeOf<cr>
" ============ Merlin for OCaml / Reason ============


" ============ KEY MAPPING ============
" system clipboard
" make sure `$ vim --version | grep clipboard` give u `+clipboard`
" otherwise you've to reinstall one with clipboard to make it work
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

" Faster viewport scrolling (3 lines at a time)
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Make `Y` work from the cursor to the end of line (which is more logical)
nnoremap Y y$

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
au bufnewfile,bufread *.ast setlocal filetype=lisp
au bufnewfile,bufread *.emj setlocal filetype=java



