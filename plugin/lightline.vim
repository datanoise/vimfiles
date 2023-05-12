" lightline settings

if !has_key(g:plugs, 'lightline.vim')
  finish
endif

set noshowmode

let s:lsp_info = []
let s:lsp_status = []
let s:ale_status = []

if has_key(g:plugs, 'lightline-ale')
  let g:lightline#ale#indicator_ok = '✓'
  let g:lightline#ale#indicator_checking = '⦿'
endif

let g:lightline = {
      \ 'colorscheme': 'datanoise',
      \ 'enable': {
      \   'statusline': 1,
      \   'tabline': 1,
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'spell'],
      \             [ 'ctrlpmark' ] ],
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'current_tag', 'filetype' ],
      \            ],
      \ },
      \ 'component': {
      \   'lineinfo': '☰ %3l:%-2v',
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'readonly': 'LightlineReadonly',
      \   'ctrlpmark': 'CtrlPMark',
      \   'current_tag': 'TagbarCurrentTag',
      \ },
      \ 'component_expand': {
      \   'gitbranch': 'LightlineFugitive',
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok'
      \ },
      \ 'component_type': {
      \   'linter_checking': 'warning',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \   'gitbranch': 'branch',
      \ },
      \ }

function! LightlineFilename()
  let l:fname = expand('%:t')
  return &filetype ==# 'fzf' ? 'fzf' :
        \ l:fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ l:fname =~# '__Tagbar__' ? g:lightline.fname :
        \ l:fname !=# '' ? s:format_filename() : '[No Name]'
endfunction

function! s:format_filename()
  let l:r = expand('%f')
  let l:pwd = getcwd() . '/'
  if match(l:r, l:pwd) ==# 0
    let l:r = strpart(l:r, strlen(l:pwd))
  endif
  if strlen(l:r) > 80
    let l:r = pathshorten(l:r)
  endif
  return substitute(l:r, '\(.*\)\(.\{50}\)', '<\2', '')
endfunction

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let l:branch = FugitiveHead()
    return l:branch !=# '' ? ' '.l:branch : ''
  endif
  return ''
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let s:tagbar_init = 0
let s:tagbar_last_updated_time = 0
let s:tagbar_last_updated_val = ''
function! TagbarCurrentTag()
  if !s:tagbar_init
    try
      let l:a = tagbar#currenttag('%', '', '')
      unlet l:a
    catch
      " ignore
    endtry
    let s:tagbar_init = 1
  endif
  if s:tagbar_last_updated_time !=# localtime() && exists('*tagbar#currenttag')
    let s:tagbar_last_updated_val = tagbar#currenttag('%s', '', '')
    let s:tagbar_last_updated_time = localtime()
  endif
  return s:tagbar_last_updated_val
endfunction

augroup LightlineFocus
  au!
  au FocusGained *
        \ if exists('*lightline#update') |
        \   call lightline#update() |
        \ endif
augroup END
