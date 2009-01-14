if !has("ruby")
  finish
endif

" ====================================================================================
" COPIED FROM FUZZYFINDER.VIM {{{
" since they can't be called from outside fuzzyfinder.vim
" ====================================================================================
function! s:GetCurrentTagFiles()
  return sort(filter(map(tagfiles(), 'fnamemodify(v:val, '':p'')'), 'filereadable(v:val)'))
endfunction

function! s:HighlightPrompt(prompt, highlight)
  syntax clear
  execute printf('syntax match %s /^\V%s/', a:highlight, escape(a:prompt, '\'))
endfunction

function! s:HighlightError()
  syntax clear
  syntax match Error  /^.*$/
endfunction

function! s:ExistsPrompt(line, prompt)
  return  strlen(a:line) >= strlen(a:prompt) && a:line[:strlen(a:prompt) -1] ==# a:prompt
endfunction

function! s:RemovePrompt(line, prompt)
  return a:line[(s:ExistsPrompt(a:line, a:prompt) ? strlen(a:prompt) : 0):]
endfunction
" ------------------------------------------------------------------------------------
" }}}
" ====================================================================================

command! -bang -narg=? -complete=file   FuzzyFinderTextMate   call FuzzyFinderTextMateLauncher(<q-args>, len(<q-bang>))
command! FFTclear ruby finder_clear
command! FuzzyFinderTextMateClear ruby finder_clear

function! InstantiateTextMateMode() "{{{
ruby << RUBY
  begin
    require "#{ENV['HOME']}/.vim/ruby/fuzzy_file_finder"
  rescue LoadError
    begin
      require 'rubygems'
      begin
        gem 'fuzzy_file_finder'
      rescue Gem::LoadError
        gem 'jamis-fuzzy_file_finder'
      end
    rescue LoadError
      puts "ERROR #{$!}"
    end

    require 'fuzzy_file_finder'
  end
RUBY

  " Configuration option: g:fuzzy_roots
  " Specifies roots in which the FuzzyFinder will search.
  if !exists('g:fuzzy_roots')
    let g:fuzzy_roots = ['.']
  endif

  " Configuration option: g:fuzzy_ceiling
  " Specifies the maximum number of files that FuzzyFinder allows to be searched
  if !exists('g:fuzzy_ceiling')
    let g:fuzzy_ceiling = 10000
  endif

  " Configuration option: g:fuzzy_ignore
  " A semi-colon delimited list of file glob patterns to ignore
  if !exists('g:fuzzy_ignore')
    let g:fuzzy_ignore = ""
  endif

  " Configuration option: g:fuzzy_enumerating_limit
  " The maximum number of matches to return at a time. Defaults to 200, via the
  " g:FuzzyFinderMode.TextMate.enumerating_limit variable, but using a global variable
  " makes it easier to set this value.

ruby << RUBY
  def finder
    @finder ||= begin
      roots = VIM.evaluate("g:fuzzy_roots").split("\n")
      ceiling = VIM.evaluate("g:fuzzy_ceiling").to_i
      ignore = VIM.evaluate("g:fuzzy_ignore").split(/;/)
      FuzzyFileFinder.new(roots, ceiling, ignore)
    end
  end

  def finder_clear
    @finder = nil
  end
RUBY

  let g:FuzzyFinderMode.TextMate = copy(g:FuzzyFinderMode.Base)

  function! g:FuzzyFinderMode.TextMate.on_mode_enter()
    let self.tag_files = s:GetCurrentTagFiles()
  endfunction

  " ================================================================================
  " This function is copied almost whole-sale from fuzzyfinder.vim. Ideally, I could
  " used the on_complete callback to more cleanly add the new behavior, but the
  " TextMate-style completion broke a few of fuzzyfinder.vim's assumptions, and the
  " only way to patch that up was to override Base.complete...which required me to
  " copy-and-paste much of the original implementation.
  "
  " Ugly. But effective.
  " ================================================================================
  function! g:FuzzyFinderMode.TextMate.complete(findstart, base)
    if a:findstart
      return 0
    elseif  !s:ExistsPrompt(a:base, self.prompt) || len(s:RemovePrompt(a:base, self.prompt)) < self.min_length
      return []
    endif
    call s:HighlightPrompt(self.prompt, self.prompt_highlight)

    let result = []

    if exists('g:fuzzy_enumerating_limit')
      let l:limit = g:fuzzy_enumerating_limit
    else
      let l:limit = self.enumerating_limit
    endif

    ruby << RUBY
      text = VIM.evaluate('s:RemovePrompt(a:base, self.prompt)')
      limit = VIM.evaluate('l:limit').to_i

      matches = finder.find(text, limit)
      matches.sort_by { |a| [-a[:score], a[:path]] }.each_with_index do |match, index|
        word = match[:path]
        abbr = "%2d: %s" % [index+1, match[:abbr]]
        menu = "[%5d]" % [match[:score] * 10000]
        VIM.evaluate("add(result, { 'word' : #{word.inspect}, 'abbr' : #{abbr.inspect}, 'menu' : #{menu.inspect} })")
      end
RUBY

    if empty(result) || len(result) >= self.enumerating_limit
      call s:HighlightError()
    endif

    if !empty(result)
      call feedkeys("\<C-p>\<Down>", 'n')
    endif

    return result
  endfunction

  let g:FuzzyFinderOptions.TextMate = copy(g:FuzzyFinderOptions.File)
endfunction "}}}

let s:loaded = 0
function! FuzzyFinderTextMateLauncher(initial_text, partial_matching)
  if !s:loaded
    call InstantiateTextMateMode()
    let s:loaded = 1
  endif
  call g:FuzzyFinderMode.TextMate.launch(a:initial_text, a:partial_matching)
endfunction
