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

