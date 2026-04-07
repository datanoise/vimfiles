return {
  { 'tpope/vim-capslock' },
  { 'tpope/vim-dispatch' },
  { 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GBrowse', 'Gclog', 'Gvdiffsplit' } },
  { 'tpope/vim-ragtag', ft = { 'html', 'eruby', 'xml', 'javascriptreact', 'typescriptreact' } },
  { 'tpope/vim-rails', ft = { 'ruby', 'eruby' } },
  { 'tpope/vim-scriptease', cmd = { 'Messages', 'Scriptnames', 'Verbose', 'Time', 'Runtime' } },
  { 'tpope/vim-tbone', cmd = { 'Tattach', 'Tdrop', 'Tedit', 'Tabedit', 'Tread', 'Twrite' } },
  { 'tpope/vim-sleuth', event = { 'BufReadPost', 'BufNewFile' } },
  { 'tpope/vim-git' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-projectionist', event = { 'BufReadPost', 'BufNewFile' } },
  { 'tpope/vim-abolish', cmd = { 'Abolish', 'Subvert' } },
  { 'tpope/vim-obsession', cmd = 'Obsession' },
  { 'tpope/vim-apathy' },
  { 'tpope/vim-bundler', ft = { 'ruby', 'eruby' } },
  { 'tpope/vim-dadbod', cmd = { 'DB', 'DBUI', 'DBUIToggle', 'DBUIFindBuffer' } },
  { 'tpope/vim-rbenv', ft = { 'ruby', 'eruby' } },
  { 'junegunn/vim-easy-align', keys = {
    { 'ga', '<Plug>(EasyAlign)', mode = 'n' },
    { 'ga', '<Plug>(EasyAlign)', mode = 'x' },
    { '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
  } },
  { 'junegunn/gv.vim', cmd = 'GV' },
  { 'pangloss/vim-javascript', ft = { 'javascript', 'javascriptreact' } },
  { 'datanoise/vim-jsx-pretty', ft = { 'javascriptreact', 'typescriptreact' } },
  { 'euclio/vim-markdown-composer', ft = 'markdown' },
  { 'tpope/vim-haml', ft = { 'haml', 'sass', 'scss' } },
  { 'racer-rust/vim-racer', ft = 'rust' },
  { 'keith/swift.vim', ft = 'swift' },
  { 'vim-scripts/nginx.vim', ft = 'nginx' },
  { 'kchmck/vim-coffee-script', ft = 'coffee' },
  { 'tmux-plugins/vim-tmux', ft = 'tmux' },
  { 'digitaltoad/vim-pug', ft = { 'pug', 'jade' } },
  { 'ekalinin/Dockerfile.vim', ft = 'dockerfile' },
  { 'hallison/vim-rdoc', ft = 'rdoc' },
  { 'groenewege/vim-less', ft = 'less' },
  { 'jneen/ragel.vim', ft = 'ragel' },
  { 'cespare/vim-toml', ft = 'toml' },
  { 'elixir-editors/vim-elixir', ft = { 'elixir', 'eelixir', 'heex' } },
  { 'datanoise/vim-crystal', ft = { 'crystal', 'html' } },
  { 'datanoise/vim-llvm', ft = 'llvm' },
  { 'python-mode/python-mode', branch = 'develop', ft = 'python' },
  { 'vim-ruby/vim-ruby', ft = { 'ruby', 'eruby', 'rake', 'gemspec' } },
  { 'datanoise/vim-ruby-heredoc-syntax', ft = 'ruby' },
  { 'plasticboy/vim-markdown', ft = 'markdown' },
  { 'fatih/vim-go', ft = { 'go', 'gomod', 'gowork', 'gotmpl' } },
  { 'godlygeek/tabular', cmd = 'Tabularize', keys = {
    { 'g=', ':Tabularize assignment<CR>', mode = 'n', silent = true },
    { 'g=', ':Tabularize assignment<CR>', mode = 'x', silent = true },
  } },
  { 'datanoise/vim-indexed-search' },
  { 'vim-scripts/searchfold.vim', keys = { { '<leader>z', '<Plug>SearchFoldNormal', mode = 'n' } } },
  { 'AndrewRadev/splitjoin.vim', cmd = { 'SplitjoinSplit', 'SplitjoinJoin' }, keys = {
    { '<leader>sp', ':SplitjoinSplit<CR>', mode = 'n', silent = true },
    { '<leader>sj', ':SplitjoinJoin<CR>', mode = 'n', silent = true },
  } },
  { 'datanoise/switch.vim', keys = { { 'gs', '<Cmd>Switch<CR>', mode = 'n', silent = true } } },
  { 'AndrewRadev/sideways.vim', keys = {
    { '<leader><', ':<C-u>SidewaysLeft<CR>', mode = 'n', silent = true },
    { '<leader>>', ':<C-u>SidewaysRight<CR>', mode = 'n', silent = true },
    { '<leader>si', '<Plug>SidewaysArgumentInsertBefore', mode = 'n', silent = true },
    { '<leader>sa', '<Plug>SidewaysArgumentAppendAfter', mode = 'n', silent = true },
    { '<leader>sI', '<Plug>SidewaysArgumentInsertFirst', mode = 'n', silent = true },
    { '<leader>sA', '<Plug>SidewaysArgumentAppendLast', mode = 'n', silent = true },
    { 'aa', '<Plug>SidewaysArgumentTextobjA', mode = { 'o', 'x' } },
    { 'ia', '<Plug>SidewaysArgumentTextobjI', mode = { 'o', 'x' } },
  } },
  { 'wellle/targets.vim' },
  { 'datanoise/vim-cmdline-complete' },
  { 'rhysd/git-messenger.vim', cmd = 'GitMessenger' },
  { 'mhinz/vim-grepper',
    init = function()
      vim.g.grepper = {}
      vim.g.grepper.tools = { 'rg', 'ag', 'grep' }
      vim.cmd([[cnoreabbrev <expr> ag ((getcmdtype() ==# ":" && getcmdline() ==# "ag") ? ("GrepperAg") : ("ag"))]])
      vim.cmd([[cnoreabbrev <expr> rg ((getcmdtype() ==# ":" && getcmdline() ==# "rg") ? ("GrepperRg") : ("rg"))]])
      vim.cmd([[cnoreabbrev <expr> rgr ((getcmdtype() ==# ":" && getcmdline() ==# "rgr") ? ("GrepperRg -t ruby") : ("rgr"))]])
      vim.cmd([[cnoreabbrev <expr> grep ((getcmdtype() ==# ":" && getcmdline() ==# "grep") ? ("GrepperGrep") : ("grep"))]])
    end,
    cmd = { 'Grepper', 'GrepperRg', 'GrepperAg', 'GrepperGrep', 'GrepperBuffer' },
    keys = {
      { '<leader>gf', '<Plug>(GrepperOperator)', mode = { 'n', 'x' } },
      { '<leader>*', ':Grepper-buffer -cword -noprompt<CR>', mode = 'n' },
      { '[F', function() vim.cmd('GrepperRg ' .. vim.fn.expand('<cword>')) end, mode = 'n' },
      { ']F', function() vim.cmd('GrepperRg ' .. vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. vim.fn.virtcol('.') .. 'v\\w*')) end, mode = 'n' },
    },
  },
  { 'janko-m/vim-test',
    init = function()
      vim.g['test#strategy'] = 'dispatch'
      vim.g['test#neovim#term_position'] = 'botright 10'
      vim.g['test#ruby#use_binstubs'] = 1
    end,
    cmd = { 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' },
    keys = {
      { '<leader>ts', '<Cmd>TestSuite<CR>', mode = 'n' },
      { '<leader>tt', '<Cmd>TestNearest<CR>', mode = 'n' },
      { '<leader>tn', '<Cmd>TestNearest<CR>', mode = 'n' },
      { '<leader>tl', '<Cmd>TestLast<CR>', mode = 'n' },
      { '<leader>tf', '<Cmd>TestFile<CR>', mode = 'n' },
      { '<leader>tv', '<Cmd>TestVisit<CR>', mode = 'n' },
    },
  },
  { 'tweekmonster/exception.vim',
    cmd = 'WTF',
    config = function()
      vim.api.nvim_create_user_command('WTF', function()
        vim.fn['exception#trace']()
      end, {})
    end,
  },
  { 'mhinz/vim-randomtag' },
  { 'datanoise/bufexplorer', cmd = 'BufExplorer', keys = {
    { '<leader>be', ':BufExplorer<CR>', mode = 'n', silent = true },
  } },
  { 'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_path = '~/.vimwiki/'
      vim.g.vimwiki_key_mappings = { table_mappings = 0 }
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_listing_hl = 1
    end,
    cmd = { 'VimwikiIndex', 'VimwikiTabIndex', 'VimwikiUISelect', 'VimwikiDiaryIndex' },
    keys = { { '<leader>ww', '<Cmd>VimwikiIndex<CR>', mode = 'n', silent = true } },
  },
  { 'lervag/vimtex', ft = 'tex' },
  { 'datanoise/vim-localvimrc' },
  { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' },
  { 'sindrets/diffview.nvim', cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh' } },
}
