" -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdc=3:

" Section: Global Setting {{{1
" ------------------------------------------------------------------------------
runtime! macros/matchit.vim
set nocompatible      " We're running Vim, not Vi!
let g:pathogen_disabled = ['bundler']
if $GOPATH == ""
  call add(g:pathogen_disabled, "go")
endif
if !has('python')
  call add(g:pathogen_disabled, "ultisnips")
endif
if $TERM != "" && $TERM != 'xterm-256color' && $TERM != 'screen-256color'
  call add(g:pathogen_disabled, 'airline')
endif
call pathogen#infect('bundle/{}')
call pathogen#helptags()
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
"
" Section: Functions {{{1
" ------------------------------------------------------------------------------
function! GetCurDir()
  let result = substitute(getcwd(), '^'.$HOME, '~', '')
  let result = substitute(result, '^.\+\ze.\{20,}', '<', '')
  return result
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

function! s:close_quick_fix()
  ccl | lcl
endfunction

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

function! s:alt_char(c)
  if a:c == '{'
    return '}'
  elseif a:c == '['
    return ']'
  elseif a:c == '('
    return ')'
  endif
endfunction

function! s:space_inside_curly()
  let l = getline('.')
  let c = col('.')
  if l[c-2] =~ '[{([]' && l[c-1] == s:alt_char(l[c-2])
    return "\<Space>\<Space>\<Left>"
  endif
  return "\<Space>"
endfunction

function! s:VSetSearch()
  let tmp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = tmp
endfunction

function! s:FilterQuickfixList(bang, pattern)
  let cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . cmp . " a:pattern"))
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
set statusline=%m%<%.99f\ (%{GetCurDir()})\ %h%w%r%y
set statusline+=\ %{fugitive#statusline()}
set statusline+=%{SynNameStatus()}
" set statusline+=\ %#errormsg#%{SyntasticStatuslineFlag()}%*
set statusline+=%=
set statusline+=\ %-16(\ %l,%c-%v\ %)%P
set statusline^=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
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
set fillchars=vert:\ 
au FileType help      setlocal nolist
au FileType qf        setlocal nolist
au FileType gitcommit setlocal nolist
" }}}
" wild options {{{2
set wildmenu
set wildmode=full
set wildignore=*.o,*.bundle,*.png,*.jpg,*.gif,*.class,*.log,*.beam,*.a,*.rlib
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
" set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
"}}}
" uncategorized options {{{2
au ColorScheme * hi! link ColorColumn StatusLine
set bg=dark
set noshowmode
colo dante_mod_snap
" colo solarized
if exists('&mc')
  au BufNew,BufRead * set mc=81
endif
set scrolloff=5      " keep at least 5 lines above/below
set sidescrolloff=5  " keep at least 5 lines left/right
set autoread         " disable annoying confirmations
set hidden
set lazyredraw
set title
set backspace=indent,eol,start
" set number
if exists("&macmeta")
  set macmeta " on Mac use Option key as Meta
endif
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
if executable('ack') && !exists('g:ackprg')
  " always use ack for faster searching
  set grepprg=ack\ -a\ --ignore-dir=log\ --ignore-dir=tmp\ $*\\\|grep\ -v\ '^tags'
endif
set completeopt=menu,longest
set clipboard+=unnamed
let g:filetype_m = 'objc' " always open *.m files with objc filetype
" change the cursor shape based on the current mode
if !has('gui_running') && $TERM_PROGRAM == 'iTerm.app' && has('cursorshape')
  " if exists('$TMUX')
  "   let &t_SI = "\<Esc>[3 q"
  "   let &t_EI = "\<Esc>[0 q"
  " else
  "   let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  "   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  " endif
endif
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
" go settings
au FileType go setlocal tabstop=4
au FileType go setlocal shiftwidth=4
au FileType go setlocal nolist
au FileType go setlocal noexpandtab
" ignore target directory for cargo projects
au VimEnter *
      \ if filereadable('Cargo.toml') |
      \   set wildignore+=target |
      \ endif

au BufReadPost quickfix nmap <silent> <buffer> q :call <SID>close_quick_fix()<CR>
au BufReadPre,BufNewFile *.{iphone,ipad}.erb let b:eruby_subtype = 'html'
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
nnoremap <silent> <leader>q :Bclose<CR>
au CmdwinEnter * nmap <buffer> <leader>q :q<CR>
au CmdwinEnter * nmap <buffer> q :q<CR>
nnoremap <silent> <leader>Q :bd<CR>
nnoremap [s [I:let nr = input("Which one: ") <Bar>exe "normal " . nr . "[\t"<CR>
nnoremap <leader>a :let align = input("Align to: ")<Bar>exe ":Tab /" . align<CR>
" inoremap {<CR> {<CR>}<Esc>O
" inoremap [<CR> [<CR>]<Esc>O
" inoremap {<Space> {}<Esc>i<Space><Space><Esc>i
" inoremap [<Space> []<Esc>i<Space><Space><Esc>i
inoremap <silent> <Space> <C-R>=<SID>space_inside_curly()<CR>
" inoremap <Tab> <C-p>
inoremap <silent> <C-l> <C-\><C-O>:call search('[{("\[\]'')}]', 'Wc', line('.'))<CR><Right>
inoremap jj <Esc>
" imap kk <C-O>A<Enter>
nnoremap <F2> <C-w><C-w>
inoremap <F2> <Esc><C-w><C-w>
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
cnoremap <M-q> qa!
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h'). '/' : '%%'
" this one for xterm
cnoremap q  qa!
" insert modeline
inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>
" fugitive commands
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gh :Git push<CR>
nnoremap <silent> <leader>gl :Git pull<CR>
" quick search in visual mode
xnoremap <silent> * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap <silent> # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
" split join mappings
nnoremap <silent> <leader>ss :SplitjoinSplit<CR>
nnoremap <silent> <leader>sj :SplitjoinJoin<CR>
nnoremap <silent> <leader>sc :SyntasticCheck<CR>


" file type bindings {{{2
au FileType coffee nnoremap <buffer> <F3> :CoffeeCompile<CR>
au FileType coffee vnoremap <buffer> <F3> :CoffeeCompile<CR>
au FileType coffee nnoremap <buffer> <F4> :CoffeeRun<CR>
au FileType coffee nnoremap <buffer> <F5> :CoffeeMake<CR><CR>
au FileType cucumber nnoremap <buffer> <F4> :!cucumber %<CR>
au FileType cucumber nnoremap <buffer> <F5> ^:exe '!cucumber ' . expand('%') . ':' . search('^\s*Scenario:','bnW')<CR>
au FileType cucumber inoremap <buffer> \| \|<Esc>:Tab /\|<CR>A
au FileType help,godoc nnoremap <silent> <buffer> q :bd<CR>
au FileType netrw nnoremap <silent> <buffer> qq :bw<CR>
au FileType vim  nnoremap <silent> <buffer> K :h <c-r>=expand('<cword>')<CR><CR>
au FileType go  nnoremap <silent> <buffer> K :GoDoc<CR>
au FileType ruby if match(expand('<afile>'), '_spec\.rb$') > 0|nnoremap <buffer> <F4> :!rspec --format doc -c %<CR>|endif
au FileType ruby if match(expand('<afile>'), '_spec\.rb$') > 0|nnoremap <buffer> <F5> :exe '!rspec --format doc -c ' . expand('%') . ':' . line('.')<CR>|else|nnoremap <buffer> <F5> :!ruby %<CR>|endif
au FileType ruby,puppet inoremap <buffer> <expr> <c-l> pumvisible() ? "\<lt>c-l>" : " => "
au FileType php  nnoremap <buffer> <F5> :!php %<CR>
au FileType javascript nnoremap <silent> <buffer> <F4> :!node %<CR>
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


" Section: Commands && Abbrivations {{{1
" ------------------------------------------------------------------------------
" NOTE: that doesn't work in MacVim gui mode if sudo requests a password!!!
command! -bar -nargs=0 SudoW   :exe "write !sudo tee % >/dev/null"|silent edit!
au FileType ruby iabbrev <buffer> rb! #!<C-R>=substitute(system('which ruby'),'\n$','','')<CR><C-R>=Eatchar('\s')<CR>
" display name of the syntax ID at the cursor
command! SynName :echo SynName()
command! -bang -nargs=1 -complete=file QFilter call s:FilterQuickfixList(<bang>0, <q-args>)
cabbr vgf noau vimgrep //j<Left><Left><C-R>=Eatchar('\s')<CR>
cabbr ack Ack
cabbr ag Ag
iabbr THen Then
iabbr WHen When
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
nnoremap <silent> \[  :TagbarToggle<CR>
" if executable('coffeetags')
"   let g:tagbar_type_coffee = {
"         \ 'ctagsbin' : 'coffeetags',
"         \ 'ctagsargs' : '',
"         \ 'kinds' : [
"           \ 'f:functions',
"           \ 'o:object',
"         \ ],
"         \ 'sro' : ".",
"         \ 'kind2scope' : {
"           \ 'f' : 'object',
"           \ 'o' : 'object',
"         \ }
"   \ }
" endif
let g:tagbar_type_coffee = {
      \ 'ctagstype' : 'coffee',
      \ 'kinds' : [
        \ 'm:functions',
        \ 'c:object',
      \ ],
      \ 'sro' : ".",
      \ 'kind2scope' : {
        \ 'm' : 'object',
        \ 'c' : 'object',
      \ }
\ }
if executable('gotags')
  let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
          \ 'p:package',
          \ 'i:imports:1',
          \ 'c:constants',
          \ 'v:variables',
          \ 't:types',
          \ 'n:interfaces',
          \ 'w:fields',
          \ 'e:embedded',
          \ 'm:methods',
          \ 'r:constructor',
          \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
          \ 't' : 'ctype',
          \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
          \ 'ctype' : 't',
          \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
  \ }
endif
if executable('crystal-tags')
  let g:tagbar_type_crystal = {
      \ 'ctagstype' : 'crystal',
      \ 'kinds'     : [
          \ 's:struct',
          \ 'c:class',
          \ 'm:module',
          \ 'f:method',
          \ 'l:library',
          \ 't:type'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
          \ 'c' : 'class',
          \ 'm' : 'module',
          \ 's' : 'struct',
          \ 'l' : 'library'
      \ },
      \ 'scope2kind' : {
          \ 'class' : 'c',
          \ 'module' : 'm',
          \ 'library': 'l'
      \ },
      \ 'ctagsbin'  : 'crystal-tags',
      \ 'ctagsargs' : '-f -'
  \ }
endif
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ],
    \ 'sro' : ".",
    \ 'kind2scope' : {
        \ 'T' : 'type',
        \ 't' : 'trait',
        \ 'o' : 'object',
        \ 'a' : 'abstract class',
        \ 'c' : 'class',
        \ 'r' : 'case class'
    \ },
    \ 'scope2kind' : {
        \ 'type' : 'T',
        \ 'trait' : 't',
        \ 'object' : 'o',
        \ 'abstract class' : 'a',
        \ 'class' : 'c',
        \ 'case class' : 'r'
    \ },
\ }

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
let g:syntastic_mode_map = { 'mode': 'active',
      \  'active_filetypes':  [],
      \  'passive_filetypes': ['cpp', 'c', 'scss', 'puppet', 'html', 'cucumber', 'java']
      \  }
let g:syntastic_auto_loc_list       = 2
let g:syntastic_enable_signs        = 1
let g:syntastic_stl_format          = '[ERR:%F(%t)]'
let g:syntastic_javascript_jsl_conf = "~/.jsl.conf"
let g:syntastic_echo_current_error  = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_coffee_lint_options = '-f ~/.coffeelint.json'
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_go_checkers = ["gofmt"]
let g:syntastic_enable_elixir_checker = 1
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
" let g:ctrlp_custom_ignore = 'tmp'
let g:ctrlp_buftag_types = {
      \ 'go'     : '--language-force=Go --Go-types=fvt',
      \ 'rust'   : '--language-force=Rust --Rust-types=fti',
      \ 'scala'  : '--language-force=scala --scala-types=ctTm'
      \  }

nnoremap <silent> <leader>m :CtrlPCurWD<CR>
nnoremap <silent> <leader>r :CtrlPRoot<CR>
nnoremap <silent> <leader>l :CtrlPBuffer<CR>
nnoremap <silent> <leader>t :CtrlPBufTag<CR>
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

" smartinput settings {{{2
if exists('g:loaded_smartinput')
  call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
  call smartinput#define_rule({
  \   'at': '\({\|\<do\>\)\s*\%#',
  \   'char': '<Bar>',
  \   'input': '<Bar><Bar><Left>',
  \   'filetype': ['ruby'],
  \ })
endif

" supertab settings {{{2
let g:SuperTabCrMapping = 0
" au FileType go call SuperTabSetDefaultCompletionType("<c-x><c-o>")
au FileType go call SuperTabSetDefaultCompletionType("context")

" ultisnips settings {{{2
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
" let g:UltiSnipsJumpForwardTrigger="<tab>"

" go settings {{{2
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_auto_type_info = 0
let g:go_snippet_engine = ''

" airline settings {{{2
let g:airline_theme='serene'
let g:airline#extensions#whitespace#enabled=0
" let g:airline#extensions#tagbar#enabled=0

" Misc settings {{{2
let g:dbext_default_history_file = $HOME."/.dbext_history"
let g:CSApprox_verbose_level = 0 " to shut it up
let c_comment_strings = 1 " I like highlighting strings inside C comments
let g:xml_syntax_folding = 1 " enable folding in xml files
let g:rgbtxt = expand('~/.vim/bundle/csmm/rgb.txt')
let $RUBYOPT = '' " I don't want any surprises like 'noexec' gem
let g:netrw_liststyle = 3
let g:racer_cmd = 'racer'

" }}}
