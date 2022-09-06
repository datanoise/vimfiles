if !has_key(g:plugs, 'accelerated-jk')
  finish
endif

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
