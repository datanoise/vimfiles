" ultisnips settings
if !has_key(g:plugs, 'ultisnips')
  finish
endif

let g:UltiSnipsExpandTrigger='<C-u>'
" let g:UltiSnipsJumpForwardTrigger='<C-k>'
imap <Tab> <C-R>=(pumvisible() ? "\<lt>Tab>" : UltiSnips#JumpForwards())<CR>
let g:UltiSnipsJumpBackwardTrigger='<C-b>'
let g:UltiSnipsRemoveSelectModeMappings = 0

