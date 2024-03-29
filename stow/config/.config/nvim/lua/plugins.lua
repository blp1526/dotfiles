local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system(
    {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    }
  )
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'folke/tokyonight.nvim', branch = 'main' }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-telescope/telescope-ghq.nvim' },
    config = function()
      require('telescope').load_extension('ghq')
    end
  }

  use 'phaazon/hop.nvim'
  use 'williamboman/nvim-lsp-installer'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
