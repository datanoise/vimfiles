" ctrlp settings {{{2
if !has_key(g:plugs, 'ctrlp.vim')
  finish
endif

let g:ctrlp_extensions = ['buffertag', 'quickfix', 'dir', 'rtscript',
      \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_mruf_relative = 0
let g:ctrlp_max_files = 10000
let g:ctrlp_open_multi = 'tr'
let g:ctrlp_open_new_file = 'h'
let g:ctrlp_mruf_exclude = '\.git\|\/var\/folders\|' . substitute($VIMRUNTIME, '/', '\\/', 'g')
let g:ctrlp_buftag_types = {
      \ 'go'     : '--language-force=Go --Go-types=fvt',
      \ 'scala'  : '--language-force=scala --scala-types=ctTm',
      \ 'coffee' : '--language-force=coffee --coffee-types=m',
      \ 'elixir' : '--language-force=elixir --elixir-types=facdmpr',
      \ 'crystal': '--language-force=crystal --crystal-types=f'
      \  }
if executable('crystal-tags')
  cal extend(g:ctrlp_buftag_types, { 'crystal': { 'args': '-f - -N --fields nK', 'bin': 'crystal-tags' } })
en
if executable('ag') && !exists('&macmeta')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let s:ignored = ['.git', '.hg', '.svn', '.gif', '.jpg', '.jpeg', '.png']
  let s:ignored_pattern = join(map(s:ignored, '"\\" . v:val . "$\\|"'), '')
  " let g:ctrlp_user_command =
  "       \ 'ag %s --files-with-matches -g "" --nocolor --ignore "' . s:ignored_pattern . '"'
  let g:ctrlp_user_command =
        \ 'rg %s --files -m 1000 -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" nnoremap <silent> <leader>m :CtrlPCurWD<CR>
" nnoremap <silent> <leader>l :CtrlPBuffer<CR>
" nnoremap <silent> <leader>r :CtrlPRoot<CR>
" nnoremap <silent> <leader>x :CtrlPMixed<CR>
nnoremap <silent> <leader>ke :CtrlPMRUFiles<CR>
nnoremap <silent> <leader>kn :CtrlPBufTag<CR>
nnoremap <silent> <leader>kf :CtrlPCurFile<CR>
nnoremap <silent> <leader>kb :CtrlPBuffer<CR>
nnoremap <silent> <leader>kt :CtrlPTabbed<CR>
nnoremap <silent> <leader>kq :CtrlPQuickfix<CR>
nnoremap <silent> <leader>kd :CtrlPDir<CR>
nnoremap <silent> <leader>kR :CtrlPRTS<CR>
nnoremap <silent> <leader>ku :CtrlPUndo<CR>
nnoremap <silent> <leader>kl :CtrlPLine<CR>
nnoremap <silent> <leader>kc :CtrlPChange<CR>
nnoremap <silent> <leader>kx :CtrlPBookmarkDir<CR>
nnoremap <silent> <leader>kg :CtrlPTag<CR>
nnoremap <silent> <leader>kh :CtrlPCmdHistory<CR>
nnoremap <silent> <leader>ks :CtrlPSearchHistory<CR>
nnoremap <silent> <leader>kr :CtrlPRegister<CR>
nnoremap <silent> <leader>km :CtrlPMark<CR>

nnoremap <silent> <leader>ky :CtrlPFunky<CR>
let g:ctrlp_funky_syntax_highlight = 1
