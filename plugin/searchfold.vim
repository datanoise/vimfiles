" searchfold settings
if has('nvim')
  finish
endif

if !has_key(g:plugs, 'searchfold')
  finish
endif

nmap <Leader>z <Plug>SearchFoldNormal
