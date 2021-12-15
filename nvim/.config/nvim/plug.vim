if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive' " need to be explored
Plug 'tpope/vim-rhubarb' " used by fugitive

if has("nvim")
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'hoob3rt/lualine.nvim' " bottom navbar configurable
  Plug 'neovim/nvim-lspconfig'
  Plug 'sainnhe/sonokai'
  " Typesripts packages
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer' " use your current buffer for auto-complete
  Plug 'hrsh7th/cmp-path'   " completing paths inside buffer
"  Plug 'hrsh7th/cmp-cmdline' 
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'onsails/lspkind-nvim'
  Plug 'tami5/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " syntax highlighter
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/plenary.nvim' " For multi-thread for some plugs
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
"  Plug 'nvim-lua/popup.nvim'  " For Notification needed to be explored
  Plug 'windwp/nvim-autopairs' " pair paren ...
  Plug 'akinsho/bufferline.nvim'
  Plug 'SirVer/ultisnips' 
  Plug 'quangnguyen30192/cmp-nvim-ultisnips' " To work with ultsnips
  Plug 'kyazdani42/nvim-tree.lua'
"   " --------- adding the following three plugins for Latex ---------
"    Plug 'lervag/vimtex'
"    Plug 'Konfekt/FastFold'
"    Plug 'matze/vim-tex-fold'
"	Plug 'derektata/lorem.nvim'
"	Plug 'vim-scripts/loremipsum'
	

endif

call plug#end()
