" grepper settings
if !has_key(g:plugs, 'vim-grepper')
  finish
endif

let g:grepper = {}
let g:grepper.tools = ['rg', 'ag', 'grep']
nmap <leader>gf <Plug>(GrepperOperator)
xmap <leader>gf <Plug>(GrepperOperator)
nnoremap <leader>* :Grepper-buffer -cword -noprompt<CR>
nnoremap [F :exe ':GrepperRg ' . expand('<cword>')<CR>
nnoremap ]F :exe ':GrepperRg ' . matchstr(getline('.'), '\%'.virtcol('.').'v\w*')<CR>
call CommandAlias('ag', 'GrepperAg')
call CommandAlias('rg', 'GrepperRg')
call CommandAlias('rgr', 'GrepperRg -t ruby')
call CommandAlias('grep', 'GrepperGrep')

