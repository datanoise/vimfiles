" -*- vim -*- vim:set ft=vim et sw=2 sts=4:

" Section: Global Setting {{{1
" ----------------------------------------
runtime! macros/matchit.vim
set nocompatible      " We're running Vim, not Vi!
call pathogen#runtime_append_all_bundles()
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Section: Options {{{1
" --------------------------------------------------
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
function! GetCurDir()
  let result = substitute(getcwd(), '^'.$HOME, '~', '')
  let result = substitute(result, '^.\+\ze.\{30,}', '<', '')
  return '('.result.')'
endfunction
set statusline=[%n]%m\ %<%.99f\ %{GetCurDir()}\ %h%w%r%y%=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
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
au FileType help  setlocal nolist
au FileType otl   setlocal nolist
" }}}

" wild options {{{2
set wildmenu
set wildmode=full
set wildignore=*.o,*.bundle,*.png,*.jpg,*.gif,*.class
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

" uncategorized options {{{2
set bg=dark
" colo candycode_mod
colo ir_black_mod
if exists('&mc')
  au BufNew,BufRead * set mc=81
endif
set scrolloff=5      " keep at least 5 lines above/below
set sidescrolloff=5  " keep at least 5 lines left/right
set autoread         " disable annoying confirmations
set hidden
set title
" set colorcolumn=80
" au FileType help setlocal cc=0
" set number
if exists("&macmeta")
  set macmeta " on Mac use Option key as Meta
endif
set vb t_vb= " no visual bell or beep, damn it
" that makes it work on Windows too
if has("win32")
  au VimEnter * set vb t_vb=
endif
set tags+=../tags,../../tags,../../../tags,../../../../tags,./tmp/tags
set cpoptions+=d
set timeoutlen=1000 " A little bit more time for macros
set ttimeoutlen=100  " Make Esc work faster
" do not search included files, it's a way too slow
set complete-=i
" do not display :into screen at startup
set shortmess+=I
set nofsync " don't spin my disk
if executable('ack')
  " always use ack for faster searching
  set grepprg=ack\ -a\ --ignore-dir=log\ --ignore-dir=tmp\ $*\\\|grep\ -v\ '^tags'
endif
set completeopt=longest,menu " don't hide completion menu when typing
" set clipboard+=unnamed
au FileType ruby setlocal keywordprg=ri\ -T\ -f\ bs
au FileType ruby setlocal completefunc=syntaxcomplete#Complete
au FileType scala,ruby exe 'compiler '. expand('<amatch>')
" save undo point when leaving vim window
au CursorHoldI * call feedkeys("\<C-G>u", "nt")
"}}}


" Section: Keybindings {{{1
"--------------------------------------------------
let mapleader = ','
" mappings for cscope
if has("cscope")
  nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

nnoremap <leader>ss :w<CR>
nnoremap <leader>sv :source ~/.vimrc
nnoremap <leader>sg :source ~/.gvimrc
nnoremap <leader>vv :e ~/.vimrc
nnoremap <leader>vg :e ~/.gvimrc

nnoremap <silent> \[  :TlistOpen<CR>
nnoremap <silent> <leader>n  :CommandT<CR>
nnoremap <silent> <leader>l  :CommandTBuffer<CR>
nnoremap <silent> \f  :exec 'NERDTree' . expand('%:p:h')<CR>
" visual select of the last pasted text
nnoremap <silent> \v `[v`]
" visual select of the line's content
nnoremap <silent> <leader>V ^v$h
nnoremap <silent> \h :set hlsearch!<CR>
nnoremap <silent> \l :setlocal list!<CR>
nnoremap <silent> \n :set nu!<CR>
" indented paste
nnoremap <silent> <leader>p p:'[,']normal ==<CR>
nnoremap <silent> <leader>P P:'[,']normal ==<CR>
nnoremap <silent> gp "*p
nnoremap <silent> gP "*P
vnoremap <silent> gy "*y
vnoremap <silent> gY "*Y
nnoremap <silent> gYY "*YY
nnoremap <silent> <leader>sd mx:%s/\s\+$//<CR>`x
nnoremap <silent> g= :Tabularize assignment<CR>

nnoremap <silent> <F3> :cn<CR>
nnoremap <silent> <S-F3> :cp<CR>
nnoremap <silent> <leader>] :cn<CR>
nnoremap <silent> <leader>[ :cp<CR>
nnoremap <C-J> <C-D>
nnoremap <C-K> <C-U>
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>
nnoremap <silent> <leader>o A<CR>
nnoremap Y y$
nnoremap z- 1z=
nnoremap L :
nnoremap [l [I:let nr = input("Which one: ") <Bar>exe "normal " . nr . "[\t"<CR>
nnoremap <F2> <C-w><C-w>
nnoremap <F4> :sil make %<CR><c-l>:cc<CR>
function! SwitchPrevBuf()
  if bufloaded(bufname("#")) != 0
    exec "b#"
  else
    echo "No buffer to switch to"
  endif
endfunction
nnoremap <silent> <C-tab> :call SwitchPrevBuf()<CR>
nnoremap <silent> <C-^> :call SwitchPrevBuf()<CR>
nnoremap <silent> <leader>rt :!ctags --extra=+f -R *<CR><CR>
nnoremap <silent> <leader>rh :call pathogen#helptags()<CR>:echo 'Generated help tags'<CR>
cnoremap <M-q> qa!
" this one for xterm
cnoremap q  qa!

" insert modeline
inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>
" keyword completion on <TAB>
function MyTabOrCompletion()
  let col = col('.')-1
  if pumvisible() || col && getline('.')[col-1] =~ '\k'
    return "\<C-N>"
  else
    return "\<tab>"
  endif
endfunction
inoremap <silent> <tab> <c-r>=MyTabOrCompletion()<CR>
inoremap <c-_> <c-^>


au FileType help nnoremap <buffer> q :bd<CR>
au FileType vim  nnoremap <buffer> K :h <c-r>=expand('<cword>')<CR><CR>
au FileType ruby inoremap <buffer> <c-l> <c-r>= pumvisible() ? "\<lt>c-l>" : " => "<CR>
au FileType ruby nnoremap <buffer> <F5> :!ruby %<CR>
au FileType php nnoremap <buffer> <F5> :!php %<CR>
au FileType php,c,cpp,java,javascript,html,eruby,css,scala inoremap <buffer> {<CR> {<CR>}<Esc>O
au FileType xml setlocal foldmethod=syntax
au BufReadPre,BufNewFile *.iphone.erb let b:eruby_subtype = 'html'
if has("mac")
  au FileType html nnoremap <silent> <D-r> :sil !open %<CR>
endif

" Section: Commands && Abbrivations {{{1
" --------------------------------------------------
func! Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc
cabbr vgf noau vimgrep //j<Left><Left><C-R>=Eatchar('\s')<CR>
" NOTE: that doesn't work in MacVim gui mode if sudo requests a password!!!
command! -bar -nargs=0 SudoW   :exe "write !sudo tee % >/dev/null"|silent edit!
au FileType ruby iabbrev rb! #!<Esc>:r !which ruby<CR>kgJo<C-W><C-R>=Eatchar('\s')<CR>
" display name of the syntax ID at the cursor
func! SynName()
  echo synIDattr(synID(line('.'), col('.'), 0), 'name')
endfunc
command! SynName :call SynName()


" Section: Plugin settings {{{1
" --------------------------------------------------
" TagList settings
let Tlist_Close_On_Select = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Show_One_File = 1
let TList_Auto_Update = 0 " Don't autoupdate tags, I use 'u' command for that
let Tlist_Inc_Winwidth = 0 " Don't resize my window!

" NERD_tree settings
let NERDTreeQuitOnOpen = 1 " Close NERDTree when a file is opened
let g:NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.o$', '\~$', '\.class$']

" Rubycomplete plugin settings
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1

" xptemplate settings
let g:xptemplate_key = '<Tab>'
au User BufEnterRails call g:XPTaddBundle('ruby', 'rails')
au User BufEnterRails call g:XPTaddBundle('eruby', 'rails')
let g:xptemplate_highlight = 'following,next'
let g:xptemplate_pum_tab_nav = 1
" let g:xptemplate_brace_complete = 1
hi link XPTnextItem CursorLine

" command-t settings
let g:CommandTMatchWindowReverse=1
let g:CommandTCancelMap=['<C-c>', '<Esc>']
let g:CommandTMaxHeight=10
if !has('gui_running')
  " fix for arrow keys in console mode
  let g:CommandTSelectNextMap=['<Esc>OB', '<C-n>']
  let g:CommandTSelectPrevMap=['<Esc>OA', '<C-p>']
end

" syntastic settings
let g:syntastic_disabled_filetypes = ['coffee', 'cpp', 'c']
let g:syntastic_auto_loc_list=2

" Misc settings
let g:dbext_default_history_file = $HOME."/.dbext_history"
let g:CSApprox_verbose_level = 0 " to shut it up
let c_comment_strings = 1 " I like highlighting strings inside C comments
let g:xml_syntax_folding = 1
let g:syntastic_jsl_conf='~/.jsl.conf'
