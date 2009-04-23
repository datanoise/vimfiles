" These are the mappings for snipMate.vim. Putting it here ensures that it
" will be mapped after other plugins such as supertab.vim.
if exists('s:did_snips_mappings') || &cp || version < 700
	finish
endif
let s:did_snips_mappings = 1

ino <silent> <s-tab> <c-r>= TriggerSnippet()<cr>
ino <silent> <c-b> <c-r>= TriggerSnippet()<cr>
snor <silent> <s-tab> <esc>i<right><c-r>=TriggerSnippet()<cr>
snor <silent> <c-b> <esc>i<right><c-r>=TriggerSnippet()<cr>
snor <bs> b<bs>
snor ' b<bs>'
snor <right> <esc>a
snor <left> <esc>bi

" By default load snippets in snippets_dir
if empty(snippets_dir) || !isdirectory(snippets_dir)
	finish
endif

call GetSnippets(snippets_dir, '_') " Get global snippets 

au FileType * if &ft != 'help' | call GetSnippets(snippets_dir, &ft) | endif
au FileType eruby call SnipUseFiletype(snippets_dir, &ft, 'html', 'ruby')
au FileType xhtml call SnipUseFiletype(snippets_dir, &ft, 'html')
au FileType objc,cpp,cs call SnipUseFiletype(snippets_dir, &ft, 'c')
" vim:noet:sw=4:ts=4:ft=vim
