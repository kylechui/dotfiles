local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Telescope nonsense
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Status line and bufferline
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'akinsho/nvim-bufferline.lua'
  -- File explorer
  use 'kyazdani42/nvim-tree.lua'
  -- Colour scheme
  use 'sainnhe/gruvbox-material'
  -- Universal way to add comments
  use 'tpope/vim-commentary'
  -- Surround stuff with delimiters
  use 'tpope/vim-surround'
  -- LaTeX integration
  use 'lervag/vimtex'
  -- Snippets
  use 'sirver/ultisnips'
  -- Get good
  use 'ThePrimeagen/vim-be-good'
  -- Discord integration
  use 'andweeb/presence.nvim'
  -- Highlight hex codes
  use {
    'RRethy/vim-hexokinase',
    run = 'make hexokinase'
  }
end)
