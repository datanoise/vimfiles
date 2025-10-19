" -*- vim -*- vim:set ft=vim et sw=2 sts=2 fdc=3:
scriptencoding utf-8

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Section: Plugins {{{1
silent! if plug#begin('~/.vim/bundle')
  Plug 'tpope/vim-capslock'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-tbone'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-apathy'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-dadbod', { 'on': 'DB' }
  Plug 'tpope/vim-rbenv'

  Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  Plug 'junegunn/gv.vim',         { 'on': 'GV' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " file types
  Plug 'pangloss/vim-javascript'  
  Plug 'datanoise/vim-jsx-pretty'
  Plug 'euclio/vim-markdown-composer', { 'for': 'markdown' }
  Plug 'tpope/vim-haml',               { 'for': ['haml', 'sass', 'scss'] }
  Plug 'racer-rust/vim-racer',         { 'for': 'rust' }
  Plug 'keith/swift.vim',              { 'for': 'swift' }
  Plug 'vim-scripts/nginx.vim',        { 'for': 'nginx' }
  Plug 'kchmck/vim-coffee-script',     { 'for': 'coffee' }
  Plug 'tmux-plugins/vim-tmux',        { 'for': 'tmux' }
  Plug 'digitaltoad/vim-pug',          { 'for': ['pug', 'jade'] }
  Plug 'ekalinin/Dockerfile.vim',      { 'for': 'Dockerfile' }
  Plug 'hallison/vim-rdoc',            { 'for': 'rdoc' }
  Plug 'groenewege/vim-less',          { 'for': 'less' }
  Plug 'jneen/ragel.vim',              { 'for': 'ragel' }
  Plug 'cespare/vim-toml',             { 'for': 'toml' }
  Plug 'elixir-editors/vim-elixir',    { 'for': ['elixir', 'eelixir'] }
  Plug 'datanoise/vim-crystal',        { 'for': ['crystal', 'html'] }
  Plug 'datanoise/vim-llvm',           { 'for': 'llvm' }
  Plug 'python-mode/python-mode',      { 'for': 'python', 'branch': 'develop' }
  Plug 'vim-ruby/vim-ruby'
  Plug 'datanoise/vim-ruby-heredoc-syntax'
  Plug 'plasticboy/vim-markdown'
  Plug 'fatih/vim-go'

  Plug 'godlygeek/tabular',            { 'on': 'Tabularize' }
  Plug 'datanoise/vim-indexed-search', { 'on': 'ShowSearchIndex' }
  Plug 'vim-scripts/searchfold.vim',   { 'on': '<Plug>SearchFoldNormal' }
  Plug 'AndrewRadev/splitjoin.vim',    { 'on': [ 'SplitjoinJoin', 'SplitjoinSplit'] }
  Plug 'datanoise/switch.vim'
  Plug 'AndrewRadev/sideways.vim'

  Plug 'wellle/targets.vim'
  Plug 'datanoise/vim-cmdline-complete'
  Plug 'rhysd/git-messenger.vim'
  Plug 'mhinz/vim-grepper'
  Plug 'janko-m/vim-test'
  Plug 'tweekmonster/exception.vim'
  Plug 'mhinz/vim-randomtag'
  Plug 'datanoise/bufexplorer'
  Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }
  Plug 'lervag/vimtex'
  Plug 'datanoise/vim-localvimrc'
  Plug 'tweekmonster/startuptime.vim'
  Plug 'github/copilot.vim'
  Plug 'sindrets/diffview.nvim'

  if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'RRethy/nvim-treesitter-endwise'

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'gbprod/yanky.nvim'
    Plug 'datanoise/vim-dispatch-neovim'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'rcarriga/nvim-notify'
    Plug 'neovim/nvim-lspconfig'
    Plug 'mason-org/mason.nvim'
    Plug 'mason-org/mason-lspconfig.nvim'
    Plug 'kylechui/nvim-surround'
    Plug 'nvimtools/none-ls.nvim'
    Plug 'folke/trouble.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    "Plug 'andymass/vim-matchup'
    Plug 'windwp/nvim-autopairs'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'j-hui/fidget.nvim'
    Plug 'ibhagwan/fzf-lua'
    Plug 'phaazon/hop.nvim'
    Plug 'echasnovski/mini.nvim'
    Plug 'stevearc/oil.nvim'
    Plug 'mrcjkb/rustaceanvim'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'stevearc/aerial.nvim'
    Plug 'kdheepak/lazygit.nvim'
    Plug 'kevinhwang91/nvim-bqf'

    " AI tools
    "Plug 'olimorris/codecompanion.nvim'
    Plug 'folke/sidekick.nvim'

    " Completion
    Plug 'Saghen/blink.cmp', { 'do': 'cargo build --release' }

    " Testing
    Plug 'nvim-neotest/nvim-nio'
    Plug 'nvim-neotest/neotest'
    Plug 'zidhuss/neotest-minitest'
    Plug 'nvim-neotest/neotest-vim-test'
    Plug 'olimorris/neotest-rspec'
  else
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-endwise'
    Plug 'Raimondi/delimitMate'
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
    Plug 'airblade/vim-gitgutter', { 'on': [ 'GitGutterToggle', 'GitGutterEnable' ] }
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'datanoise/vim-bclose', { 'on': 'Bclose' }
    Plug 'othree/html5.vim'

    Plug 'w0rp/ale'
    Plug 'maximbaz/lightline-ale'

    Plug 'ap/vim-css-color'
    Plug 'flazz/vim-colorschemes'
    Plug 'machakann/vim-highlightedyank'

    " statusline
    if $TERM ==# '' || $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color'
      " lightline
      Plug 'itchyny/lightline.vim'
    endif

    " snippets
    Plug 'honza/vim-snippets'

    " ctrlp
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'ompugao/ctrlp-history'
    Plug 'mattn/ctrlp-mark'
    Plug 'mattn/ctrlp-register'
    Plug 'kaneshin/ctrlp-tabbed'
    Plug 'tacahiroy/ctrlp-funky'
  endif

  call plug#end()
endif

packadd cfilter
packadd matchit

runtime! plugin/options.vim
runtime! plugin/keybindings.vim
runtime! plugin/commands.vim
runtime! plugin/filetypes.vim
if has('nvim')
  lua require('plugins')
endif
