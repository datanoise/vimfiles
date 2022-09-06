" airline settings
if !has_key(g:plugs, 'vim-airline')
  finish
endif

set noshowmode
let g:airline_theme = 'datanoise'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_detect_iminsert=1
nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9

