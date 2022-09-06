" Functions
" ------------------------------------------------------------------------------
function! s:switch_prev_buf()
  let l:prev = bufname('#')
  if l:prev !=# '__InputList__' && bufloaded(l:prev) != 0
    b#
  else
    " echo "No buffer to switch to"
    Buffers
  endif
endfunction

function! Eatchar(pat)
   let l:c = nr2char(getchar(0))
   return (l:c =~ a:pat) ? '' : l:c
endfunction

function! s:vset_search()
  let l:tmp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = l:tmp
endfunction

function! s:filter_quickfix(bang, pattern)
  let l:cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . l:cmp . ' a:pattern'))
endfunction

function! GitBranch()
  if exists('*fugitive#statusline')
    let l:branch = fugitive#statusline()
    return substitute(l:branch, 'Git(\(.*\))', '\1', '')
  endif
endfunction

function! s:tagComplete()
  let l:line = getline('.')
  let l:col = col('.')

  if !has_key(g:plugs, 'vim-ragtag')
    return '>'

  elseif l:line[l:col-2] ==# '>' && l:line[l:col-1] ==# '<'
    call feedkeys("\<C-g>u") " create new undo sequence
    call feedkeys("\<CR>\<ESC>O", 'n')
    return ''

  elseif search('</\@!', 'bn', line('.')) != 0
        \ && searchpair('</\@!', '', '>', 'bW') > 0
        \ && l:line[l:col-2] !=# '/'
        \ && l:line[l:col-2] !=# '='
    call feedkeys("\<C-g>u") " create new undo sequence
    call feedkeys('></', 'n')
    call feedkeys("\<Plug>ragtagHtmlComplete")
    call feedkeys("\<ESC>F<i", 'n')
    return ''

  else
    return '>'
  endif
endfunction

function! s:enableTagComplete()
  let b:delimitMate_matchpairs = '(:),[:],{:}'
  imap <silent> <buffer> <expr> > <SID>tagComplete()
endfunction

function! s:command_alias(input, output, buf_only)
  if a:buf_only
    let l:buffer = ' <buffer> '
  else
    let l:buffer = ' '
  endif
  exec 'cabbrev <expr>'.l:buffer.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction

function! CommandAlias(input, output)
  call s:command_alias(a:input, a:output, 0)
endfunction

function! CommandAliasForBuffer(input, output)
  call s:command_alias(a:input, a:output, 1)
endfunction

function! s:complete_brackets()
  let l:line = getline('.')
  let l:c = l:line[col('.')-2]
  let l:x = l:line[col('.')-1]
  if l:c =~# '[{\[\(]' && match(l:line, '[}\]\)]', col('.')) == -1
    if l:c ==# '['
      let l:b = ']'
    elseif l:c ==# '('
      let l:b = ')'
    elseif l:c ==# '{'
      let l:b = '}'
    else
      return "\<CR>"
    endif
    if l:x ==# l:b
      let l:b = ''
    endif
    return "\<CR>".l:b."\<C-O>O"
  else
    return "\<CR>"
  endif
endfunction

function! Wildmenumode()
  if match(&wildoptions, 'pum') != -1
    return pumvisible()
  else
    return wildmenumode()
  endif
endfunction

" Keybindings
" ------------------------------------------------------------------------------
let g:mapleader = ','
nnoremap <leader>sv :source ~/.vimrc
nnoremap <leader>sg :source ~/.gvimrc
nnoremap \vv :e ~/.vimrc
nnoremap \vg :e ~/.gvimrc

" visual select of the last pasted text
nnoremap <silent> <leader>v `[v`]
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
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
if has('nvim')
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
  tnoremap <M-[> <C-\><C-n>
endif
nnoremap <F4> :sil make %<CR><C-l>:cr<CR>
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
nnoremap <silent> <leader>gc :Git<CR>
" nnoremap <silent> <leader>gh :split<Bar>:terminal git push<CR>
" nnoremap <silent> <leader>gl :split<Bar>:terminal git pull<CR>
nnoremap <silent> <leader>gh :Git push<CR>
nnoremap <silent> <leader>gl :Git pull<CR>
au FileType fugitive nnoremap <buffer> <silent> q :<C-U>if bufnr('$') == 1<Bar>quit<Bar>else<Bar>bdelete<Bar>endif<CR>
" quick search in visual mode
xnoremap <silent> * :<C-u>call <SID>vset_search()<CR>/<C-R>=@/<CR><CR>
xnoremap <silent> # :<C-u>call <SID>vset_search()<CR>?<C-R>=@/<CR><CR>

" some handful command-mode bindings
cmap <silent> <c-x><c-p> <Plug>CmdlineCompleteBackward
cmap <silent> <c-x><c-n> <Plug>CmdlineCompleteForward
cnoremap <M-q> qa!
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h'). '/' : '%%'
" better <Tab> handling in wild menu mode
set wildcharm=<C-Z>
cnoremap <expr> <Tab> Wildmenumode() ? "\<Right>" : "\<C-Z>"
" abbreviations
cabbr vgf noau vimgrep //j<Left><Left><C-R>=Eatchar('\s')<CR>
call CommandAlias('pu', 'PlugUpdate')
call CommandAlias('pi', 'PlugInstall')
call CommandAlias('gv', 'GV')

augroup CmdwinBindings
  au!
  au CmdwinEnter * nmap <buffer> <leader>q :q<CR>
  au CmdwinEnter * nmap <buffer> q :q<CR>
augroup END

