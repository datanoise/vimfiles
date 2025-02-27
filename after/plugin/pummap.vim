" keyword completion on <Tab>
finish

if maparg('<Tab>','i') !=# ''
  exe 'imap <Plug>NoPumTab ' . maparg('<Tab>', 'i')
  exe 'imap <Plug>NoPumSTab ' . maparg('<S-Tab>', 'i')
else
  inoremap <Plug>NoPumTab <Tab>
  inoremap <Plug>NoPumSTab <S-Tab>
end
imap <silent> <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Plug>NoPumTab"
imap <silent> <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<Plug>NoPumSTab"
