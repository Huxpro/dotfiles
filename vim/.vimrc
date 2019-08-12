scriptencoding utf-8

set ffs=unix,dos
set nocompatible              " Disable Vi compatibility

" ============ Vim-plug ============
"
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] } 
Plug 'jistr/vim-nerdtree-tabs'

Plug 'majutsushi/tagbar', { 'on':  ['TagbarToggle'] }


" ============ Plugin LSP ============
" CoC: alternative LSP client
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" LSP(Langague Server Protocol) client supports for vim
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Deoplete is a independent Dark powered asynchronous completion framework for neovim/Vim8.
" https://github.com/Shougo/deoplete.nvim
" LC-neovim use it to support LSP-powered autocompletion.
" for neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" for vim 8 with python
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" enable autocomplete
let g:deoplete#enable_at_startup = 1

" FZF is a independent replacement to CtrlP,
" But LC-neovim use it for contextMenu when it exists.
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" ============ Plugin LSP ============


" ============ Languages ============
" FNL
Plug '~/aros/tungsten/experimental/proto2/editors/fnl-vim'
 
" Rust
Plug 'rust-lang/rust.vim'

" ReasonML
Plug 'reasonml-editor/vim-reason-plus'

" Scala
Plug 'derekwyatt/vim-scala'

" Kotlin
Plug 'udalov/kotlin-vim'

" TypeScript
Plug 'leafgarland/typescript-vim'

" SML
Plug 'jez/vim-better-sml'
Plug 'javier-lopez/sml.vim'

" Haskell
Plug 'Shougo/vimproc.vim'
Plug 'eagletmt/ghcmod-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'alx741/vim-stylishask'
Plug 'alx741/vim-hindent'
Plug 'parsonsmatt/intero-neovim'

" Clojure
Plug 'tpope/vim-fireplace'

" Markdown
Plug 'tpope/vim-markdown'

" LaTex 
Plug 'lervag/vimtex'

" Isabelle
set rtp+=~/.vim/plugged/isabelle.vim
" ============ Languages ============


" Both for git and for better sign column
Plug 'airblade/vim-gitgutter'

" Asynchronous Lint Engine w/ LSP support
Plug 'w0rp/ale'

" Smart input method
Plug 'ybian/smartim'

" Carbon - create beautiful code images
Plug 'kristijanhusak/vim-carbon-now-sh'

" Unicode glyphs completion
Plug 'chrisbra/unicode.vim'

" Surround.vim
Plug 'tpope/vim-surround'

" ?
Plug 'jiangmiao/auto-pairs'

" Tex input-method <C-L>
Plug 'joom/latex-unicoder.vim'

" Coq (doesn't work for some Python error)
" Plug 'the-lambda-church/coquille'

" Agda
Plug 'derekelkins/agda-vim'

" Swift
Plug 'keith/swift.vim' 

" Wasm
Plug 'rhysd/vim-wasm'

" JS
Plug 'pangloss/vim-javascript'

" Indent Guides
Plug 'nathanaelkane/vim-indent-guides'

" Comment
Plug 'tpope/vim-commentary'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" CtrlP
" Following [SpaceVim](https://github.com/liuchengxu/space-vim/issues/124)
" Drop CtrlP in favor of FZF as `<C-p>`
" Plug 'kien/ctrlp.vim'

" Find Project Root
" Was provided by CtrlP.
Plug 'airblade/vim-rooter'

" Git wrapper
Plug 'tpope/vim-fugitive'

" better `f`
Plug 'rhysd/clever-f.vim'

" Auto Completion
" this seems to be conflict w/ Deoplete (which is much better)
" Plug 'vim-scripts/AutoComplPop'

"============ Theme ============
Plug 'altercation/vim-colors-solarized'

"Plug 'rakr/vim-one'
"
Plug 'jordwalke/vim-one'

Plug 'NLKNguyen/papercolor-theme'
" =========== Theme ============
"

" Follow the installation guide to compile language server. It's good
" https://github.com/Valloric/YouCompleteMe#mac-os-x
" Require macvim / python-support etc.
" Disable for machine doesn't have python.
if has('python')
  Plug 'Valloric/YouCompleteMe'
endif

call plug#end()
" ============ Vim-plug ============


" ============ neovim ============
if (has("nvim"))
" close terminal windows input mode with <esc>
tnoremap <Esc> <C-\><C-n>

" mapping for openning terminal in split windows
" rather than splitting belowright by default by `set splitright` and `set splitbelow`
" using `:belowright split` to treat terminal splitting specially
command! -nargs=* D  belowright split | terminal <args>
command! -nargs=* DD belowright vsplit | terminal <args>

set inccommand=nosplit
endif
" ============ neovim ============


" ============ LSP ============
" use space as <leader>
let mapleader=" "

"\ 'reason': ['/Users/jsx/reason/reason-language-server/_build/default/bin/Bin.exe'],
"
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'reason': ['reason-language-server.exe'],
    \ 'fnl': ['fnl', '-fls', '-fls-trace-path','/Users/jsx/aros/tungsten/experimental/proto2/editors/fnl-code-samples/.fls.vim.log'],
    \ }

let g:LanguageClient_serverStderr = '/Users/jsx/aros/tungsten/experimental/proto2/editors/fnl-code-samples/.fls.vim.stderr.log'
let g:LanguageClient_loggingFile =  '/Users/jsx/aros/tungsten/experimental/proto2/editors/fnl-code-samples/.fls.vim.client.log'
" let g:LanguageClient_trace="verbose"

" https://github.com/autozimu/LanguageClient-neovim/wiki/Recommended-Settings
function SetLSPShortcuts()
  nnoremap <leader>d :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader> gf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <silent> gf :call LanguageClient#textDocument_rangeFormatting()<CR>
  nnoremap <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>r :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>a :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>c :call LanguageClient#textDocument_completion()<CR>
  nnoremap <silent><cr> :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>s :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>m :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> W :pclose<cr>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType fnl,reason,rust,cpp,c call SetLSPShortcuts()
augroup END
" ============ LSP ============


" ============ ALE ============
" Ale is a linter frontend supports beyond language server protocol
" for LSP-powered language supports, LanguageClient-neovim should be sufficient.
" let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" work with airline
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
\   'ocaml': ['merlin'],
\   'haskell': ['ghc-mod', 'hlint'],
\}

" default is 0
let g:ale_linters_explicit = 1

" echo format
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" ============ ALE ============


" ============ VIM-MARKDOWN ============
let g:markdown_fenced_languages = ['sh', 'agda', 'coq=ocaml', 'ocaml', 'ml=ocaml', 'sml', 'ts=typescript', 'typescript', 'reasonml=reason', 'reason', 'json', 'swift', 'html', 'css', 'js=javascript', 'hs=haskell', 'bnf=haskell', 'λ=haskell', 'kk=javascript', 'java', 'scala', 'kotlin', 'c', 'cs', 'cpp', 'rust', 'rs=rust', 'fnl', 'asm', 'wast', 'lisp', 'clj=clojure', 'py=python', 'python', 'yaml', 'php', 'hh=php', 'vim']
" ============ VIM-MARKDOWN ============


" ============ VIM-SURROUND ============
" using `s` as well for V-mode, aligned with spacemacs.
xmap s   <Plug>VSurround
" ============ VIM-SURROUND ============


" ============ VIMTEX ============
" https://castel.dev/post/lecture-notes-1/
let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
"au FileType markdown setlocal conceallevel=1
"au FileType tex setlocal conceallevel=1
"let g:tex_conceal='abdmg'
" ============ VIMTEX ============


" ============ Latex Unicoder ============
nnoremap <C-\> :call unicoder#start(0)<CR>
inoremap <C-\> <Esc>:call unicoder#start(1)<CR>
vnoremap <C-\> :call unicoder#selection()<CR>
" ============ Latex Unicoder ============


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

" line buffer
set history=100
" ============ FILE ============


" ============ Deoplete (Auto Completion) ============
" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" :help Deoplete.txt
set completeopt+=noinsert
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" https://github.com/Shougo/deoplete.nvim/issues/816
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" ============ Deoplete (Auto Completion) ============


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

" column
set colorcolumn=80,100,120
set signcolumn=yes

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


" ============ TERMINAL COLOR (Neovim Terminal) ============
" https://github.com/lifepillar/vim-solarized8/issues/9
let g:terminal_color_0 = '#073642'
let g:terminal_color_1 = '#dc322f'
let g:terminal_color_2 = '#719e07'
let g:terminal_color_3 = '#b58900'
let g:terminal_color_4 = '#268bd2'
let g:terminal_color_5 = '#d33682'
let g:terminal_color_6 = '#2aa198'
let g:terminal_color_7 = '#eee8d5'
let g:terminal_color_8 = '#002b36'
let g:terminal_color_9 = '#cb4b16'
let g:terminal_color_10= '#586e75'
let g:terminal_color_11= '#657b83'
let g:terminal_color_12= '#839496'
let g:terminal_color_13= '#6c71c4'
let g:terminal_color_14= '#93a1a1'
let g:terminal_color_15= '#fdf6e3'
" ============ TERMINAL COLOR (Neovim Terminal) ============


" ============ THEME (Solarized Dark & Power Line) ============
if has("syntax")
    " Enable syntax highlighting
    syntax enable

    " fix some syntax highlighting unsync problem
    syntax sync minlines=200

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

" commands for switch between light/dark background
command! Light set background=light
command! Dark set background=dark

" ============ THEME (One) ============



" ============ Hi Conceal  ============
unlet! g:indentLine_color_term g:indentLine_color_gui
hi Conceal ctermfg=245
" ============ Hi Conceal  ============
 
 
 
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
" let g:ctrlp_show_hidden = 1
" FZF can also do `:Rg`, which I haven't found a 

" ProjectFiles tries to locate files relative to the git root contained in
" NerdTree, falling back to the current NerdTree dir if not available
" see https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
map <C-p> : FZF<CR>
map <leader>f : Rg<CR>
" ============ CtrlP ============


" ============ Vim Rooter ============
let g:rooter_patterns = ['.hg', '.git/', 'package.json']
" ============ Vim Rooter ============

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


" ============ Indent Guide ============
let g:indent_guides_enable_on_vim_startup = 0
" ============ Indent Guide ============


" ============ Auto Pair ============
let g:AutoPairs = {'(':')', '[':']', '{':'}'}
let g:AutoPairsMapBS = 0

" ============ Auto Pair ============


" ============ JavaScript / Flow ============
let g:javascript_plugin_flow = 1
" ============ JavaScript / Flow ============

" ============ Merlin for OCaml / Reason ============
" comment out for fb dev
" augroup merlin
"   au!
"   let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"   execute "set rtp+=" . g:opamshare . "/merlin/vim"
"   set rtp^="/Users/hux/.opam/system/share/ocp-indent/vim"

"   " ----- Keybindings -----
"   au FileType ocaml map gd : MerlinLocate<cr>
"   au FileType ocaml map gf : ReasonPrettyPrint<cr>
"   au FileType ocaml map <cr> : MerlinTypeOf<cr>
" augroup end
" ============ Merlin for OCaml / Reason ============


" ============ Haskell/Ghc-mod ============
augroup ghcmod
  au!
  " ----- Keybindings -----
  au FileType haskell nnoremap <silent> <cr> :GhcModType<CR>
  au FileType haskell nnoremap <silent> gd :GhcModInfo<CR>
  au FileType haskell nnoremap <silent> gc :GhcModSigCodegen<CR>
  au FileType haskell vnoremap <silent> gf :'<,'>Hindent<CR> 
  "au FileType haskell vnoremap <silent> gf :'<,'>Stylishask<CR> 
  au FileType haskell vnoremap <silent> gi :'<,'>Hindent<CR>
  au FileType haskell nnoremap <silent> <esc> :GhcModTypeClear<CR>
augroup end
let g:hindent_on_save = 0
let g:stylishask_on_save = 0
let g:hindent_line_length = 100
" ============ Haskell/Ghc-mod ============


" ============ Haskell/Intero ============
" not sure if it gonna work but that's give it a try
" Intero starts automatically. Set this if you'd like to prevent that.
let g:intero_start_immediately = 0

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" Change the intero window size; default is 10.
let g:intero_window_size = 15

" Sets the intero window to split vertically; default is horizontal
let g:intero_vertical_split = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000
" ============ Haskell/Intero ============


" ============ SML ============
" let g:sml_auto_create_def_use = 'always'

augroup vimbettersml
  au!

  " ----- Keybindings -----

  au FileType sml nnoremap <silent> <cr> :SMLTypeQuery<CR>
  au FileType sml nnoremap <silent> <buffer> gd :SMLJumpToDef<CR>

  " open the REPL terminal buffer
  au FileType sml nnoremap <silent> <buffer> <leader>is :SMLReplStart<CR>
  " close the REPL (mnemonic: k -> kill)
  au FileType sml nnoremap <silent> <buffer> <leader>ik :SMLReplStop<CR>
  " build the project (using CM if possible)
  au FileType sml nnoremap <silent> <buffer> <leader>ib :SMLReplBuild<CR>
  " for opening a structure, not a file
  au FileType sml nnoremap <silent> <buffer> <leader>io :SMLReplOpen<CR>
  " use the current file into the REPL (even if using CM)
  au FileType sml nnoremap <silent> <buffer> <leader>iu :SMLReplUse<CR>
  " clear the REPL screen
  au FileType sml nnoremap <silent> <buffer> <leader>ic :SMLReplClear<CR>
  " set the print depth to 100
  au FileType sml nnoremap <silent> <buffer> <leader>ip :SMLReplPrintDepth<CR>

  " ----- Other settings -----

  " Uncomment to try out conceal characters
  au FileType sml setlocal conceallevel=2

  " Uncomment to try out same-width conceal characters
  " let g:sml_greek_tyvar_show_tick = 1
augroup END
" ============ SML ============

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
command! PasteOn set paste
command! PasteOff set nopaste

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

" move block of code up and down
:vnoremap <C-j> :m '>+1<CR>gv=gv
:vnoremap <C-k> :m '<-2<CR>gv=gv

" https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" ============ KEY MAPPING ============

" autocommand - file extension aliase
au bufnewfile,bufread *.ast setlocal filetype=lisp
au bufnewfile,bufread *.emj setlocal filetype=java
au bufnewfile,bufread *.imp setlocal filetype=ocaml
au bufnewfile,bufread *.v   setlocal filetype=ocaml
au FileType json syntax match Comment +\/\/.\+$+
"au bufnewfile,bufread *.v   setlocal filetype=coq      
au bufnewfile,bufread *.f   setlocal filetype=reason
au bufnewfile,bufread *.langf   setlocal filetype=sml
au bufnewfile,bufread *.kk  setlocal filetype=javascript
au Filetype asm setlocal tabstop=8



