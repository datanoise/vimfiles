 -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdc=3:

" Section: Global Setting {{{1
" ------------------------------------------------------------------------------
runtime! macros/matchit.vim
set nocompatible      " We're running Vim, not Vi!
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Section: Functions {{{1
" ------------------------------------------------------------------------------
function! GetCurDir()
  let result = substitute(getcwd(), '^'.$HOME, '~', '')
  let result = substitute(result, '^.\+\ze.\{20,}', '<', '')
  return '('.result.')'
endfunction

function! SynName()
  return synIDattr(synID(line('.'), col('.'), 0), 'name')
endfunction

function! SynNameStatus()
  let syn_name = SynName()
  if exists('g:syn_name_status') && g:syn_name_status && syn_name != ''
    return ' {'.syn_name.'}'
  else
    return ''
  endif
endfunction

function! CloseQuickFix()
  ccl | lcl
endfunction

function! SwitchPrevBuf()
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
" }}}
" search options {{{2
" always use incremental search
set incsearch
" no search highlighting by default, use <leader>h if needed
set nohlsearch
" case-sensitive search when using camel case search criteria
set smartcase
" }}}
" status line options {{{2
set laststatus=2
set statusline=%m%<%.99f\ %{GetCurDir()}\ %h%w%r%y
" set statusline+=%{fugitive#statusline()}
set statusline+=%{SynNameStatus()}
set statusline+=\ %#errormsg#%{SyntasticStatuslineFlag()}%*
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
au FileType help      setlocal nolist
au FileType qf        setlocal nolist
au FileType gitcommit setlocal nolist
" }}}
" wild options {{{2
set wildmenu
set wildmode=full
set wildignore=*.o,*.bundle,*.png,*.jpg,*.gif,*.class,*.log,tmp/**
set showcmd
" the above doesn't always work. the following enforces it
au VimEnter * set showcmd
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
"}}}
" uncategorized options {{{2
au ColorScheme * hi! link ColorColumn StatusLine
set bg=dark
if has('gui_running')
  colo candycode_mod
else
  colo dante_mod
endif
if exists('&mc')
  au BufNew,BufRead * set mc=81
endif
set scrolloff=5      " keep at least 5 lines above/below
set sidescrolloff=5  " keep at least 5 lines left/right
set autoread         " disable annoying confirmations
set hidden
set title
" set number
if exists("&macmeta")
  set macmeta " on Mac use Option key as Meta
endif
set vb t_vb= " no visual bell or beep, damn it
" that makes it work on Windows too
if has("win32")
  au VimEnter * set vb t_vb=
endif
set path+=*/** " allow :find to search subdirectories
set tags+=../tags,../../tags,../../../tags,../../../../tags,./tmp/tags
set cpoptions+=d
set timeoutlen=1000 " A little bit more time for macros
set ttimeoutlen=100  " Make Esc work faster
" do not search included files, it's a way too slow
set complete-=i
" do not display :intro screen at startup
set shortmess+=I
set nofsync " don't spin my disk
if executable('ack') && !exists('g:ackprg')
  " always use ack for faster searching
  set grepprg=ack\ -a\ --ignore-dir=log\ --ignore-dir=tmp\ $*\\\|grep\ -v\ '^tags'
endif
set completeopt=
set clipboard+=unnamed
let g:filetype_m = 'objc' " always open *.m files with objc filetype
if !has('gui_running') && $TERM_PROGRAM == 'iTerm.app' && has('cursorshape')
  " change the cursor shape based on the current mode
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
au FileType ruby setlocal keywordprg=ri\ -T\ -f\ bs
au FileType ruby setlocal completefunc=syntaxcomplete#Complete
au FileType ruby setlocal balloonexpr&
au FileType scala,ruby exe 'compiler '. expand('<amatch>')
au BufReadPost quickfix nmap <silent> <buffer> q :call CloseQuickFix()<CR>
au FileType xml setlocal foldmethod=syntax
au BufReadPre,BufNewFile *.{iphone,ipad}.erb let b:eruby_subtype = 'html'
autocmd BufReadPost fugitive://* set bufhidden=delete
"}}}

" Section: Keybindings {{{1
" ------------------------------------------------------------------------------
let mapleader = ','
nnoremap <leader>ss :w<CR>
nnoremap <leader>sv :source ~/.vimrc
nnoremap <leader>sg :source ~/.gvimrc
nnoremap \vv :e ~/.vimrc
nnoremap \vg :e ~/.gvimrc

" visual select of the line's content
nnoremap <silent> <leader>v ^v$h
" visual select of the last pasted text
nnoremap <silent> <leader>V `[v`]
nnoremap <silent> <leader>h :set hlsearch!<CR>
nnoremap <silent> <C-l> :noh<CR><C-l>
nnoremap <silent> \l :setlocal list!<CR>
nnoremap <silent> \n :set nu!<CR>
nnoremap <silent> \s :let g:syn_name_status =
      \ exists('g:syn_name_status') ? (g:syn_name_status + 1) % 2 : 1<CR>
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
nnoremap [s [I:let nr = input("Which one: ") <Bar>exe "normal " . nr . "[\t"<CR>
nnoremap <leader>a :let align = input("Align to: ")<Bar>exe ":Tab /" . align<CR>
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap {<Space> {}<Esc>i<Space><Space><Esc>i
inoremap [<Space> []<Esc>i<Space><Space><Esc>i
inoremap <C-\> <C-p>
inoremap <silent> <C-j> <C-\><C-O>:call search('[{("\[\]'')}]', 'Wc', line('.'))<CR><Right>
nnoremap <F2> <C-w><C-w>
nnoremap <F4> :sil make %<CR><c-l>:cc<CR>
nnoremap [f :exe ':Ack ' . expand('<cword>')<CR><CR>
nnoremap ]f :exe ':Ack ' . matchstr(getline('.'), '\%'.virtcol('.').'v\w*')<CR><CR>
nnoremap <silent> <C-tab> :call SwitchPrevBuf()<CR>
nnoremap <silent> <C-^> :call SwitchPrevBuf()<CR>
nnoremap <silent> <C-6> :call SwitchPrevBuf()<CR>
if has('mac')
  nnoremap <silent> <D-[> :bprev<CR>
  nnoremap <silent> <D-]> :bnext<CR>
endif
nnoremap <silent> <leader>rt :!ctags --extra=+f -R *<CR><CR>
cnoremap <M-q> qa!
" this one for xterm
cnoremap q  qa!

" mappings for cscope" {{{2
if has("cscope")
  nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif "}}}

" insert modeline
inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>

" file type bindings {{{2
au FileType coffee nnoremap <buffer> <F3> :CoffeeCompile<CR>
au FileType coffee vnoremap <buffer> <F3> :CoffeeCompile<CR>
au FileType coffee nnoremap <buffer> <F4> :CoffeeRun<CR>
au FileType cucumber nnoremap <buffer> <F4> :!cucumber %<CR>
au FileType cucumber nnoremap <buffer> <F5> ^:exe '!cucumber ' . expand('%') . ':' . search('^\s*Scenario:','bnW')<CR>
au FileType cucumber inoremap <buffer> \| \|<Esc>:Tab /\|<CR>A
au FileType help nnoremap <silent> <buffer> q :bd<CR>
au FileType netrw nnoremap <silent> <buffer> qq :bw<CR>
au FileType vim  nnoremap <silent> <buffer> K :h <c-r>=expand('<cword>')<CR><CR>
au FileType ruby if match(expand('<afile>'), '_spec\.rb$') > 0|nnoremap <buffer> <F4> :!rspec --format doc -c %<CR>|endif
au FileType ruby if match(expand('<afile>'), '_spec\.rb$') > 0|nnoremap <buffer> <F5> :exe '!rspec --format doc -c ' . expand('%') . ':' . line('.')<CR>|else|nnoremap <buffer> <F5> :!ruby %<CR>|endif
au FileType ruby,puppet inoremap <buffer> <expr> <c-l> pumvisible() ? "\<lt>c-l>" : " => "
au FileType php  nnoremap <buffer> <F5> :!php %<CR>
au FileType javascript nnoremap <silent> <buffer> <F4> :!node %<CR>

" Section: Commands && Abbrivations {{{1
" ------------------------------------------------------------------------------
" NOTE: that doesn't work in MacVim gui mode if sudo requests a password!!!
command! -bar -nargs=0 SudoW   :exe "write !sudo tee % >/dev/null"|silent edit!
au FileType ruby iabbrev <buffer> rb! #!<C-R>=substitute(system('which ruby'),'\n$','','')<CR><C-R>=Eatchar('\s')<CR>
" display name of the syntax ID at the cursor
command! SynName :echo SynName()
cabbr vgf noau vimgrep //j<Left><Left><C-R>=Eatchar('\s')<CR>
cabbr ack Ack
iabbr THen Then
iabbr WHen When

" Section: Plugin settings {{{1
" ------------------------------------------------------------------------------
" Tagbar settings  {{{2
let g:tagbar_left      = 1
let g:tagbar_width     = 30
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
nnoremap <silent> \[  :TagbarToggle<CR>

" NERD_tree settings {{{2
let g:NERDTreeQuitOnOpen  = 1 " Close NERDTree when a file is opened
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeIgnore      = ['\.o$', '\~$', '\.class$']
let g:NERDTreeMinimalUI   = 0
let g:NERDTreeDirArrows   = 1
nnoremap <silent> <leader>f  :exec 'NERDTree' . expand('%:p:h')<CR>

" rubycomplete plugin settings {{{2
let g:rubycomplete_buffer_loading    = 1
let g:rubycomplete_rails             = 0
let g:rubycomplete_classes_in_global = 1

" syntastic settings {{{2
" puppet is too slow, html/tidy doesn't support HTML5
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [],
      \ 'passive_filetypes': ['coffee', 'cpp', 'c', 'scss', 'puppet', 'html', 'cucumber'] }
let g:syntastic_auto_loc_list       = 2
let g:syntastic_enable_signs        = 1
let g:syntastic_stl_format          = '[ERR:%F(%t)]'
let g:syntastic_javascript_jsl_conf = "~/.jsl.conf"
let g:syntastic_echo_current_error  = 1

" snipmate settings {{{2
function! MyGetSnips(scopes, word)
  if &ft == 'eruby'
    call add(a:scopes, b:eruby_subtype)
    call add(a:scopes, 'ruby')
  endif
  return snipMate#GetSnippets(a:scopes, a:word)
endfunction
let g:snipMate = {'get_snippets': function('MyGetSnips')}

" a settings {{{2
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,m,mm"
let g:alternateExtensions_m = "h"
let g:alternateExtensions_mm = "h"

" tabular settings {{{2
nnoremap <silent> g= :Tabularize assignment<CR>
vnoremap <silent> g= :Tabularize assignment<CR>

" ctrlp settings {{{2
let g:ctrlp_match_window_reversed=0
let g:ctrlp_dotfiles=0
let g:ctrlp_extensions = ['buffertag', 'quickfix', 'dir', 'rtscript']
nnoremap <silent> <leader>m :CtrlPCurWD<CR>
nnoremap <silent> <leader>l :CtrlPBuffer<CR>
nnoremap <silent> <leader>n :ClearCtrlPCache<CR>

" Misc settings {{{2
let g:dbext_default_history_file = $HOME."/.dbext_history"
let g:CSApprox_verbose_level = 0 " to shut it up
let c_comment_strings = 1 " I like highlighting strings inside C comments
let g:xml_syntax_folding = 1 " enable folding in xml files
let g:syntastic_jsl_conf='~/.jsl.conf'
let g:rgbtxt = expand('~/.vim/bundle/csmm/rgb.txt')
let g:SuperTabDefaultCompletionType= '<C-n>'
let g:blockle_mapping='<leader>bb'

" }}}
