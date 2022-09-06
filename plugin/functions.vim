" Functions
" ------------------------------------------------------------------------------
function! s:switch_prev_buf()
  let l:prev = bufname('#')
  if l:prev !=# '__InputList__' && bufloaded(l:prev) != 0
    b#
  else
    " echo "No buffer to switch to"
    Buffers
  endif
endfunction

function! Eatchar(pat)
   let l:c = nr2char(getchar(0))
   return (l:c =~ a:pat) ? '' : l:c
endfunction

function! s:vset_search()
  let l:tmp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = l:tmp
endfunction

function! s:filter_quickfix(bang, pattern)
  let l:cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . l:cmp . ' a:pattern'))
endfunction

function! GitBranch()
  if exists('*fugitive#statusline')
    let l:branch = fugitive#statusline()
    return substitute(l:branch, 'Git(\(.*\))', '\1', '')
  endif
endfunction

function! s:tagComplete()
  let l:line = getline('.')
  let l:col = col('.')

  if !has_key(g:plugs, 'vim-ragtag')
    return '>'

  elseif l:line[l:col-2] ==# '>' && l:line[l:col-1] ==# '<'
    call feedkeys("\<C-g>u") " create new undo sequence
    call feedkeys("\<CR>\<ESC>O", 'n')
    return ''

  elseif search('</\@!', 'bn', line('.')) != 0
        \ && searchpair('</\@!', '', '>', 'bW') > 0
        \ && l:line[l:col-2] !=# '/'
        \ && l:line[l:col-2] !=# '='
    call feedkeys("\<C-g>u") " create new undo sequence
    call feedkeys('></', 'n')
    call feedkeys("\<Plug>ragtagHtmlComplete")
    call feedkeys("\<ESC>F<i", 'n')
    return ''

  else
    return '>'
  endif
endfunction

function! s:enableTagComplete()
  let b:delimitMate_matchpairs = '(:),[:],{:}'
  imap <silent> <buffer> <expr> > <SID>tagComplete()
endfunction

function! s:command_alias(input, output, buf_only)
  if a:buf_only
    let l:buffer = ' <buffer> '
  else
    let l:buffer = ' '
  endif
  exec 'cabbrev <expr>'.l:buffer.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction

function! CommandAlias(input, output)
  call s:command_alias(a:input, a:output, 0)
endfunction

function! CommandAliasForBuffer(input, output)
  call s:command_alias(a:input, a:output, 1)
endfunction

function! s:complete_brackets()
  let l:line = getline('.')
  let l:c = l:line[col('.')-2]
  let l:x = l:line[col('.')-1]
  if l:c =~# '[{\[\(]' && match(l:line, '[}\]\)]', col('.')) == -1
    if l:c ==# '['
      let l:b = ']'
    elseif l:c ==# '('
      let l:b = ')'
    elseif l:c ==# '{'
      let l:b = '}'
    else
      return "\<CR>"
    endif
    if l:x ==# l:b
      let l:b = ''
    endif
    return "\<CR>".l:b."\<C-O>O"
  else
    return "\<CR>"
  endif
endfunction

function! Wildmenumode()
  if match(&wildoptions, 'pum') != -1
    return pumvisible()
  else
    return wildmenumode()
  endif
endfunction
