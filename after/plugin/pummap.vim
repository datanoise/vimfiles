" <CR> must cancel pum when pressed
exe "imap <Plug>OldCR <Plug>delimitMateCR<Plug>DiscretionaryEnd"
imap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<Plug>OldCR"

" keyword completion on <Tab>
exe "imap <Plug>OldTab " . maparg('<Tab>', 'i')
imap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Plug>OldTab"
