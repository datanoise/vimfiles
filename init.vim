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
  " Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-dadbod', { 'on': 'DB' }

  Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  Plug 'junegunn/gv.vim',         { 'on': 'GV' }
  Plug 'justinmk/vim-dirvish'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " file types
  Plug 'pangloss/vim-javascript'  
  Plug 'datanoise/vim-jsx-pretty'
  Plug 'othree/html5.vim'
  " lazy loading for filetypes makes sense only for those that are not
  " included in the standard Vim distribution. Otherwise, Vim will load them
  " anyway, possibly very old version.
  Plug 'euclio/vim-markdown-composer', { 'for': 'markdown' }
  Plug 'tpope/vim-haml',               { 'for': ['haml', 'sass', 'scss'] }
  Plug 'rust-lang/rust.vim',           { 'for': 'rust' }
  Plug 'racer-rust/vim-racer',         { 'for': 'rust' }
  Plug 'keith/swift.vim',              { 'for': 'swift' }
  Plug 'vim-scripts/nginx.vim',        { 'for': 'nginx' }
  Plug 'kchmck/vim-coffee-script',     { 'for': 'coffee' }
  Plug 'datanoise/vim-vue',            { 'for': ['javascript', 'vue'] }
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
  Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }
  Plug 'vim-ruby/vim-ruby'
  Plug 'datanoise/vim-ruby-heredoc-syntax'
  Plug 'plasticboy/vim-markdown'

  if $GOPATH !=# ''
    " do not use lazy loading, cause it disables template function
    Plug 'fatih/vim-go'
  endif

  " statusline
  if $TERM ==# '' || $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color'
    " lightline
    Plug 'itchyny/lightline.vim'
  endif

  " snippets
  Plug 'Shougo/neosnippet-snippets'
  Plug 'honza/vim-snippets'

  Plug 'godlygeek/tabular',            { 'on': 'Tabularize' }
  Plug 'datanoise/vim-indexed-search', { 'on': 'ShowSearchIndex' }
  Plug 'vim-scripts/searchfold.vim',   { 'on': '<Plug>SearchFoldNormal' }
  Plug 'datanoise/vim-bclose',         { 'on': 'Bclose' }
  Plug 'AndrewRadev/splitjoin.vim',    { 'on': [ 'SplitjoinJoin', 'SplitjoinSplit'] }
  Plug 'datanoise/switch.vim',         { 'on': 'Switch' }


  " text objects
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-fold'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'kana/vim-textobj-syntax'
  Plug 'kana/vim-textobj-datetime'
  Plug 'datanoise/vim-textobj-quoted'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'thinca/vim-textobj-between'
  Plug 'lucapette/vim-textobj-underscore'

  Plug 'datanoise/vim-localvimrc'
  Plug 'datanoise/vim-cmdline-complete'
  Plug 'rhysd/git-messenger.vim'
  Plug 'mhinz/vim-grepper'
  Plug 'janko-m/vim-test'
  Plug 'tweekmonster/exception.vim'
  Plug 'mhinz/vim-randomtag'
  Plug 'machakann/vim-highlightedyank'
  Plug 'datanoise/bufexplorer'
  Plug 'vimwiki/vimwiki'
  Plug 'easymotion/vim-easymotion'
  Plug 'lervag/vimtex'

  if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'nvim-treesitter/playground'

    Plug 'bfredl/nvim-miniyank'
    Plug 'datanoise/vim-dispatch-neovim'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'numToStr/Comment.nvim'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'rcarriga/nvim-notify'
    Plug 'folke/which-key.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'mfussenegger/nvim-dap'
    Plug 'kylechui/nvim-surround'
    Plug 'RRethy/nvim-treesitter-endwise'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'folke/trouble.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'josa42/nvim-lightline-lsp'
    Plug 'andymass/vim-matchup'
    Plug 'windwp/nvim-autopairs'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'EdenEast/nightfox.nvim'
    Plug 'Everblush/everblush.nvim', { 'as': 'everblush' }
    Plug 'Mofiqul/adwaita.nvim'
    Plug 'Yazeed1s/minimal.nvim'

    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'stevearc/aerial.nvim'
  else
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-endwise'
    Plug 'Raimondi/delimitMate'
    Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
    Plug 'airblade/vim-gitgutter', { 'on': [ 'GitGutterToggle', 'GitGutterEnable' ] }
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

    Plug 'w0rp/ale'
    Plug 'maximbaz/lightline-ale'

    Plug 'kana/vim-textobj-function'
    Plug 'AndrewRadev/sideways.vim'
    Plug 'majutsushi/tagbar'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'ap/vim-css-color'
    Plug 'flazz/vim-colorschemes'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'wellle/tmux-complete.vim'

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
