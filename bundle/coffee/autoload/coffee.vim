" Language:    CoffeeScript
" Maintainer:  Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

" Set up some common global/buffer variables.
function! coffee#CoffeeSetUpVariables()
  " Path to coffee compiler (used by CoffeeMake and CoffeeCompile)
  if !exists('g:coffee_compiler')
    let g:coffee_compiler = 'coffee'
  endif

  " Extra options passed to CoffeeMake
  if !exists('g:coffee_make_options')
    let g:coffee_make_options = ''
  endif

  " Path to coffeelint executable (used by CoffeeLint)
  if !exists('g:coffee_linter')
    let g:coffee_linter = 'coffeelint'
  endif

  " Options passed to CoffeeLint
  if !exists('g:coffee_lint_options')
    let g:coffee_lint_options = ''
  endif

  " Pass the litcoffee flag to tools in this buffer if a litcoffee file is open.
  if !exists('b:coffee_litcoffee')
    if &filetype == 'litcoffee'
      let b:coffee_litcoffee = '--literate'
    else
      let b:coffee_litcoffee = ''
    endif
  endif
endfunction
