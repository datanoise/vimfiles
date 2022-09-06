" searchfold settings
if !has_key(g:plugs, 'searchfold')
  finish
endif

nmap <Leader>z <Plug>SearchFoldNormal

