"=============================================================================
" Copyright (c) 2007-2009 Takeshi NISHIDA
"
"=============================================================================
" LOAD GUARD {{{1

if exists('g:loaded_autoload_fuf_tm') || v:version < 702
  finish
endif
let g:loaded_autoload_fuf_tm = 1

" }}}1
"=============================================================================
" GLOBAL FUNCTIONS {{{1

"
function fuf#tm#createHandler(base)
  return a:base.concretize(copy(s:handler))
endfunction

"
function fuf#tm#getSwitchOrder()
  return g:fuf_file_switchOrder
endfunction

"
function fuf#tm#renewCache()
  let s:cache = {}
endfunction

"
function fuf#tm#requiresOnCommandPre()
  return 0
endfunction

"
function fuf#tm#onInit()
  call fuf#defineLaunchCommand('FufTm'                    , s:MODE_NAME, '""')
  call fuf#defineLaunchCommand('FufTmWithFullCwd'         , s:MODE_NAME, 'fnamemodify(getcwd(), '':p'')')
  call fuf#defineLaunchCommand('FufTmWithCurrentBufferDir', s:MODE_NAME, 'expand(''%:~:.'')[:-1-len(expand(''%:~:.:t''))]')
  command! FufTmClear ruby finder_clear
  " initialize Ruby lib
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
endfunction

" }}}1
"=============================================================================
" LOCAL FUNCTIONS/VARIABLES {{{1

let s:MODE_NAME = expand('<sfile>:t:r')

"
function s:enumItems(dir)
  let key = getcwd() . "\n" . a:dir
  if !exists('s:cache[key]')
    let s:cache[key] = fuf#enumExpandedDirsEntries(a:dir, g:fuf_file_exclude)
    call fuf#mapToSetSerialIndex(s:cache[key], 1)
    call fuf#mapToSetAbbrWithSnippedWordAsPath(s:cache[key])
  endif
  return s:cache[key]
endfunction

"
function s:enumNonCurrentItems(dir, bufNr, cache)
  let key = a:dir . 'AVOIDING EMPTY KEY'
  if !exists('a:cache[key]')
    " NOTE: filtering should be done with
    "       'bufnr("^" . v:val.word . "$") != a:bufNr'.
    "       But it takes a lot of time!
    let bufName = bufname(a:bufNr)
    let a:cache[key] =
          \ filter(copy(s:enumItems(a:dir)), 'v:val.word != bufName')
  endif
  return a:cache[key]
endfunction

" }}}1
"=============================================================================
" s:handler {{{1

let s:handler = {}

"
function s:handler.getModeName()
  return s:MODE_NAME
endfunction

"
function s:handler.getPrompt()
  return g:fuf_file_prompt
endfunction

"
function s:handler.targetsPath()
  return 1
endfunction

"
function s:handler.onComplete(patternSet)
  let items = s:enumNonCurrentItems(
        \ fuf#splitPath(a:patternSet.raw).head, self.bufNrPrev, self.cache)
  return fuf#filterMatchesAndMapToSetRanks(
        \ items, a:patternSet, self.getFilteredStats(a:patternSet.raw))
endfunction

"
function s:handler.onOpen(expr, mode)
  call fuf#openFile(a:expr, a:mode, g:fuf_reuseWindow)
endfunction

"
function s:handler.onModeEnterPre()
endfunction

"
function s:handler.onModeEnterPost()
  let self.cache = {}
endfunction

"
function s:handler.onModeLeavePost(opened)
endfunction

" }}}1
"=============================================================================
" vim: set fdm=marker:
