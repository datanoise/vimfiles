" supertab settings
if !has_key(g:plugs, 'supertab')
  finish
endif

let g:SuperTabCrMapping = 0
augroup SuperTabSettings
  au!
  " au FileType go call SuperTabSetDefaultCompletionType("<c-x><c-o>")
  au FileType go,rust call SuperTabSetDefaultCompletionType("context")
augroup END

