" splitjoin settings
if !has_key(g:plugs, 'splitjoin.vim')
  finish
endif

nnoremap <silent> <leader>sp :SplitjoinSplit<CR>
nnoremap <silent> <leader>sj :SplitjoinJoin<CR>

