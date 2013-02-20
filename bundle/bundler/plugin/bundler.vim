" bundler.vim - Support for Ruby's Bundler
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.1

if exists('g:loaded_bundler') || &cp || v:version < 700
  finish
endif
let g:loaded_bundler = 1

" Utility {{{1

function! s:function(name) abort
  return function(substitute(a:name,'^s:',matchstr(expand('<sfile>'), '<SNR>\d\+_'),''))
endfunction

function! s:sub(str,pat,rep) abort
  return substitute(a:str,'\v\C'.a:pat,a:rep,'')
endfunction

function! s:gsub(str,pat,rep) abort
  return substitute(a:str,'\v\C'.a:pat,a:rep,'g')
endfunction

function! s:shellesc(arg) abort
  if a:arg =~ '^[A-Za-z0-9_/.-]\+$'
    return a:arg
  else
    return shellescape(a:arg)
  endif
endfunction

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

function! s:shellslash(path)
  if exists('+shellslash') && !&shellslash
    return s:gsub(a:path,'\\','/')
  else
    return a:path
  endif
endfunction

function! s:completion_filter(results,A)
  let results = sort(copy(a:results))
  call filter(results,'v:val !~# "\\~$"')
  let filtered = filter(copy(results),'v:val[0:strlen(a:A)-1] ==# a:A')
  if !empty(filtered) | return filtered | endif
  let regex = s:gsub(a:A,'[^/:]','[&].*')
  let filtered = filter(copy(results),'v:val =~# "^".regex')
  if !empty(filtered) | return filtered | endif
  let filtered = filter(copy(results),'"/".v:val =~# "[/:]".regex')
  if !empty(filtered) | return filtered | endif
  let regex = s:gsub(a:A,'.','[&].*')
  let filtered = filter(copy(results),'"/".v:val =~# regex')
  return filtered
endfunction

function! s:throw(string) abort
  let v:errmsg = 'bundler: '.a:string
  throw v:errmsg
endfunction

function! s:warn(str)
  echohl WarningMsg
  echomsg a:str
  echohl None
  let v:warningmsg = a:str
endfunction

function! s:add_methods(namespace, method_names) abort
  for name in a:method_names
    let s:{a:namespace}_prototype[name] = s:function('s:'.a:namespace.'_'.name)
  endfor
endfunction

let s:commands = []
function! s:command(definition) abort
  let s:commands += [a:definition]
endfunction

function! s:define_commands()
  for command in s:commands
    exe 'command! -buffer '.command
  endfor
endfunction

augroup bundler_utility
  autocmd!
  autocmd User Bundler call s:define_commands()
augroup END

let s:abstract_prototype = {}

" }}}1
" Syntax highlighting {{{1

function! s:syntaxfile()
  syntax keyword rubyGemfileMethod gemspec gem source path git group platforms env ruby
  hi def link rubyGemfileMethod Function
endfunction

function! s:syntaxlock()
  syn match gemfilelockHeading  '^[[:upper:]]\+$'
  syn match gemfilelockKey      '^\s\+\zs\S\+:'he=e-1 skipwhite nextgroup=gemfilelockUrl,gemfilelockRevision
  syn match gemfilelockRevision '[[:alnum:]._-]\+$' contained
  syn match gemfilelockUrl      '\w\+\%(://\|@\)\S\+' contained
  syn match gemfilelockGem      '^\s\+\zs[[:alnum:]._-]\+\%([ !]\|$\)\@=' skipwhite nextgroup=gemfilelockVersions,gemfilelockBang
  syn match gemfilelockVersions '([^()]*)' contained contains=gemfilelockVersion
  syn match gemfilelockVersion  '[^,()]*' contained
  syn match gemfilelockBang     '!' contained

  hi def link gemfilelockHeading  PreProc
  hi def link gemfilelockKey      Identifier
  hi def link gemfilelockRevision Number
  hi def link gemfilelockUrl      String
  hi def link gemfilelockGem      Statement
  hi def link gemfilelockVersion  Type
  hi def link gemfilelockBang     Special
endfunction

function! s:setuplock()
  nnoremap <silent><buffer> gf         :Bopen    <C-R><C-F><CR>
  nnoremap <silent><buffer> <C-W>f     :Bsplit   <C-R><C-F><CR>
  nnoremap <silent><buffer> <C-W><C-F> :Bsplit   <C-R><C-F><CR>
  nnoremap <silent><buffer> <C-W>gf    :Btabedit <C-R><C-F><CR>
endfunction

augroup bundler_syntax
  autocmd!
  autocmd BufNewFile,BufReadPost */.bundle/config set filetype=yaml
  autocmd BufNewFile,BufReadPost Gemfile set filetype=ruby
  autocmd Syntax ruby if expand('<afile>:t') ==? 'gemfile' | call s:syntaxfile() | endif
  autocmd BufNewFile,BufRead [Gg]emfile.lock setf gemfilelock
  autocmd FileType gemfilelock set suffixesadd=.rb
  autocmd Syntax gemfilelock call s:syntaxlock()
  autocmd FileType gemfilelock    call s:setuplock()
  autocmd User Rails/Gemfile.lock call s:setuplock()
augroup END

" }}}1
" Initialization {{{1

function! s:FindBundlerRoot(path) abort
  let path = s:shellslash(a:path)
  let fn = fnamemodify(path,':s?[\/]$??')
  let ofn = ""
  let nfn = fn
  while fn != ofn
    if filereadable(fn.'/Gemfile')
      return s:sub(simplify(fnamemodify(fn,':p')),'[\\/]$','')
    endif
    let ofn = fn
    let fn = fnamemodify(ofn,':h')
  endwhile
  return ''
endfunction

function! s:Detect(path)
  if !exists('b:bundler_root')
    let dir = s:FindBundlerRoot(a:path)
    if dir != ''
      let b:bundler_root = dir
    endif
  endif
  if exists('b:bundler_root')
    silent doautocmd User Bundler
  endif
endfunction

augroup bundler
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:Detect(expand('<amatch>:p'))
  autocmd FileType           netrw call s:Detect(expand('<afile>:p'))
  autocmd VimEnter * if expand('<amatch>')==''|call s:Detect(getcwd())|endif
augroup END

" }}}1
" Project {{{1

let s:project_prototype = {}
let s:projects = {}

function! bundler#project(...) abort
  let dir = a:0 ? a:1 : (exists('b:bundler_root') && b:bundler_root !=# '' ? b:bundler_root : s:FindBundlerRoot(expand('%:p')))
  if dir !=# ''
    if has_key(s:projects,dir)
      let project = get(s:projects,dir)
    else
      let project = {'root': dir}
      let s:projects[dir] = project
    endif
    return extend(extend(project,s:project_prototype,'keep'),s:abstract_prototype,'keep')
  endif
  return {}
endfunction

function! s:project(...) abort
  let project = a:0 ? bundler#project(a:1) : bundler#project()
  if empty(project)
    call s:throw('not a Bundler project: '.(a:0 ? a:1 : expand('%')))
  else
    return project
  endif
endfunction

function! s:project_path(...) dict abort
  return join([self.root]+a:000,'/')
endfunction

call s:add_methods('project',['path'])

function! s:project_gems(...) dict abort
  let lock_file = self.path('Gemfile.lock')
  let time = getftime(lock_file)
  if a:0 && a:1 ==# 'refresh' || time != -1 && time != get(self,'_lock_time',-1)
    " Explicitly setting $PATH means /etc/zshenv on OS X can't touch it.
    if executable('env')
      let prefix = 'env PATH='.s:shellesc($PATH).' '
    else
      let prefix = ''
    endif

    let self._gems = {}

    let chdir = exists("*haslocaldir") && haslocaldir() ? "lchdir" : "chdir"
    let cwd = getcwd()
    try
      exe chdir s:fnameescape(self.path())
      let gem_paths = split($GEM_PATH ==# '' ? system(prefix.'ruby -rubygems -e "print Gem.path.join(%(;))"') : $GEM_PATH, '[:;]')
    finally
      exe chdir s:fnameescape(cwd)
    endtry
    if filereadable(self.path('.bundle/config'))
      let body = join(readfile(self.path('.bundle/config')), "\n")
      let bundle_path = matchstr(body, "\\CBUNDLE_PATH: \\zs[^\n]*")
      if !empty(bundle_path)
        let gem_paths = [self.path(bundle_path, 'ruby', matchstr(get(gem_paths, 0, '1.9.1'), '[0-9.]\+$'))]
      endif
    endif

    let gems = self._gems
    let lines = readfile(lock_file)
    let section = ''
    let name = ''
    let ver = ''
    let repo = ''
    let revision = ''
    let local = ''
    let failed = []
    for line in lines
      if line =~# '^\S'
        let section = line
        let name = ''
        let ver = ''
        let repo = ''
        let revision = ''
        let local = ''
      elseif section ==# 'GIT' && line =~# '^  remote: '
        let repo = matchstr(line, '.*/\zs.\{-\}\ze\%(\.git\)\=$')
      elseif section ==# 'GIT' && line =~# '^  revision: '
        let revision = matchstr(line, ': \zs.\{12\}')
      elseif section ==# 'PATH' && line =~# '^  remote: '
        let local = matchstr(line, ': \zs.*')
        if local !~# '^/'
          let local = simplify(self.path(local))
        endif
      endif
      if line !~# '^    [a-zA-Z0-9_-]\+\s\+(\d\+'
        continue
      endif
      let name = split(line, ' ')[0]
      let ver = substitute(line, '.*(\|).*', '', 'g')

      if !empty(local)
        let files = split(glob(local . '/*/' . name . '.gemspec'), "\n")
        if empty(files)
          let gems[name] = local
        else
          let gems[name] = files[0][0 : -10-strlen(name)]
        endif

      elseif !empty(repo)
        for path in gem_paths
          let dir = path . '/bundler/gems/' . repo . '-' . revision
          if isdirectory(dir)
            let files = split(glob(dir . '/*/' . name . '.gemspec'), "\n")
            if empty(files)
              let gems[name] = dir
            else
              let gems[name] = files[0][0 : -10-strlen(name)]
            endif
            break
          endif
        endfor

      else
        for path in gem_paths
          let dir = path . '/gems/' . name . '-' . ver
          if isdirectory(dir)
            let gems[name] = dir
            break
          endif
        endfor
      endif

      if !has_key(gems, name)
        let failed += [name]
      endif
    endfor
    if !exists('g:bundler_strict') || !empty(gems) && empty(failed)
      let self._lock_time = time
      call self.alter_buffer_paths()
      return gems
    endif

    if &verbose
      let label = empty(gems) ? 'any gems' : len(failed) == 1 ? 'gem ' : 'gems '
      unsilent echomsg "Couldn't find ".label.string(failed)[1:-2].". Falling back to Ruby."
    endif

    try
      exe chdir s:fnameescape(self.path())
      let output = system(prefix.'ruby -rubygems -e "require %{bundler}; Bundler.load.specs.map {|s| puts %[#{s.name} #{s.full_gem_path}]}"')
    finally
      exe chdir s:fnameescape(cwd)
    endtry
    if v:shell_error
      for line in split(output,"\n")
        if line !~ '^\t'
          call s:warn(line)
        endif
      endfor
    else
      let self._gems = {}
      for line in split(output,"\n")
        let self._gems[split(line,' ')[0]] = matchstr(line,' \zs.*')
      endfor
      let self._lock_time = time
      call self.alter_buffer_paths()
    endif
  endif
  return get(self,'_gems',{})
endfunction

call s:add_methods('project',['gems'])

" }}}1
" Buffer {{{1

let s:buffer_prototype = {}

function! s:buffer(...) abort
  let buffer = {'#': bufnr(a:0 ? a:1 : '%')}
  call extend(extend(buffer,s:buffer_prototype,'keep'),s:abstract_prototype,'keep')
  if buffer.getvar('bundler_root') !=# ''
    return buffer
  endif
  call s:throw('not a Bundler project: '.(a:0 ? a:1 : expand('%')))
endfunction

function! bundler#buffer(...) abort
  return s:buffer(a:0 ? a:1 : '%')
endfunction

function! s:buffer_getvar(var) dict abort
  return getbufvar(self['#'],a:var)
endfunction

function! s:buffer_setvar(var,value) dict abort
  return setbufvar(self['#'],a:var,a:value)
endfunction

function! s:buffer_project() dict abort
  return s:project(self.getvar('bundler_root'))
endfunction

call s:add_methods('buffer',['getvar','setvar','project'])

" }}}1
" Bundle {{{1

let s:errorformat = ''
      \.'%+E%f:%l:\ parse\ error,'
      \.'%W%f:%l:\ warning:\ %m,'
      \.'%E%f:%l:in\ %*[^:]:\ %m,'
      \.'%E%f:%l:\ %m,'
      \.'%-C%\tfrom\ %f:%l:in\ %.%#,'
      \.'%-Z%\tfrom\ %f:%l,'
      \.'%-Z%p^,'
      \.'%-G%.%#'

function! s:push_chdir()
  if !exists("s:command_stack") | let s:command_stack = [] | endif
  let chdir = exists("*haslocaldir") && haslocaldir() ? "lchdir " : "chdir "
  call add(s:command_stack,chdir.s:fnameescape(getcwd()))
  exe chdir.'`=s:project().path()`'
endfunction

function! s:pop_command()
  if exists("s:command_stack") && len(s:command_stack) > 0
    exe remove(s:command_stack,-1)
  endif
endfunction

function! s:Bundle(bang,arg)
  let old_makeprg = &l:makeprg
  let old_errorformat = &l:errorformat
  try
    let &l:makeprg = 'bundle'
    let &l:errorformat = s:errorformat
    execute 'make! '.a:arg
    if a:bang ==# ''
      return 'if !empty(getqflist()) | cfirst | endif'
    else
      return ''
    endif
  finally
    let &l:errorformat = old_errorformat
    let &l:makeprg = old_makeprg
  endtry
endfunction

function! s:BundleComplete(A,L,P)
  if a:L =~# '^\S\+\s\+\%(show\|update\) '
    return s:completion_filter(keys(s:project().gems()),a:A)
  endif
  return s:completion_filter(['install','update','exec','package','config','check','list','show','outdated','console','viz','benchmark'],a:A)
endfunction

function! s:SetupMake() abort
  setlocal makeprg=bundle
  let &l:errorformat = s:errorformat
endfunction

call s:command("-bar -bang -nargs=? -complete=customlist,s:BundleComplete Bundle :execute s:Bundle('<bang>',<q-args>)")

augroup bundler_make
  autocmd FileType gemfilelock call s:SetupMake()
  autocmd FileType ruby
        \ if expand('<afile>:t') ==? 'gemfile' |
        \   call s:SetupMake() |
        \ endif
  autocmd QuickFixCmdPre *make*
        \ if &makeprg =~# '^bundle' && exists('b:bundler_root') |
        \   call s:push_chdir() |
        \ endif
  autocmd QuickFixCmdPost *make*
        \ if &makeprg =~# '^bundle' && exists('b:bundler_root') |
        \   call s:pop_command() |
        \   execute 'call s:project().gems(exists("g:bundler_strict") ? "" : "refresh")' |
        \ endif
augroup END

" }}}1
" Bopen {{{1

function! s:Open(cmd,gem,lcd)
  if a:gem ==# '' && a:lcd
    return a:cmd.' `=bundler#buffer().project().path("Gemfile")`'
  elseif a:gem ==# ''
    return a:cmd.' `=bundler#buffer().project().path("Gemfile.lock")`'
  else
    if !has_key(s:project().gems(), a:gem)
      call s:project().gems('refresh')
    endif
    if !has_key(s:project().gems(), a:gem)
      let v:errmsg = "Can't find gem \"".a:gem."\" in bundle"
      return 'echoerr v:errmsg'
    endif
    let path = fnameescape(bundler#buffer().project().gems()[a:gem])
    let exec = a:cmd.' '.path
    if a:cmd =~# '^pedit' && a:lcd
      let exec .= '|wincmd P|lcd '.path.'|wincmd p'
    elseif a:lcd
      let exec .= '|lcd '.path
    endif
    return exec
  endif
endfunction

function! s:OpenComplete(A,L,P)
  return s:completion_filter(keys(s:project().gems()),a:A)
endfunction

call s:command("-bar -bang -nargs=? -complete=customlist,s:OpenComplete Bopen :execute s:Open('edit<bang>',<q-args>,1)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:OpenComplete Bedit :execute s:Open('edit<bang>',<q-args>,0)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:OpenComplete Bsplit :execute s:Open('split',<q-args>,<bang>1)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:OpenComplete Bvsplit :execute s:Open('vsplit',<q-args>,<bang>1)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:OpenComplete Btabedit :execute s:Open('tabedit',<q-args>,<bang>1)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:OpenComplete Bpedit :execute s:Open('pedit',<q-args>,<bang>1)")

" }}}1
" Paths {{{1

function! s:build_path_option(paths,suffix) abort
  return join(map(copy(a:paths),'",".escape(s:shellslash(v:val."/".a:suffix),", ")'),'')
endfunction

function! s:buffer_alter_paths() dict abort
  if self.getvar('&suffixesadd') =~# '\.rb\>'
    let new = sort(values(self.project().gems()))
    let index = index(new, self.project().path())
    if index > 0
      call insert(new,remove(new,index))
    endif
    let old = type(self.getvar('bundler_paths')) == type([]) ? self.getvar('bundler_paths') : []
    for [option, suffix] in [['path', 'lib'], ['tags', 'tags']]
      let value = self.getvar('&'.option)
      if !empty(old)
        let drop = s:build_path_option(old,suffix)
        let index = stridx(value,drop)
        if index > 0
          let value = value[0:index-1] . value[index+strlen(drop):-1]
        endif
      endif
      call self.setvar('&'.option,value.s:build_path_option(new,suffix))
    endfor
    call self.setvar('bundler_paths',new)
  endif
endfunction

call s:add_methods('buffer',['alter_paths'])

function! s:project_alter_buffer_paths() dict abort
  for bufnr in range(1,bufnr('$'))
    if getbufvar(bufnr,'bundler_root') ==# self.path()
      let vim_parsing_quirk = s:buffer(bufnr).alter_paths()
    endif
  endfor
endfunction

call s:add_methods('project',['alter_buffer_paths'])

augroup bundler_path
  autocmd!
  autocmd User Bundler call s:buffer().alter_paths()
augroup END

" }}}1

" vim:set sw=2 sts=2:
