" playground settings
if !has_key(g:plugs, 'playground')
  finish
endif

nnoremap <silent> zB :TSPlaygroundToggle<CR>
nnoremap <silent> zT :TSCaptureUnderCursor<CR>
