" -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdc=3:

" Section: Global Setting {{{1
" ------------------------------------------------------------------------------
runtime! macros/matchit.vim
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set nocompatible      " We're running Vim, not Vi!

" Section: Plugins {{{1
silent! if plug#begin('~/.vim/bundle')
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-capslock'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-tbone'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }

  Plug 'scrooloose/nerdtree',  { 'on': 'NERDTreeToggle' }
  Plug 'vim-syntastic/syntastic'

  Plug 'vim-scripts/ag.vim'
  Plug 'vim-scripts/bufexplorer.zip', { 'on': 'BufExplorer' }

  Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim',  { 'on': 'Limelight' }
  Plug 'junegunn/gv.vim',         { 'on': 'GV' }

  Plug 'AndrewRadev/splitjoin.vim', { 'on': ['SplitjoinJoin', 'SplitjoinSplit'] }
  Plug 'AndrewRadev/sideways.vim',  { 'on': ['SidewaysLeft', 'SidewaysRight'] }
  Plug 'datanoise/switch.vim',      { 'on': 'Switch',
        \ 'for': ['ruby', 'eruby', 'php', 'haml', 'slim', 'cpp', 'javascript', 'coffee', 'clojure', 'scala'] }

  " file types
  Plug 'othree/html5.vim'
  Plug 'tpope/vim-markdown'
  Plug 'vim-ruby/vim-ruby'
  " lazy loading for filetypes makes sense only for those that are not
  " included in the standard Vim distribution. Otherwise, Vim will load them
  " anyway, possibly very old version.
  Plug 'tpope/vim-haml',           { 'for': ['haml', 'sass', 'scss'] }
  Plug 'rust-lang/rust.vim',       { 'for': 'rust' }
  Plug 'keith/swift.vim',          { 'for': 'swift' }
  Plug 'vim-scripts/nginx.vim',    { 'for': 'nginx' }
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
  Plug 'pangloss/vim-javascript',  { 'for': ['javascript', 'vue'] }
  Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' }
  Plug 'datanoise/vim-vue',        { 'for': ['javascript', 'vue'] }
  Plug 'tmux-plugins/vim-tmux',    { 'for': 'tmux' }
  Plug 'digitaltoad/vim-pug',      { 'for': ['pug', 'jade'] }
  Plug 'ekalinin/Dockerfile.vim',  { 'for': 'Dockerfile' }
  Plug 'hallison/vim-rdoc',        { 'for': 'rdoc' }
  Plug 'groenewege/vim-less',      { 'for': 'less' }
  Plug 'jneen/ragel.vim',          { 'for': 'ragel' }
  Plug 'ajf/puppet-vim',           { 'for': 'puppet' }
  Plug 'cespare/vim-toml',         { 'for': 'toml' }
  Plug 'datanoise/vim-elixir',     { 'for': ['elixir', 'eelixir'] }
  Plug 'datanoise/vim-crystal',    { 'for': ['crystal', 'html'] }
  Plug 'datanoise/vim-llvm',       { 'for': 'llvm' }
  if $GOPATH != ""
    " do not use lazy loading, cause it disables template function
    Plug 'fatih/vim-go'
  endif

  " ctrlp
  Plug 'datanoise/ctrlp.vim'
  Plug 'ompugao/ctrlp-history'
  Plug 'mattn/ctrlp-mark'
  Plug 'mattn/ctrlp-register'
  Plug 'kaneshin/ctrlp-tabbed'
  Plug 'tacahiroy/ctrlp-funky'

  " text objects
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-fold'
  Plug 'kana/vim-textobj-diff'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'kana/vim-textobj-syntax'
  Plug 'kana/vim-textobj-datetime'
  Plug 'datanoise/vim-textobj-quoted'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'thinca/vim-textobj-between'
  Plug 'lucapette/vim-textobj-underscore'

  " airline
  if $TERM == "" || $TERM == 'xterm-256color' || $TERM == 'screen-256color'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
  endif

  " ultisnips
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'godlygeek/tabular',            { 'on': 'Tabularize' }
  Plug 'datanoise/vim-indexed-search', { 'on': 'ShowSearchIndex' }
  Plug 'vim-scripts/searchfold.vim',   { 'on': '<Plug>SearchFoldNormal' }
  Plug 'datanoise/vim-bclose',         { 'on': 'Bclose' }
  Plug 'mbbill/undotree',              { 'on': 'UndotreeToggle' }
  Plug 'Yggdroot/indentLine',          { 'on': 'IndentLinesEnable' }
  Plug 'airblade/vim-gitgutter',       { 'on': ['GitGutterToggle', 'GitGutterEnable'] }

  Plug 'mileszs/ack.vim'
  Plug 'Raimondi/delimitMate'
  Plug 'majutsushi/tagbar'
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }
  Plug 'ervandew/supertab'
  Plug 'flazz/vim-colorschemes'
  Plug 'ap/vim-css-color'
  Plug 'datanoise/vim-localvimrc'
  Plug 'datanoise/vim-cmdline-complete'
  Plug 'rhysd/conflict-marker.vim'

  call plug#end()
endif

"
" Section: Functions {{{1
" ------------------------------------------------------------------------------
function! s:switch_prev_buf()
  let prev = bufname("#")
  if prev != '__InputList__' && bufloaded(prev) != 0
    b#
  else
    " echo "No buffer to switch to"
    CtrlPBuffer
  endif
endfunction

function! Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunction

function! s:vset_search()
  let tmp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = tmp
endfunction

function! s:filter_quickfix(bang, pattern)
  let cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . cmp . " a:pattern"))
endfunction

function! GitBranch()
  if exists('*fugitive#statusline')
    let branch = fugitive#statusline()
    return substitute(branch, 'Git(\(.*\))', '\1', '')
  endif
endfunction

function! s:tagInsert()
  if !has_key(g:plugs, 'vim-ragtag')
    return '>'
  elseif getline('.')[col('.')-2] == '>' && getline('.')[col('.')-1] == '<'
    call feedkeys("\<C-g>u") " create new undo sequence
    call feedkeys("\<CR>\<ESC>O", 'n')
    return ""
  elseif search('<', 'bn', line('.')) != 0 && searchpair('<', '', '>', 'bW') > 0
    call feedkeys("\<C-g>u") " create new undo sequence
    call feedkeys('></', 'n')
    call feedkeys("\<Plug>ragtagHtmlComplete")
    call feedkeys("\<ESC>F<i", 'n')
    return ""
  else
    return '>'
  endif
endfunction

" Section: Options {{{1
" ------------------------------------------------------------------------------
" tab options {{{2
set tabstop=8
set shiftwidth=2
set softtabstop=2
set smartindent
set smarttab
set expandtab
" }}}
" backup options {{{2
set nobackup
if has("win32")
  set backupdir=c:/tmp
  set directory=c:/tmp
else
  set backupdir=/tmp
  set directory=/tmp
endif
set undodir=~/tmp/undofile
set undofile
set history=1000
" to avoid error with crontab -e
set backupskip=/tmp/*,/private/tmp/*
" }}}
" search options {{{2
" always use incremental search
set incsearch
" no search highlighting by default, use <leader>h if needed
set nohlsearch
" case-sensitive search when using camel case search criteria
set smartcase
set wrapscan
" }}}
" status line options {{{2
set laststatus=2
set statusline=%m%<%.99f%q\ %h%w%r%y
set statusline+=%{exists('*CapsLockStatusline')?'\ '.CapsLockStatusline():''}
set statusline+=\ %{GitBranch()}
set statusline+=\ %#errormsg#%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*
set statusline+=%=
set statusline+=\ %-16(\ %l,%c-%v\ %)%P
" }}}
" cscope settings {{{2
if has('cscope')
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set cst
  set cspc=3
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
  endif
  set csverb
endif " }}}
" line breaks settings {{{2
set linebreak
set showbreak=»
if exists('&breakindent')
  " NOTE: patched VIM version is required for this to work
  set breakindent
  if exists('&breakindentopt')
    set breakindentopt+=sbr
  endif
endif
" }}}
" invisible chars display options {{{2
set list
if has("win32")
  set listchars=tab:>-,trail:-
else
  set listchars=tab:»·,trail:·
endif
set listchars+=extends:>,precedes:<
if version >= 700
  set listchars+=nbsp:+
endif
set fillchars+=vert:\|
" }}}
" wild options {{{2
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*.bundle,*.png,*.jpg,*.gif,*.class,*.log,*.beam,*.a,*.rlib
set showcmd
" }}}
" mouse options {{{2
set mousehide
" enable mouse in the terminal
set mouse=a
" }}}
" folding options {{{2
set foldmethod=marker
set foldlevel=99 " always expand folds
" }}}
" input method options {{{2
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set spelllang=ru_yo,en_us
"}}}
" uncategorized options {{{2
au ColorScheme * hi! link ColorColumn StatusLine
set bg=dark
if has('nvim')
  colo molokai
else
  colo datanoise
  if !has('gui_running') && has('termguicolors')
    set termguicolors
    if $TERM == "screen-256color"
      exec "set t_8f=\e[38;2;%lu;%lu;%lum"
      exec "set t_8b=\e[48;2;%lu;%lu;%lum"
    endif
  endif
endif
set scrolloff=5      " keep at least 5 lines above/below
set sidescrolloff=5  " keep at least 5 lines left/right
set autoread         " disable annoying confirmations
set hidden
if !has('nvim')
  set lazyredraw
endif
set title
set backspace=indent,eol,start
" set number
if exists("&macmeta")
  set macmeta " on Mac use Option key as Meta
endif
set belloff=all
set vb t_vb= " no visual bell or beep, damn it
" that makes it work on Windows too
if has("win32")
  au VimEnter * set vb t_vb=
endif
if getcwd() != expand('~')
  set path+=*/** " allow :find searching subdirectories
end
set tags+=../tags,../../tags,../../../tags,../../../../tags,./tmp/tags
set cpoptions+=d
set timeoutlen=1000 " A little bit more time for macros
set ttimeoutlen=10  " Make Esc work faster
" do not search included files and tags, it's a way too slow
set complete-=i
set complete-=t
" do not display :intro screen at startup
set shortmess+=I
set nofsync " don't spin my disk
set completeopt=menu,longest
set clipboard+=unnamed
au FocusGained * :sil! checktime
if has('gui_running')
  au FileType ruby setlocal keywordprg=ri\ -T\ -f\ bs\ --no-gems
else
  au FileType ruby setlocal keywordprg=ri\ --no-gems
end
au FileType ruby setlocal completefunc=syntaxcomplete#Complete
au FileType ruby if has('balloonexpr') | setlocal balloonexpr& | endif
au FileType scala,ruby,go exe 'compiler '. expand('<amatch>')
au FileType rust compiler rustc
au FileType xml setlocal foldmethod=syntax
au FileType go,godoc,netrw,help,qf,gitcommit,GV setlocal nolist
au FileType gitcommit,markdown,mkd,text setlocal spell
au FileType help setlocal nospell iskeyword+=_
au BufNewFile,BufRead *.prawn set ft=ruby
au BufNewFile,BufRead *.axlsx set ft=ruby
" go settings
au FileType go setlocal tabstop=4
au FileType go setlocal shiftwidth=4
au FileType go setlocal noexpandtab
" ignore target directory for cargo projects
au VimEnter *
      \ if filereadable('Cargo.toml') |
      \   set wildignore+=target |
      \ endif

au BufReadPost fugitive://* set bufhidden=delete
au VimResized * wincmd =
"}}}

" Section: Keybindings {{{1
" ------------------------------------------------------------------------------
let mapleader = ','
nnoremap <leader>sv :source ~/.vimrc
nnoremap <leader>sg :source ~/.gvimrc
nnoremap \vv :e ~/.vimrc
nnoremap \vg :e ~/.gvimrc

" visual select of the last pasted text
nnoremap <silent> <leader>v `[v`]
nnoremap <silent> <leader>h :set hlsearch!<CR>
nnoremap <silent> <C-l> :noh<CR><C-l>
nnoremap <silent> \l :setlocal list!<CR>
nnoremap <silent> \n :set nu!<CR>
" indented paste
nnoremap <silent> <leader>p p`]=`[
nnoremap <silent> <leader>P P=`]
nnoremap <silent> <leader>gp "_ddP=`]
" remove end-line spaces
nnoremap <silent> <leader>sd mx:%s/\s\+$//<CR>`x

nnoremap <C-J> <C-D>
nnoremap <C-K> <C-U>
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>
nmap     <silent> <leader>o A<CR>
nnoremap Y y$
nnoremap z- 1z=
nnoremap L :
nnoremap <silent> <leader>q :Bclose<CR>
nnoremap <silent> <leader>Q :bd<CR>
nnoremap [S [I:let nr = input("Which one: ") <Bar>exe "normal " . nr . "[\t"<CR>
nnoremap <leader>a :let align = input("Align to: ")<Bar>exe ":Tab /" . align<CR>
inoremap <silent> <C-l> <C-\><C-O>:call search('[{("\[\]'')}]', 'Wc', line('.'))<CR><Right>
" inoremap jj <Esc>
" imap kk <C-O>A<Enter>
nnoremap <F2> <C-w><C-w>
inoremap <F2> <Esc><C-w><C-w>
nnoremap <F1> <C-w><C-w>
inoremap <F1> <Esc><C-w><C-w>
inoremap <S-Tab> <Esc><C-w><C-w>
nnoremap <F4> :sil make %<CR><C-l>:cr<CR>
nnoremap [F :exe ':Ag ' . expand('<cword>')<CR><CR>
nnoremap ]F :exe ':Ag ' . matchstr(getline('.'), '\%'.virtcol('.').'v\w*')<CR><CR>
nnoremap <silent> <C-tab> :call <SID>switch_prev_buf()<CR>
nnoremap <silent> <C-^> :call <SID>switch_prev_buf()<CR>
nnoremap <silent> <C-6> :call <SID>switch_prev_buf()<CR>
if has('mac')
  nnoremap <silent> <D-[> :bprev<CR>
  nnoremap <silent> <D-]> :bnext<CR>
endif
nnoremap <silent> <leader>ct :!ctags --extra=+f -R *<CR><CR>
" insert modeline
inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>
" fugitive commands
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gh :Git push<CR>
nnoremap <silent> <leader>gl :Git pull<CR>
" quick search in visual mode
xnoremap <silent> * :<C-u>call <SID>vset_search()<CR>/<C-R>=@/<CR><CR>
xnoremap <silent> # :<C-u>call <SID>vset_search()<CR>?<C-R>=@/<CR><CR>
nnoremap <silent> <leader>sc :SyntasticCheck<CR>

nmap Q :qa!
" some handful command-mode bindings
cnoremap <M-q> qa!
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h'). '/' : '%%'
" better <Tab> handling in wild menu mode
set wildcharm=<C-Z>
cnoremap <expr> <Tab> wildmenumode() ? "\<Right>" : "\<C-Z>"
" abbreviations
cabbr vgf noau vimgrep //j<Left><Left><C-R>=Eatchar('\s')<CR>
cabbr ack Ack
cabbr ag Ag
cabbr pu PlugUpdate
cabbr pi PlugInstall

" file type bindings {{{2
au FileType coffee nnoremap <buffer> <F3> :CoffeeCompile<CR>
au FileType coffee vnoremap <buffer> <F3> :CoffeeCompile<CR>
au FileType coffee nnoremap <buffer> <F4> :CoffeeRun<CR>
au FileType coffee nnoremap <buffer> <F5> :CoffeeMake<CR><CR>
au FileType godoc nnoremap <silent> <buffer> q :bd<CR>
au FileType help nnoremap <silent> <buffer> q :helpclose<CR>
au FileType go nnoremap <silent> <buffer> K :GoDoc<CR>
au FileType go nmap <silent> <buffer> <leader>goi <Plug>(go-import)
au FileType go nmap <silent> <buffer> <leader>goI <Plug>(go-imports)
au FileType go nmap <silent> <buffer> <leader>god <Plug>(go-def)
au FileType go nmap <silent> <buffer> <leader>gok <Plug>(go-doc-tab)
au FileType go nmap <silent> <buffer> <leader>gos <Plug>(go-info)
au FileType ruby if match(expand('<afile>'), '_spec\.rb$') > 0|nnoremap <buffer> <F4> :!rspec --format doc -c %<CR>|endif
au FileType ruby if match(expand('<afile>'), '_spec\.rb$') > 0|nnoremap <buffer> <F5> :exe '!rspec --format doc -c ' . expand('%') . ':' . line('.')<CR>|else|nnoremap <buffer> <F5> :!ruby %<CR>|endif
au FileType ruby,puppet inoremap <buffer> <expr> <c-l> pumvisible() ? "\<lt>c-l>" : " => "
au FileType php  nnoremap <buffer> <F5> :!php %<CR>
au FileType javascript nnoremap <silent> <buffer> <F4> :!node %<CR>
au FileType qf nmap <silent> <buffer> q :q<CR>
au FileType javascript.jsx let b:syntastic_checkers = ["javascript/eslint"]

au FileType xml,html,vue,eruby let b:delimitMate_matchpairs = "(:),[:],{:}"
au FileType xml,html,vue,eruby imap <silent> <buffer> <expr> > <SID>tagInsert()

au CmdwinEnter * nmap <buffer> <leader>q :q<CR>
au CmdwinEnter * nmap <buffer> q :q<CR>

if has("cscope")
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  au FileType c,cpp,h,hpp nnoremap <buffer> <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif


" Section: Commands {{{1
" ------------------------------------------------------------------------------
" NOTE: that doesn't work in MacVim gui mode if sudo requests a password!!!
command! -bar -nargs=0 SudoW   :exe "write !sudo tee % >/dev/null"|silent edit!
au FileType ruby iabbrev <buffer> rb! #!<C-R>=substitute(system('which ruby'),'\n$','','')<CR><C-R>=Eatchar('\s')<CR>
command! -bang -nargs=1 -complete=file QFilter call s:filter_quickfix(<bang>0, <q-args>)
au FileType markdown command! -nargs=0 -complete=file -buffer Preview :exe "sil !markdown " . expand('%') ."| bcat" | :redraw!
" borrowed from tpope's plugin
augroup shebang_chmod
  au!
  au BufWritePre *
        \   if getline(1) =~ '^#![\@!' && match(getfperm(expand('<afile>')), 'x') == -1 |
        \     let b:chmod_post = '+x' |
        \   endif |
  au BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup end
augroup auto_create_directory
  au!
  au BufWritePre *
        \  let d=expand("<afile>:h") |
        \  if !isdirectory(d) |
        \    call mkdir(d, 'p') |
        \  endif |
        \  unlet d
augroup end

" Section: Plugin settings {{{1
" ------------------------------------------------------------------------------
" Tagbar settings  {{{2
let g:tagbar_left      = 1
let g:tagbar_width     = 30
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
nnoremap <silent> \t  :TagbarToggle<CR>

" NERD_tree settings {{{2
let g:NERDTreeQuitOnOpen        = 1 " Close NERDTree when a file is opened
let g:NERDTreeHijackNetrw       = 0
let g:NERDTreeIgnore            = ['\.o$', '\~$', '\.class$']
let g:NERDTreeMinimalUI         = 0
let g:NERDTreeDirArrows         = 1
let g:NERDTreeRespectWildIgnore = 1
nnoremap <silent> <leader>f  :exec 'NERDTree' . expand('%:p:h')<CR>

" rubycomplete plugin settings {{{2
let g:rubycomplete_buffer_loading    = 1
let g:rubycomplete_rails             = 0
let g:rubycomplete_classes_in_global = 1

" syntastic settings {{{2
" puppet is too slow, html/tidy doesn't support HTML5, vim-go provides its own
" checker
let g:syntastic_mode_map = { 'mode': 'active',
      \  'active_filetypes':  [],
      \  'passive_filetypes': ['cpp', 'c', 'scss', 'puppet', 'html', 'cucumber', 'java', 'go']
      \  }
let g:syntastic_auto_loc_list       = 0
let g:syntastic_enable_signs        = 1
let g:syntastic_stl_format          = '[ERR:%F(%t)]'
let g:syntastic_javascript_jsl_conf = "~/.jsl.conf"
let g:syntastic_echo_current_error  = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_coffee_lint_options = '-f ~/.coffeelint.json'
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_go_checkers = ["gofmt"]
let g:syntastic_enable_elixir_checker = 0
let g:syntastic_elixir_checkers = ['elixir']

" A settings {{{2
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,m,mm"
let g:alternateExtensions_m = "h"
let g:alternateExtensions_mm = "h"

" tabular settings {{{2
nnoremap <silent> g= :Tabularize assignment<CR>
xnoremap <silent> g= :Tabularize assignment<CR>

" ctrlp settings {{{2
let g:ctrlp_extensions = ['buffertag', 'quickfix', 'dir', 'rtscript',
      \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_mruf_relative = 0
let g:ctrlp_max_files = 10000
let g:ctrlp_open_multi = 'tr'
let g:ctrlp_open_new_file = 'h'
let g:ctrlp_mruf_exclude = '\.git\|\/var\/folders\|' . substitute($VIMRUNTIME, '/', '\\/', 'g')
let g:ctrlp_buftag_types = {
      \ 'go'     : '--language-force=Go --Go-types=fvt',
      \ 'scala'  : '--language-force=scala --scala-types=ctTm',
      \ 'coffee' : '--language-force=coffee --coffee-types=m',
      \ 'elixir' : '--language-force=elixir --elixir-types=facdmpr',
      \ 'crystal': '--language-force=crystal --crystal-types=f'
      \  }
if executable('crystal-tags')
  cal extend(g:ctrlp_buftag_types, { 'crystal': { 'args': '-f - -N --fields nK', 'bin': 'crystal-tags' } })
en
if executable('ag') && !exists("&macmeta")
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let s:ignored = ['.git', '.hg', '.svn', '.gif', '.jpg', '.jpeg', '.png']
  let s:ignored_pattern = join(map(s:ignored, '"\\" . v:val . "$\\|"'), "")
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --nocolor --ignore "' . s:ignored_pattern . '"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

nnoremap <silent> <leader>m :CtrlPCurWD<CR>
nnoremap <silent> <leader>r :CtrlPRoot<CR>
nnoremap <silent> <leader>l :CtrlPBuffer<CR>
nnoremap <silent> <leader>t :CtrlPBufTag<CR>
au FileType go nnoremap <silent> <buffer> <leader>t :GoDecls<CR>
au FileType go nnoremap <silent> <buffer> <leader>gt :GoDeclsDir<CR>
nnoremap <silent> <leader>e :CtrlPMRUFiles<CR>
nnoremap <silent> <leader>x :CtrlPMixed<CR>
nnoremap <silent> <leader>cc :ClearCtrlPCache<CR>
nnoremap <silent> <leader>ca :ClearAllCtrlPCaches<CR>
nnoremap <silent> <leader>kf :CtrlPCurFile<CR>
nnoremap <silent> <leader>kb :CtrlPBuffer<CR>
nnoremap <silent> <leader>kt :CtrlPTabbed<CR>
nnoremap <silent> <leader>kq :CtrlPQuickfix<CR>
nnoremap <silent> <leader>kd :CtrlPDir<CR>
nnoremap <silent> <leader>kR :CtrlPRTS<CR>
nnoremap <silent> <leader>ku :CtrlPUndo<CR>
nnoremap <silent> <leader>kl :CtrlPLine<CR>
nnoremap <silent> <leader>kc :CtrlPChange<CR>
nnoremap <silent> <leader>kx :CtrlPBookmarkDir<CR>
nnoremap <silent> <leader>kg :CtrlPTag<CR>
nnoremap <silent> <leader>kh :CtrlPCmdHistory<CR>
nnoremap <silent> <leader>ks :CtrlPSearchHistory<CR>
nnoremap <silent> <leader>kr :CtrlPRegister<CR>
nnoremap <silent> <leader>km :CtrlPMark<CR>

nnoremap <silent> <leader>ky :CtrlPFunky<CR>
let g:ctrlp_funky_syntax_highlight = 1

" supertab settings {{{2
let g:SuperTabCrMapping = 0
" au FileType go call SuperTabSetDefaultCompletionType("<c-x><c-o>")
au FileType go,rust call SuperTabSetDefaultCompletionType("context")

" ultisnips settings {{{2
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" vim-go settings {{{2
let g:go_auto_type_info = 0
let g:go_def_mode = 'godef'

let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 0

" airline settings {{{2
if has_key(g:plugs, 'vim-airline')
  set noshowmode
  let g:airline_theme='datanoise'
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#tagbar#enabled = 1
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline_detect_iminsert=1
  nmap <silent> <leader>1 <Plug>AirlineSelectTab1
  nmap <silent> <leader>2 <Plug>AirlineSelectTab2
  nmap <silent> <leader>3 <Plug>AirlineSelectTab3
  nmap <silent> <leader>4 <Plug>AirlineSelectTab4
  nmap <silent> <leader>5 <Plug>AirlineSelectTab5
  nmap <silent> <leader>6 <Plug>AirlineSelectTab6
  nmap <silent> <leader>7 <Plug>AirlineSelectTab7
  nmap <silent> <leader>8 <Plug>AirlineSelectTab8
  nmap <silent> <leader>9 <Plug>AirlineSelectTab9
endif

" easy-align settings {{{2
if has_key(g:plugs, 'vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

" gitgutter settings {{{2
if has_key(g:plugs, 'vim-gitgutter')
  let g:gitgutter_sign_column_always = 1
  let g:gitgutter_enabled = 0
  nnoremap <leader>gg :GitGutterToggle<CR>
endif

" splitjoin settings {{{2
if has_key(g:plugs, "splitjoin.vim")
  nnoremap <silent> <leader>ss :SplitjoinSplit<CR>
  nnoremap <silent> <leader>sj :SplitjoinJoin<CR>
endif

" vim-commentary settings {{{2
if has_key(g:plugs, 'vim-commentary')
  map  gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
end

" bufexplorer settings {{{2
if has_key(g:plugs, 'bufexplorer.zip')
  nnoremap <silent> <leader>be :BufExplorer<CR>
end

" searchfold settings {{{2
if has_key(g:plugs, 'searchfold')
  nmap <Leader>z <Plug>SearchFoldNormal
endif

" sideways.vim settings {{{2
if has_key(g:plugs, 'sideways.vim')
  nnoremap <silent> <leader>< :<C-u>SidewaysLeft<CR>
  nnoremap <silent> <leader>> :<C-u>SidewaysRight<CR>
endif

" vim-surround settings {{{2
if has_key(g:plugs, 'vim-surround')
  xmap s   <Plug>VSurround
  xmap gs  <Plug>VgSurround
endif

" undotree settings {{{2
if has_key(g:plugs, 'undotree')
  let g:undotree_WindowLayout = 2
  nnoremap <silent> U :UndotreeToggle<CR>
endif

" switch.vim settings {{{2
if has_key(g:plugs, 'switch.vim')
  nnoremap <silent> gs :Switch<CR>
endif

" fzf plugin & settings {{{2
if !has('gui_running') && isdirectory('/usr/local/opt/fzf')
  set rtp+=/usr/local/opt/fzf
  nnoremap <leader>F :FZF<CR>
  cabbr fzf FZF
  execute "cnoremap <M-t> FZF "
  execute "nnoremap <M-t> :FZF "
endif

" vim-plug settings {{{2
let g:plug_window = 'tabnew'
let g:plug_pwindow = 'below new'

" textobj-between settings {{{2
let g:textobj_between_no_default_key_mappings = 1
xmap ac  <Plug>(textobj-between-a)
omap ac  <Plug>(textobj-between-a)
xmap ic  <Plug>(textobj-between-i)
omap ic  <Plug>(textobj-between-i)

" Misc settings {{{2
let c_comment_strings = 1 " I like highlighting strings inside C comments
let g:xml_syntax_folding = 1 " enable folding in xml files
let g:racer_cmd = 'racer'
let g:vim_jsx_pretty_colorful_config = 1
let g:filetype_m = 'objc' " always open *.m files with objc filetype
let delimitMate_expand_space = 1

" }}}
