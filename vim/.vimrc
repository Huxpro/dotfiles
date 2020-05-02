scriptencoding utf-8

set ffs=unix,dos
set nocompatible              " Disable Vi compatibility


" =============================================================================
" Plugins (via Vim-Plug)
" =============================================================================
call plug#begin('~/.vim/plugged')

" -----------------------------------------------------------------------------
" CoC - Conquer of Completion
" -----------------------------------------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" -----------------------------------------------------------------------------
" LSP
" -----------------------------------------------------------------------------
" Alternative LSP client for vim/nvim
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" -----------------------------------------------------------------------------
" Deoplete
" Deoplete is a independent Dark powered asynchronous completion framework for neovim/Vim8.
" LC-neovim use it to support LSP-powered autocompletion. 
" CoC use its own.
" -----------------------------------------------------------------------------
if has('nvim') " for neovim
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else  " for vim 8 with python
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" -----------------------------------------------------------------------------
" FZF
" FZF is a independent replacement to CtrlP,
" LC-neovim use it for contextMenu when it exists.
" -----------------------------------------------------------------------------
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'


" -----------------------------------------------------------------------------
" Theme
" -----------------------------------------------------------------------------
Plug 'altercation/vim-colors-solarized'
Plug 'jordwalke/vim-one'
Plug 'jordwalke/vim-taste'
Plug 'NLKNguyen/papercolor-theme'


" -----------------------------------------------------------------------------
" Languages
" -----------------------------------------------------------------------------
" FNL
Plug '~/proto2/editors/fnl-vim'

" FCL
Plug '~/fcl/fcl-vim'
 
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
" Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-markdown'

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

" LaTex 
Plug 'lervag/vimtex'

" Isabelle
"Plug '~/.vim/plugged/isabelle'  "unusable
"set rtp+=~/.vim/plugged/isabelle.vim

" Dart
Plug 'dart-lang/dart-vim-plugin'

" -----------------------------------------------------------------------------
" Misc
" -----------------------------------------------------------------------------
" nerdtree
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] } 
Plug 'jistr/vim-nerdtree-tabs'

" work w/ ctag
Plug 'majutsushi/tagbar', { 'on':  ['TagbarToggle'] }

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

" auto-pairs 
Plug 'jiangmiao/auto-pairs'

" Tex input-method <C-L>
Plug 'joom/latex-unicoder.vim'

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

" Auto Completion (Deprecated in favor of Deoplete and CoC)
" Plug 'vim-scripts/AutoComplPop'
" Plug 'Valloric/YouCompleteMe'

call plug#end()


" =============================================================================
" Vim Configuration
" =============================================================================
" -----------------------------------------------------------------------------
" Neovim
" -----------------------------------------------------------------------------
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


" -----------------------------------------------------------------------------
" File
" -----------------------------------------------------------------------------
" Encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencodings=utf-8
set encoding=utf-8

" Enable filetype plugins
" https://superuser.com/questions/68226/filetype-detection-not-working
filetype off
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread
set autochdir "auto change dir

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" line buffer
set history=100


" -----------------------------------------------------------------------------
" Text (Tab, Indentation)
" -----------------------------------------------------------------------------
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


" -----------------------------------------------------------------------------
" UI, UX
" -----------------------------------------------------------------------------
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

" Refresh rate. Shorted time give faster LSP diagnostics.
set updatetime=300

" No annoying sound on errors
set noerrorbells

" mouse support
set mouse=a

" timeout
set timeoutlen=1000 ttimeoutlen=0

" syntax highlight sync
syntax sync minlines=256

" https://vim.fandom.com/wiki/Fix_syntax_highlighting 
" huge perf impact
" autocmd BufEnter * :syntax sync fromstart


" -----------------------------------------------------------------------------
" Search
" -----------------------------------------------------------------------------
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


" -----------------------------------------------------------------------------
" Theme - True Color Support for True Color Theme
" -----------------------------------------------------------------------------
function! TrueColor()
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
endfunction()


" -----------------------------------------------------------------------------
" Theme - Solarized 
" - True Color Terminal: NOOOOO.
" - Non True Color Terminal: GOOD with Terminal Theme support.
" -----------------------------------------------------------------------------
function! SetThemeSolarized()
  if has("syntax")
      silent! colorscheme solarized

      " For dark version
      set background=dark

      " For light version
      "set background=light
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
endfunction()


" -----------------------------------------------------------------------------
" Theme - One Dark/Light
" - True Color Terminal: GOOD.
" - Non True Color Terminal: NOOOOO.
" -----------------------------------------------------------------------------
function! SetThemeOne()
  if has("syntax")
      " Noted that One theme can use with any itermcolor
      silent! colorscheme one
  endif

  " I love italic for comments
  let g:one_allow_italics = 1

  let g:airline_theme='one'
endfunction()


" -----------------------------------------------------------------------------
" Theme - PaperColor
" - True Color Terminal: GOOD.
" - Non True Color Terminal: surprisingly good even w/o Terminal Theme support.
" -----------------------------------------------------------------------------
function! SetThemePaperColor()
  if has("syntax")
      silent! colorscheme PaperColor

      " I much much preferred its Light version than Dark.
      set background=light
  endif

  let g:airline_theme='papercolor'
endfunction()


" -----------------------------------------------------------------------------
" Theme - Taste
" - True Color Terminal: GOOD.
" - Non True Color Terminal: surprisingly good even w/o Terminal Theme support.
" -----------------------------------------------------------------------------
function! SetThemeTaste()
  if has("syntax")
      silent! colorscheme taste
  endif

  let g:airline_theme='taste'
endfunction()


" -----------------------------------------------------------------------------
" Theme - Util
" -----------------------------------------------------------------------------
function! SetTheme(name, bg)
  if a:name == "PaperColor"
    call SetThemePaperColor()
  elseif a:name == "Taste"
    call SetThemeTaste()
  elseif a:name == "Solarized"
    call SetThemeSolarized()
  else 
    call SetThemeOne()
  endif

  if a:bg == "Dark"
      set background=dark
  else
      set background=light
  endif
endfunction()


" -----------------------------------------------------------------------------
" Theme - Dark/Light switching
" -----------------------------------------------------------------------------
function! AutoDarkLight()
  " https://apas.gr/2018/11/dark-mode-macos-safari-iterm-vim/
  " the main issue that "hot key" switching profiles won't update the env var.
  let iterm_profile = $ITERM_PROFILE

  if iterm_profile == "Dark"
    call SetTheme("One", "Dark")
  else
    call SetTheme("PaperColor", "Light")
  endif
endfunction()


" -----------------------------------------------------------------------------
" Theme - Choose theme by terminal program using.
" -----------------------------------------------------------------------------
let term_prog = $TERM_PROGRAM

" Non True Color
if term_prog == "Apple_Terminal" 
    " Set 256 color terminal support
    set t_Co=256
    call SetTheme("PaperColor", "Light")
" The vim itself might support 256 color only as well
elseif &t_Co <= 256
    call SetTheme("PaperColor", "Light")
" Assume True Color
else 
    call TrueColor()
    call AutoDarkLight()
endif

" -----------------------------------------------------------------------------
" Theme - Key binding for switching themes
"
" still have problems that markdown injected syntax would not refresh.
" so the current best way is still to do `i` in the iterm, or macOS dark mode.
" -----------------------------------------------------------------------------
command! Light set background=light
command! Dark set background=dark
command! One :call SetThemeOne() | :AirlineRefresh
command! Taste :call SetThemeTaste() | :AirlineRefresh
command! Paper :call SetThemePaperColor() | :AirlineRefresh
command! Solarized :call SetThemeSolarized()
command! OneDark :call SetTheme("One", "Dark") | :AirlineRefresh
command! PaperLight :call SetTheme("PaperColor", "Light") | :AirlineRefresh

" -----------------------------------------------------------------------------
" Hi Conceal
" -----------------------------------------------------------------------------
unlet! g:indentLine_color_term g:indentLine_color_gui
hi Conceal ctermfg=245
 
 
" -----------------------------------------------------------------------------
" Key Bindings
" -----------------------------------------------------------------------------
" use space as <leader>
let mapleader=" "

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


" =============================================================================
" Plugin Configuration
" =============================================================================
" -----------------------------------------------------------------------------
" Airline (Powerline)
" -----------------------------------------------------------------------------
" powerline symbols
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"this line will break airline
"set ambiwidth=double


" -----------------------------------------------------------------------------
" Vim-surround
" -----------------------------------------------------------------------------
" enable both `s` (spacemacs) and `S` (default, vscode) for V-mode
xmap s   <Plug>VSurround
xmap S   <Plug>VSurround


" -----------------------------------------------------------------------------
" Deoplete (AutoCompletion)
"
" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" :help Deoplete.txt
" disabled in favor of CoC
" -----------------------------------------------------------------------------
" set completeopt+=noinsert
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" https://github.com/Shougo/deoplete.nvim/issues/816
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" enable autocomplete 
let g:deoplete#enable_at_startup = 0  " disabled in favor of CoC


" -----------------------------------------------------------------------------
" Nerd Tree
" -----------------------------------------------------------------------------
" NERDTree shortcut
map <C-n> : NERDTreeToggle<CR>

" binding like spacemacs
let NERDTreeMapOpenSplit='-'
let NERDTreeMapOpenVSplit='<Bar>'

" auto-open by default
" au VimEnter *  NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden= 1
" let NERDTreeQuitOnOpen = 1

" -----------------------------------------------------------------------------
" FZF / Ctrl P
" -----------------------------------------------------------------------------
" Show hidden files when using ctrlp
" let g:ctrlp_show_hidden = 1
" FZF can also do `:Rg`, which I haven't found a 

" ProjectFiles tries to locate files relative to the git root contained in
" NerdTree, falling back to the current NerdTree dir if not available
" see https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
map <C-p> : FZF<CR>
map <leader>f : Rg<CR>


" -----------------------------------------------------------------------------
" Vim Rooter
" -----------------------------------------------------------------------------
let g:rooter_patterns = ['.hg', '.git/', 'package.json']


" -----------------------------------------------------------------------------
" Tagbar
" -----------------------------------------------------------------------------
" Okay to override since I don't use Vim native tag yet.
map <C-t> : TagbarToggle<CR>


" -----------------------------------------------------------------------------
" Clever-F
" -----------------------------------------------------------------------------
let g:clever_f_smart_case = 1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)


" -----------------------------------------------------------------------------
" Vim Commentary
" -----------------------------------------------------------------------------
" <C_/>
map <C-_> : Commentary<cr>


" -----------------------------------------------------------------------------
" Indent Guide
" -----------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 0


" -----------------------------------------------------------------------------
" Auto Pairs
" -----------------------------------------------------------------------------
let g:AutoPairs = {'(':')', '[':']', '{':'}'}
let g:AutoPairsMapBS = 0


 
" =============================================================================
" Language Specific Configuration
" =============================================================================
" -----------------------------------------------------------------------------
" LanguageClient-NeoVim
" -----------------------------------------------------------------------------
"\ 'reason': ['/Users/jsx/reason/reason-language-server/_build/default/bin/Bin.exe'],

" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ 'fnl': ['fnl', '-fls', '-fls-trace-path','~/proto2/editors/fnl-code-samples/.fls.vim.log'],
"     \ 'reason': ['reason-language-server.exe'],
"     \ }

" https://github.com/autozimu/LanguageClient-neovim/wiki/Recommended-Settings
function! SetLSPShortcuts()
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <silent> gf :call LanguageClient#textDocument_rangeFormatting()<CR>

  nnoremap <leader>d :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>* :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>gf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>a :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>c :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>o :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>m :call LanguageClient_contextMenu()<CR>
  nnoremap <silent><cr> :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent>W :pclose<cr>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
augroup END

" -----------------------------------------------------------------------------
" CoC
" -----------------------------------------------------------------------------
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Link document highlight to underscore (Underlined is colored. It depends on theme)
highlight default link CocHighlightText SpellBad 

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

function! SetCocShortcuts()
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)
  nmap <leader>d <Plug>(coc-definition)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <leader>* <Plug>(coc-references)
  nmap <leader>r <Plug>(coc-rename)
  nmap <silent> gr <Plug>(coc-rename)
  nmap <leader>t <Plug>(coc-type-definition)
  nmap <leader>i <Plug>(coc-implementation)
  nnoremap <silent> <cr> :call <SID>show_documentation()<CR>
  nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
  nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
  nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
  nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
  nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
  nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
  nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
  nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
endfunction()

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

augroup COC
  autocmd!
  autocmd FileType c,h,cpp,fnl,reason,ocaml,rust,java,sh,python,html,css,yaml call SetCocShortcuts()
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END


" -----------------------------------------------------------------------------
" ALE
" -----------------------------------------------------------------------------
" Ale is a linter frontend supports beyond language server protocol
" for LSP-powered language supports, LanguageClient-neovim should be sufficient.
" let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" work with airline
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
\   'haskell': ['ghc-mod', 'hlint'],
\}
" \   'ocaml': ['merlin'],
"
" default is 0
let g:ale_linters_explicit = 1

" echo format
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" -----------------------------------------------------------------------------
" Vim Markdown
" -----------------------------------------------------------------------------
" Modified from <https://stsievert.com/blog/2016/01/06/vim-jekyll-mathjax/>.
" https://stackoverflow.com/questions/32865744/vim-syntax-and-latex-math-inside-markdown
function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'

    " THIS MUST BE DELETED SO "GFM FENCED CODE BLOCK" CAN STILL HIGHLIGHT BY LANG AS BEFORE.
    " syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction
"let g:vim_markdown_fenced_languages =
let g:markdown_fenced_languages = ['sh', 'make', 'agda', 'coq=ocaml', 'ocaml', 'ml=ocaml', 'sml', 'f=sml', 'lgf=sml', 'core=sml', 'reploc=sml', 'vmcode=javascript', 'ts=typescript', 'typescript', 'reasonml=reason', 're=reason', 'reason', 'json', 'swift', 'html', 'css', 'js=javascript', 'hs=haskell', 'bnf=haskell', 'λ=haskell', 'kk=javascript', 'java', 'scala', 'kotlin', 'c', 'cs', 'cpp', 'rust', 'rs=rust', 'fnl', 'asm', 'wast', 'wat=wast', 'lisp', 'clj=clojure', 'racket=lisp', 'rkt=lisp', 'dune=lisp', 'py=python', 'python', 'ks=python', 'buck=python', 'yaml', 'php', 'hh=php', 'vim', 'lex', 'yacc', 'grm=sml']

" buggy
let g:vim_markdown_folding_disabled = 1

let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

" -----------------------------------------------------------------------------
" Vim Tex
" -----------------------------------------------------------------------------
" https://castel.dev/post/lecture-notes-1/
let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
"au FileType markdown setlocal conceallevel=1
"au FileType tex setlocal conceallevel=1
"let g:tex_conceal='abdmg'


" -----------------------------------------------------------------------------
" Latex Unicoder
" -----------------------------------------------------------------------------
nnoremap <C-\> :call unicoder#start(0)<CR>
inoremap <C-\> <Esc>:call unicoder#start(1)<CR>
vnoremap <C-\> :call unicoder#selection()<CR>


" -----------------------------------------------------------------------------
" JavaScript / Flow
" -----------------------------------------------------------------------------
let g:javascript_plugin_flow = 1


" -----------------------------------------------------------------------------
" Git Message
" -----------------------------------------------------------------------------
au FileType gitcommit setlocal tw=72
au FileType gitcommit set colorcolumn=50,72


" -----------------------------------------------------------------------------
" Merlin for OCaml / Reason
" -----------------------------------------------------------------------------
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


" -----------------------------------------------------------------------------
" Haskell - GHC-Mod
" -----------------------------------------------------------------------------
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
augroup END
let g:hindent_on_save = 0
let g:stylishask_on_save = 0
let g:hindent_line_length = 100


" -----------------------------------------------------------------------------
" Haskell - Intero
" -----------------------------------------------------------------------------
" not sure if it gonna work but that's give it a try
" Intero starts automatically. Set this if you'd like to prevent that.
let g:intero_start_immediately = 0

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" Change the intero window size; default is 10.
let g:intero_window_size = 15

" Sets the intero window to split vertically; default is horizontal
let g:intero_vertical_split = 1


" -----------------------------------------------------------------------------
" Standard ML
" -----------------------------------------------------------------------------
augroup BetterSML
  au!

  " ----- Keybindings -----

  au FileType sml nnoremap <silent> <cr> :SMLTypeQuery<CR>
  au FileType sml nnoremap <silent> gd :SMLJumpToDef<CR>
  " open the REPL terminal buffer
  au FileType sml nnoremap <silent> <leader>is :SMLReplStart<CR>
  " close the REPL (mnemonic: k -> kill)
  au FileType sml nnoremap <silent> <leader>ik :SMLReplStop<CR>
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
  " au FileType sml setlocal conceallevel=2

  " Uncomment to try out same-width conceal characters
  " let g:sml_greek_tyvar_show_tick = 1
  
  " Mlton def-use
  " let g:sml_auto_create_def_use = 'always'

augroup END

au Filetype sml setlocal tabstop=3
au Filetype sml setlocal softtabstop=3
au Filetype sml setlocal shiftwidth=3


" -----------------------------------------------------------------------------
" Isabelle
" -----------------------------------------------------------------------------

au BufRead,BufNewFile *.thy setfiletype isabelle
au BufRead,BufNewFile *.thy set conceallevel=2

" -----------------------------------------------------------------------------
" Language specfic settings - Syntax Extension
" -----------------------------------------------------------------------------
" Add comment to JSON
au FileType json syntax match Comment +\/\/.\+$+


" -----------------------------------------------------------------------------
" Language specfic settings - Tab size
" -----------------------------------------------------------------------------
au Filetype asm setlocal tabstop=8


" -----------------------------------------------------------------------------
" Language specfic settings - Binary (as Hexdump)
" -----------------------------------------------------------------------------
" https://vim.fandom.com/wiki/Improved_hex_editing
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END


" -----------------------------------------------------------------------------
" File-extension-based Alias
" -----------------------------------------------------------------------------

" Tiger
au bufnewfile,bufread *.tig  setlocal filetype=ocaml

" Coq
" ocaml will trigger language server which will report err
au bufnewfile,bufread *.v   setlocal filetype=sml

" Emjc
au bufnewfile,bufread *.ast setlocal filetype=lisp
au bufnewfile,bufread *.emj setlocal filetype=java
au bufnewfile,bufread *.flex setlocal filetype=lex

" PLT
au bufnewfile,bufread *.imp setlocal filetype=fnl

" LangF
au bufnewfile,bufread *.lgf  setlocal filetype=sml   "CC
au bufnewfile,bufread *.langf setlocal filetype=sml  "PLT
au bufnewfile,bufread *.scan.toks setlocal filetype=sml
au bufnewfile,bufread *.scan.*.toks setlocal filetype=sml
au bufnewfile,bufread *.parse.pt setlocal filetype=sml
au bufnewfile,bufread *.parse.*.pt setlocal filetype=sml
au bufnewfile,bufread *.type-check.ast setlocal filetype=sml
au bufnewfile,bufread *.type-check.*.ast setlocal filetype=sml
au bufnewfile,bufread *.convert-to-core.core setlocal filetype=sml
au bufnewfile,bufread *.convert-to-anf.anf setlocal filetype=sml
au bufnewfile,bufread *.pre.core setlocal filetype=sml
au bufnewfile,bufread *.post.core setlocal filetype=sml
au bufnewfile,bufread *.pre.anf setlocal filetype=sml
au bufnewfile,bufread *.post.anf setlocal filetype=sml
au bufnewfile,bufread *.reploc setlocal filetype=sml
au bufnewfile,bufread *.vmcode setlocal filetype=javascript

" Koka
au bufnewfile,bufread *.kk  setlocal filetype=javascript


" -----------------------------------------------------------------------------
" This is injected by `opam user-setup install`
"
" Hot-reload .vimrc changes
" https://vim.fandom.com/wiki/Change_vimrc_with_auto_reload
" -----------------------------------------------------------------------------
autocmd! bufwritepost .vimrc source %
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
