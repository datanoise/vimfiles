let g:airline#themes#datanoise#palette = {}

let s:guibg = '#202020'
let s:guisep = '#404040'
let s:termbg = 234
let s:termsep = 234

let s:N1 = [ '#00dfff' , s:guibg , 45  , s:termbg ]
let s:N2 = [ '#ff5f00' , s:guibg , 202 , s:termbg ]
" let s:N3 = [ '#767676' , s:guibg , 7   , s:termbg ]
let s:N3 = [ '#999999' , s:guibg , 7   , s:termbg ]

let g:airline#themes#datanoise#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#datanoise#palette.normal_modified = {
      \ 'airline_c': [ '#df0000' , s:guibg, 160     , s:termbg    , ''     ] ,
      \ }

let s:I1 = [ '#5fff00' , s:guibg , 82  , s:termbg ]
let s:I2 = [ '#ff5f00' , s:guibg , 202 , s:termbg ]
let s:I3 = [ '#767676' , s:guibg , 7   , s:termbg ]
let g:airline#themes#datanoise#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#datanoise#palette.insert_modified = copy(g:airline#themes#datanoise#palette.normal_modified)
let g:airline#themes#datanoise#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
      \ }

let g:airline#themes#datanoise#palette.replace = {
      \ 'airline_a': [ s:I1[0]   , '#af0000' , s:I1[2] , 124     , ''     ] ,
      \ }
let g:airline#themes#datanoise#palette.replace_modified = copy(g:airline#themes#datanoise#palette.normal_modified)

let s:V1 = [ '#dfdf00' , s:guibg , 184 , s:termbg ]
let s:V2 = [ '#ff5f00' , s:guibg , 202 , s:termbg ]
let s:V3 = [ '#767676' , s:guibg , 7   , s:termbg ]
let g:airline#themes#datanoise#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#datanoise#palette.visual_modified = copy(g:airline#themes#datanoise#palette.normal_modified)

let s:IA1 = [ '#999999' , '#1c1c1c' , 239 , 234 , '' ]
let s:IA2 = [ '#999999' , '#262626' , 239 , 235 , '' ]
let s:IA3 = [ '#999999' , '#303030' , 239 , 236 , '' ]
let g:airline#themes#datanoise#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#datanoise#palette.inactive_modified = {
      \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
      \ }

if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#datanoise#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#999999' , s:guibg , 253 , s:termbg  , ''     ] ,
      \ [ '#999999' , s:guibg , 253 , s:termbg  , ''     ] ,
      \ [ '#00dfff' , s:guibg , 253 , s:termbg  , 'bold' ] )
