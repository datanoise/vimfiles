" Vim indent file
" Language: Elixir
" Maintainer: Carlos Galdino <carloshsgaldino@gmail.com>
" Last Change: 2013 Apr 24

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

setlocal indentexpr=GetElixirIndent()
setlocal indentkeys+=0=end,0=else,0=match,0=elsif,0=catch,0=after,0=rescue
setlocal indentkeys+=0},0),0],0=\|>,->

if exists("*GetElixirIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:skip_syntax  = '\%(Comment\|String\)$'
let s:block_skip   = "synIDattr(synID(line('.'),col('.'),1),'name') =~? '" . s:skip_syntax . "'"
let s:block_start  = 'do\|fn'
let s:block_middle = 'else\|match\|elsif\|catch\|after\|rescue'
let s:block_end    = 'end'
let s:symbols_end  = '\]\|}'
let s:arrow        = '\s*->$'

let s:indent_keywords   = '\<:\@<!\%(' . s:block_start . '\|' . s:block_middle . '\)$' . '\|=\s*$'
let s:deindent_keywords = '^\s*\<\%(' . s:block_end . '\|' . s:block_middle . '\)\>'

let s:partial_indent = ',\s*$\|||\s*$\|&&\s*$'

function! GetElixirIndent()
  let lnum = prevnonblank(v:lnum - 1)
  let ind  = indent(lnum)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  if synIDattr(synID(v:lnum, 1, 1), "name") !~ s:skip_syntax
    let current_line = getline(v:lnum)
    let last_line = getline(lnum)

    let splited_line = split(last_line, '\zs')
    let opened_symbol = 0
    let opened_symbol += count(splited_line, '[') - count(splited_line, ']')
    let opened_symbol += count(splited_line, '{') - count(splited_line, '}')

    let ind += opened_symbol * &sw

    if last_line =~ '^\s*\(' . s:symbols_end . '\)'
      let ind += &sw
    endif

    if current_line =~ '^\s*\(' . s:symbols_end . '\)'
      let ind -= &sw
    endif

    if last_line =~ s:indent_keywords
      let ind += &sw
    endif
    if last_line =~ s:partial_indent

      let pre_last_line = getline(prevnonblank(lnum-1))
      if pre_last_line !~ s:partial_indent
        if last_line =~ '^\s*with\>'
          return ind + 5
        endif
        return ind
      endif

      if current_line =~ '^\s*\(do\|else\):'
        let with_line =  search('^\s*with\>', 'bnW')
        if with_line > 0
          return indent(with_line) + &sw
        endif
      endif

    endif

    if current_line =~ s:deindent_keywords
      let bslnum = searchpair( '\<:\@<!\%(' . s:block_start . '\):\@!\>',
            \ '\<\%(' . s:block_middle . '\):\@!\>\zs',
            \ '\<:\@<!' . s:block_end . '\>\zs',
            \ 'nbW',
            \ s:block_skip )

      return indent(bslnum)
    endif
    "
    " indent case/cond statements '->'
    if current_line =~ s:arrow && current_line !~ '\<fn\>'
      let bline = search('^\s*\<\(cond\|case\)\>', 'bnW')
      if bline > 0
        return indent(bline) + &sw
      end
    elseif last_line =~ s:arrow " && last_line !~ '\<fn\>'
      return ind + &sw
    endif
  endif

  return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
