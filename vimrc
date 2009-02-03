" -*- vim -*- vim:set ft=vim et sw=2 sts=4:

" Section: Global Setting {{{1
" ----------------------------------------
runtime! macros/matchit.vim
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


" Section: Options {{{1
" --------------------------------------------------
" tab options {{{2
set tabstop=8
set shiftwidth=2
set softtabstop=4
set smartindent
set smarttab
set expandtab " }}}
" backup options {{{2
set nobackup
if has("win32")
  set backupdir=c:/tmp
  set directory=c:/tmp
else
  set backupdir=/tmp
  set directory=/tmp
endif " }}}
" search options {{{2
set incsearch
set nohlsearch
set smartcase " case-sensitive search when using camel case search criteria
set ignorecase " }}}
" status line options {{{2
set laststatus=2
function! GetColorSchemeIdicator()
  if exists("g:colors_name")
    return '[cs:'.g:colors_name.']'
  else
    return ""
  endif
endfunction
function! GetCurDir()
  let result = substitute(getcwd(), '^'.$HOME, '~', '')
  let result = substitute(result, '^.\+\ze.\{30,}', '<', '')
  return '('.result.')'
endfunction
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{GetColorSchemeIdicator()}%{GetCurDir()}%=%-16(\ %l,%c-%v\ %)%P
set statusline=[%n]%m\ %<%.99f\ %{GetCurDir()}\ %h%w%r%y%=%-16(\ %l,%c-%v\ %)%P " }}}
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
  " NOTE: patched VIM version required
  set breakindent
endif
" }}}
" invisible chars display options {{{2
set list
au FileType help                setlocal nolist
au FileType otl                 setlocal nolist
if has("win32")
  set listchars=tab:>-,trail:-
else
  set listchars=tab:»·,trail:·
endif
set listchars+=extends:>,precedes:<
if version >= 700
  set listchars+=nbsp:+
endif  " }}}
" wild options {{{2
set wildmenu
set wildmode=full
set wildignore=*.o,*.bundle
set showcmd
" the above doesn't always work. the below enforces it
au VimEnter *                   set showcmd
" }}}
" mouse options {{{2
set mousehide
set mouse=a " }}}
" keymap options {{{2
set keymap=russian-jcuken
set iminsert=0
set imsearch=-1
" NOTE: patched VIM version required
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set langmap+=Ж:
set langmap+=Б<
set langmap+=Ю>
set langmap+=[~
" }}}
set bg=dark
colo candycode_mod
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set autoread
set hidden
set title
if exists("&macmeta")
  set macmeta " on Mac use Option key as Meta
endif
set foldmethod=marker
set vb t_vb= " no visual bell or beep, damn it
" that makes it work on Windows too
if has("win32")
  au VimEnter * set vb t_vb=
endif
set tags+=../tags,../../tags,../../../tags,../../../../tags,./tmp/tags
set cpoptions+=d
set timeoutlen=3000 " A little bit more time for macros
set ttimeoutlen=100  " Make Esc work faster
" do not search included files, it's a way too slow
set complete-=i
" do not display :into screen at startup
set shortmess+=I
set grepprg=ack\ -a\ --ignore-dir=log\ --ignore-dir=tmp\ $*\\\|grep\ -v\ '^tags'
set completeopt=longest,menu,preview " don't hide completion menu when typing
set clipboard+=unnamed
au FileType ruby setlocal keywordprg=ri\ -T\ -f\ bs



" Section: Keybindings {{{1
"--------------------------------------------------
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
nmap ,sv :source ~/.vimrc
nmap ,sg :source ~/.gvimrc
nmap ,vv :e ~/.vimrc
nmap ,vg :e ~/.gvimrc
function! SwitchPrevBuf()
  if bufloaded(bufname("#")) != 0
    exec "b#"
  else
    echo "No buffer to switch to"
  endif
endfunction
nmap <silent> <C-tab> :call SwitchPrevBuf()<cr>
map <silent> <leader>br :FuzzyFinderTextMate<CR>
map <silent> <leader>bR :FuzzyFinderTextMateClear<CR>
map <silent> <leader>bb :FuzzyFinderBuffer<CR>
map <silent> <leader>bf :FuzzyFinderFile<CR>
map <silent> <leader>bd :FuzzyFinderDir<CR>
map <silent> <leader>bt :FuzzyFinderTag<CR>
map <silent> <leader>bl :FuzzyFinderMruFile<CR>
map <silent> <leader>bc :FuzzyFinderMruCmd<CR>
map <silent> <leader>[  :TlistOpen<CR>
map <silent> <leader>v  :TlistOpen<CR>
map <silent> <leader>o  :exec 'NERDTree' . expand('%:p:h')<CR>
map <silent> <leader>d  :NERDTree<CR>
nnoremap <silent> <leader>rc :RandomCS<CR>
map <silent> <F3> :cn<CR>
map <silent> <S-F3> :cp<CR>
map <silent> <D-]> :cn<CR>
map <silent> <D-[> :cp<CR>
imap <silent> <M-Enter> <C-O>A<Enter>
nnoremap <leader>ss :%s/^\s\+$//<CR>
nnoremap <leader>sa :%s/\s\+$//<CR>
" insert modeline
inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>
nnoremap <C-J> <C-D>
nnoremap <C-K> <C-U>
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>
nnoremap <silent> <leader>h :set hlsearch!<CR>
nnoremap <silent> <leader>l :setlocal list!<CR>
nnoremap <silent> <leader>n :set nu!<CR>
" indented paste
nnoremap <silent> <leader>p p'[v']=
nnoremap <silent> <leader>P P'[v']=
nnoremap Y y$
nnoremap z- 1z=
nnoremap [l [I:let nr = input("Which one: ") <Bar>exe "normal " . nr . "[\t"<CR>
nnoremap <F2> <C-w><C-w>
au FileType help nnoremap <buffer> q :bd<CR>
au FileType html nmap <silent> <D-r> :sil !open %<cr>



" Section: Commands && Abbrivations {{{1
" --------------------------------------------------
func! Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc
cabbr vgf noau vimgrep //j<Left><Left><C-R>=Eatchar('\s')<CR>
" NOTE: that doesn't work in MacVim gui mode if sudo requests a password!!!
command! -bar -nargs=0 SudoW   :exe "write !sudo tee % >/dev/null"|silent edit!
au FileType ruby iabbrev rb! #!<esc>:r !which ruby<cr>kgJo<C-W><C-R>=Eatchar('\s')<cr>

" Section: Plugin settings {{{1
" --------------------------------------------------
let c_comment_strings = 1 " I like highlighting strings inside C comments

let Tlist_Close_On_Select = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Show_One_File = 1
let TList_Auto_Update = 0 " Don't autoupdate tags, I use 'u' command for that

let g:proj_flags = "imstc"
let g:dbext_default_history_file = $HOME."/.dbext_history"
let g:DrChipTopLvlMenu = "Plugin."

" NERD_tree settings
let NERDTreeQuitOnOpen = 1 " Close NERDTree when a file is opened
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeMapActivateNode = '<Enter>'

" NERD_commenter settings
let g:NERDShutUp = 1
let NERDSpaceDelims=1 " Add an extra space to comment delimiters

let g:fuzzy_ignore = "*.png;*.jpg;*.gif;tmp/**"

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1

let g:CSApprox_verbose_level = 0 " to shut it up
