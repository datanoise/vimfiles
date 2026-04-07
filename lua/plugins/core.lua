return {
  { 'tpope/vim-capslock' },
  { 'tpope/vim-dispatch' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-ragtag' },
  { 'tpope/vim-rails' },
  { 'tpope/vim-scriptease' },
  { 'tpope/vim-tbone' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-git' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-projectionist' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-obsession' },
  { 'tpope/vim-apathy' },
  { 'tpope/vim-bundler' },
  { 'tpope/vim-dadbod', cmd = { 'DB', 'DBUI', 'DBUIToggle', 'DBUIFindBuffer' } },
  { 'tpope/vim-rbenv' },
  { 'junegunn/vim-easy-align', keys = {
    { 'ga', '<Plug>(EasyAlign)', mode = 'n' },
    { 'ga', '<Plug>(EasyAlign)', mode = 'x' },
    { '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
  } },
  { 'junegunn/gv.vim', cmd = 'GV' },
  { 'pangloss/vim-javascript' },
  { 'datanoise/vim-jsx-pretty' },
  { 'euclio/vim-markdown-composer' },
  { 'tpope/vim-haml' },
  { 'racer-rust/vim-racer' },
  { 'keith/swift.vim' },
  { 'vim-scripts/nginx.vim' },
  { 'kchmck/vim-coffee-script' },
  { 'tmux-plugins/vim-tmux' },
  { 'digitaltoad/vim-pug' },
  { 'ekalinin/Dockerfile.vim' },
  { 'hallison/vim-rdoc' },
  { 'groenewege/vim-less' },
  { 'jneen/ragel.vim' },
  { 'cespare/vim-toml' },
  { 'elixir-editors/vim-elixir' },
  { 'datanoise/vim-crystal' },
  { 'datanoise/vim-llvm' },
  { 'python-mode/python-mode', branch = 'develop' },
  { 'vim-ruby/vim-ruby' },
  { 'datanoise/vim-ruby-heredoc-syntax' },
  { 'plasticboy/vim-markdown' },
  { 'fatih/vim-go' },
  { 'godlygeek/tabular', cmd = 'Tabularize', keys = {
    { 'g=', ':Tabularize assignment<CR>', mode = 'n', silent = true },
    { 'g=', ':Tabularize assignment<CR>', mode = 'x', silent = true },
  } },
  { 'datanoise/vim-indexed-search' },
  { 'vim-scripts/searchfold.vim', keys = { { '<leader>z', '<Plug>SearchFoldNormal', mode = 'n' } } },
  { 'AndrewRadev/splitjoin.vim' },
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
  { 'tweekmonster/exception.vim' },
  { 'mhinz/vim-randomtag' },
  { 'datanoise/bufexplorer' },
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
  { 'lervag/vimtex' },
  { 'datanoise/vim-localvimrc' },
  { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' },
  { 'sindrets/diffview.nvim', cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh' } },
}
