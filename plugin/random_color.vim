function! <SID>RandomCS()
  let my_scripts = split(&runtimepath, ',')[0]
  let random_scheme = []
ruby << EOR
    srand(Time.now.to_i)
    my_scripts = VIM.evaluate("my_scripts")
    schemes = Dir[my_scripts + "/colors/*vim"].map{|f| File.basename(f, '.vim')}
    schemes.delete VIM.evaluate("g:colors_name")
    random_scheme = schemes[rand(schemes.size)]
    VIM.evaluate "add(random_scheme, \"#{random_scheme}\")"
    VIM.command "colorscheme #{random_scheme}"
EOR
  if !exists("g:colors_name")
    let g:colors_name = random_scheme[0]
  endif
  redraw
  echomsg "Color scheme is " . g:colors_name
endfunction

command! RandomCS call <SID>RandomCS()
nnoremap <silent> <leader>rc :RandomCS<CR>
