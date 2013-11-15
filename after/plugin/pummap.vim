" keyword completion on <Tab>
if maparg('<Tab>','i') != ''
  exe "imap <Plug>NoPumTab " . maparg('<Tab>', 'i')
else
  inoremap <Plug>NoPumTab <Tab>
end
imap <expr> <Tab> pumvisible() ? "\<C-P>" : "\<Plug>NoPumTab"
