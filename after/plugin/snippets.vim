" command! NERDSnippetReload :so ~/.vim/after/plugin/snippets.vim
let s:script_file = expand("<sfile>")
command! NERDSnippetReload :exec ":source " . s:script_file|echomsg 'NERDSnippets reloaded'

call NERDSnippetsReset()

source ~/.vim/snippets/support_functions.vim


call NERDSnippetsFromDirectory("~/.vim/snippets")

function! s:inRailsEnv()
    return filereadable(getcwd() . '/config/environment.rb')
endfunction

if s:inRailsEnv()
    call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/ruby-rails', 'ruby')
    call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/eruby-rails', 'eruby')
endif

call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/html', 'eruby')
call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/html', 'xhtml')
call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/html', 'php')
