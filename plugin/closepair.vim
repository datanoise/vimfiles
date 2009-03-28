" File: closepair.vim
" Author: Michael Sanders (msanders42 [at] gmail [dot] com)
" Description: Automatically inserts closing pairs of (, [, ', etc.
"              TextMate-style when appropriate.)
" TODO: Fix the "." command.

if exists('did_closepair') || &cp || version < 700
	finish
endif
let did_closepair = 1
let s:pairs = {}

" Adds a mapping for the specified characters. To map quotes, give "" for
" closeChar; for a buffer-only mapping, give a non-zero value for the third
" parameter.
fun! AddPair(openChar, closeChar, ...)
	let char = a:closeChar == '' ? a:openChar : a:closeChar
	if a:0 && a:1
		if !exists('b:pairs') | let b:pairs = s:pairs | endif
		let b:pairs[char] = 0 | let buffer = ' <buffer> '
	else
		let s:pairs[char] = 0 | let buffer = ''
	endif

	if a:closeChar == ''
		exe 'ino <silent> '.buffer.a:openChar.' <c-r>=<SID>PairQuote("'.
					\ escape(a:openChar, '"').'")<cr>'
	else
		exe 'ino <silent> '.buffer.a:openChar.' '.a:openChar.'<c-r>=<SID>'.
					\ 'OpenPair("'.a:closeChar.'")<cr>'
		exe 'ino <silent> '.buffer.a:closeChar.' <c-r>=<SID>ClosePair("'.
					\ a:closeChar.'")<cr>'
	endif
endf

" Deletes pair mapped by closepair.vim for the current buffer.
fun! DeletePair(char, ...)
	if !exists('b:pairs') | let b:pairs = s:pairs | endif
	exe 'ino <buffer> '.a:char.' '.a:char
	if has_key(b:pairs, a:char) | unl b:pairs[a:char] | endif
	if a:0
		exe 'ino <buffer> '.a:1.' '.a:1
		if has_key(b:pairs, a:1) | unl b:pairs[a:1] | endif
	endif
endf

call AddPair('(', ')')
call AddPair('[', ']')
call AddPair('{', '}')
call AddPair('"', '')
call AddPair("'", '')
call AddPair('`', '')
ino <silent> <bs> <c-r>=<SID>RemovePair()<cr>
ino <expr> <cr> <SID>OpenBraces()

au FileType vim call DeletePair('"')
au FileType css call AddPair(':', ';', 1)

" Only autocompletes if no characters are in front of the cursor.
fun s:OpenPair(char)
	if strpart(getline('.'), col('.') - 1, 1) !~ '\w'
		call setline('.', substitute(getline('.'), '.\=\%'.col('.').'c', '&'.a:char, ''))
	endif
	return ''
endf

" Allows you to escape out of an autocompletion by simply typing
" the closing pair.
fun s:ClosePair(char)
	if getline('.')[col('.')-1] == a:char
		call setline('.', substitute(getline('.'), '\%'.col('.').'c.', '', ''))
	endif
	return a:char
endf

fun s:InStringOrComment(col)
	return synIDattr(synID(line('.'), a:col, 0), 'name') =~? 'omment\|string'
endf

" Automatically remove the entire autocompletion when the opening character
" is deleted & there are no characters in between.
fun s:RemovePair()
	let col = col('.') - 2
	let chars = strpart(getline('.'), col, 2)
	let pairs = exists('b:pairs') ? b:pairs : s:pairs
	if (chars != "''" || !s:InStringOrComment(col)) && has_key(pairs, chars[1])
		\ && match(maparg(chars[0], 'i'),
				\ '\c<C-R>=<SNR>\d\+_\(OpenPair\|PairQuote\)') != -1
		return "\<del>\<bs>"
	else
		return "\<bs>"
	endif
endf

" Opens a pair of braces correctly when return is pressed afterwards.
fun s:OpenBraces()
	return getline('.')[col('.')-2] == '{' ? "\<cr>\<cr>\<up>\<tab>" : "\<cr>"
endf

fun s:Count(haystack, needle)
    let counter = 0
    let index = stridx(a:haystack, a:needle)
    wh index != -1
        let counter += 1
        let index = stridx(a:haystack, a:needle, index + 1)
    endw
    return counter
endf

" Like OpenPair/ClosePair but for quotes.
fun s:PairQuote(char)
	let col = col('.') - 1 | let line = getline('.')
	let currentChar = line[col] | let prevChar = line[col-1]
	" Treat single quotes inside commands and strings as apostrophes.
	if a:char == "'" && currentChar != "'" && s:InStringOrComment(col)
		return "'"
	endif

	let c = s:Count(line, a:char)
	let in_python = stridx(&ft, 'python') != -1
	if in_python && c && !(c % 3) && currentChar == a:char
		" Escape out of triple-quote Python string.
		return repeat(a:char, 3)
	elseif currentChar =~ '\w' || c % 2
		return a:char " Insert into string or match quote
	elseif currentChar == a:char && (!in_python || prevChar != a:char)
		return s:ClosePair(a:char)
	endif
	return a:char.s:OpenPair(a:char)
endf
" vim:noet:sw=4:ts=4:ft=vim
