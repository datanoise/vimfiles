" <CR> must cancel pum when pressed
" imap <Plug>NoPumCR <Plug>delimitMateCR<Plug>DiscretionaryEnd
" imap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<Plug>NoPumCR"

" keyword completion on <Tab>
exe "imap <Plug>NoPumTab " . maparg('<Tab>', 'i')
imap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Plug>NoPumTab"
