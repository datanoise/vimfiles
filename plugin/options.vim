" Options
" ------------------------------------------------------------------------------
" color theme {{{2
augroup ColorSchemeFix
  au!
  au ColorScheme * hi! link ColorColumn StatusLine
augroup END
set background=dark
colo jellybeans
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
if has('win32')
  set backupdir=c:/tmp
  set directory=c:/tmp
else
  set backupdir=/tmp
  set directory=/tmp
endif
if has('nvim')
  set undodir=~/tmp/vimundo/nvim
else
  set undodir=~/tmp/vimundo/vim
end
set undofile
set history=1000
" to avoid error with crontab -e
set backupskip=/tmp/*,/private/tmp/*
" }}}
" search options {{{2
" always use incremental search
set incsearch
" no search highlighting by default
set nohlsearch
" case-sensitive search when using camel case search criteria
set ignorecase
set smartcase
set wrapscan
if has('nvim')
  set inccommand=split
endif
" }}}
" status line options {{{2
set laststatus=2
if has('nvim')
  set laststatus=3
endif
set statusline=%m%<%.99f%q\ %h%w%r%y
set statusline+=%{exists('*CapsLockStatusline')?'\ '.CapsLockStatusline():''}
set statusline+=\ %{GitBranch()}
" set statusline+=\ %#errormsg#%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*
set statusline+=%=
set statusline+=\ %-16(\ %l,%c-%v\ %)%P
" }}}
" cscope settings {{{2
if has('cscope')
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set cscopetag
  set cscopepathcomp=3
  set nocscopeverbose
  " add any database in current directory
  if filereadable('cscope.out')
      cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB !=# ''
      cs add $CSCOPE_DB
  endif
  set cscopeverbose
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
if has('win32')
  set listchars=tab:>-,trail:-
else
  set listchars=tab:»·,trail:·
endif
set listchars+=extends:>,precedes:<
if v:version >= 700
  set listchars+=nbsp:+
endif
if has('nvim')
  set fillchars+=vert:\│,diff:/,fold:\·,eob:\ ,msgsep:‾
else
  set fillchars+=vert:\│
endif
set conceallevel=1
set diffopt=internal,filler,closeoff,context:12,indent-heuristic,linematch:60,algorithm:histogram
" }}}
" wild options {{{2
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*.bundle,*.png,*.jpg,*.gif,*.class,*.log,*.beam,*.a,*.rlib,*.iml
if exists('&wildoptions')
  if has('nvim')
    set wildoptions=pum
  else
    set wildoptions=pum,fuzzy
  endif
endif
set showcmd
" }}}
" mouse options {{{2
set mousehide
" enable mouse in the terminal
set mouse=a
" }}}
" folding options {{{2
if !has('nvim')
  set foldmethod=marker
endif
set foldlevelstart=99
set foldlevel=99 " always expand folds
" }}}
" input method options {{{2
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set spelllang=ru_yo,en_us
"}}}
" uncategorized options {{{2
if has('termguicolors')
  set termguicolors
  if $TERM ==# 'screen-256color'
    exec "set t_8f=\e[38;2;%lu;%lu;%lum"
    exec "set t_8b=\e[48;2;%lu;%lu;%lum"
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
if exists('&macmeta')
  set macmeta " on Mac use Option key as Meta
endif
set belloff=all
set visualbell t_vb= " no visual bell or beep, damn it
" that makes it work on Windows too
if has('win32')
  augroup WinVisualBellFix
    au!
    au VimEnter * set vb t_vb=
  augroup END
endif
if getcwd() != expand('~')
  set path+=*/** " allow :find searching subdirectories
end
set tags+=../tags,../../tags,../../../tags,../../../../tags,./tmp/tags
set cpoptions+=d
set timeoutlen=1000 " A little bit more time for macros
set ttimeoutlen=10  " Make Esc work faster
" if has('nvim')
"   set pumblend=25
" endif
" do not display :intro screen at startup
set shortmess+=I
set nofsync " don't spin my disk
"set autocomplete
set complete=.^5,w^5,b^5,u^5
set completeopt=popup
set clipboard+=unnamed
set signcolumn=yes
if has('nvim')
  set winborder=rounded " use single line border for windows
endif
" remove folds from session because they might be loaded dynamically
" from the lsp server
set sessionoptions-=folds

" for nvim-matchup to avoid statusline flicker
" function MatchupStatusOffscreen() can be called from the statusline
let g:matchup_matchparen_offscreen = {'method': 'status_manual'}

augroup FugitiveAutoCleanup
  au!
  au BufReadPost fugitive://* set bufhidden=delete
  if has('nvim')
    au TermClose term://*:git\ pull checktime
  endif
augroup END

" terminal settings
if has('nvim')
  augroup TermEnter
    au!
    au TermOpen * nnoremap <buffer> <Enter> i
    au TermOpen * setlocal signcolumn=no
  augroup END

  augroup CheckFilesForUpdates
    au!
    au FocusGained * :sil! checktime
  augroup END

  if executable('nvr')
    let $EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  endif
endif
if !has('nvim') && has('cursorshape')
  let &t_SI = "\e[6 q"
  let &t_EI = "\e[2 q"
endif
