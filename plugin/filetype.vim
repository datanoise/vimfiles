" Language settings
" ------------------------------------------------------------------------------

augroup CompilerSettings
  au!
  au FileType scala,ruby,go exe 'compiler '. expand('<amatch>')
  au FileType rust compiler cargo
augroup END

augroup NoListSettings
  au!
  au FileType go,godoc,netrw,help,qf,gitcommit,GV setlocal nolist
augroup END

augroup SpellSettings
  au!
  au FileType gitcommit,markdown,mkd,text setlocal spell
augroup END

augroup VimSettings
  au!
  au FileType help nnoremap <silent> <buffer> q :helpclose<CR>
  au FileType qf nmap <silent> <buffer> q :q<CR>
  au FileType fugitive,qf,gitcommit setlocal signcolumn=no
  au FileType help setlocal nospell iskeyword+=_
  au VimResized * wincmd =
augroup END

augroup RubySettings
  au!
  au BufNewFile,BufRead *.prawn set ft=ruby
  au BufNewFile,BufRead *.axlsx set ft=ruby
  au FileType ruby setlocal indentkeys-=. indentkeys-=0{
  au FileType ruby if has('balloonexpr') | setlocal balloonexpr& | endif
  au FileType ruby iabbrev <buffer> rb! #!<C-R>=substitute(system('which ruby'),'\n$','','')<CR><C-R>=Eatchar('\s')<CR>
  au FileType ruby setlocal keywordprg=ri\ -T\ -f\ markdown\ --no-gems
augroup END

augroup GoSettings
  au!
  au FileType go setlocal tabstop=4
  au FileType go setlocal shiftwidth=4
  au FileType go setlocal noexpandtab
  au FileType go nnoremap <silent> <buffer> K :GoDoc<CR>
  au FileType go nnoremap <silent> <buffer> <leader>n :GoDecls<CR>
  au FileType go nnoremap <silent> <buffer> <leader>gn :GoDeclsDir<CR>
  au FileType go
        \ nmap <silent> <buffer> <leader>goi <Plug>(go-import) |
        \ nmap <silent> <buffer> <leader>goI <Plug>(go-imports) |
        \ nmap <silent> <buffer> <leader>god <Plug>(go-def) |
        \ nmap <silent> <buffer> <leader>gok <Plug>(go-doc-tab) |
        \ nmap <silent> <buffer> <leader>gos <Plug>(go-info) |
        \ imap <silent> <buffer> <C-g>i <Esc><Plug>(go-import)a|
        \ call CommandAliasForBuffer('gi', 'GoImport')
  au FileType godoc nnoremap <silent> <buffer> q :bd<CR>
augroup END

augroup MarkdownSettings
  au!
  au FileType markdown command! -nargs=* -complete=file -buffer Preview :exe "sil !markdown " . expand('%') ."| bcat" | :redraw!
  au FileType markdown inoremap <buffer> \| \|<C-o>:Tab /\|<CR><End>
augroup END

augroup CoffeeSettings
  au!
  au FileType coffee nnoremap <buffer> <F3> :CoffeeCompile<CR>
  au FileType coffee vnoremap <buffer> <F3> :CoffeeCompile<CR>
  au FileType coffee nnoremap <buffer> <F4> :CoffeeRun<CR>
  au FileType coffee nnoremap <buffer> <F5> :CoffeeMake<CR><CR>
augroup END

augroup PhpSettings
  au!
  au FileType php  nnoremap <buffer> <F5> :!php %<CR>
augroup END

augroup JavascriptSettings
  au!
  au FileType javascript nnoremap <silent> <buffer> <F4> :!node %<CR>
augroup END

augroup RustSettings
  au!
  au FileType rust nmap <silent> <buffer> gd <Plug>(rust-def)
  au FileType rust nmap <silent> <buffer> K <Plug>(rust-doc)
  au FileType rustdoc nmap <silent> q :q<CR>
  " ignore target directory for cargo projects
  au VimEnter *
        \ if filereadable('Cargo.toml') |
        \   set wildignore+=target |
        \ endif
augroup END

augroup XmlSettings
  au!
  au FileType xml setlocal foldmethod=syntax
augroup END

augroup JsonSettings
  au!
  au FileType json setlocal conceallevel=0
augroup END
