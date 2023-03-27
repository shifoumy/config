#!/usr/bin/env lua
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-repeat'
-- use 'jiangmiao/auto-pairs' -- Auto close brackets or quotes
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use "lukas-reineke/indent-blankline.nvim"
  use 'kyazdani42/nvim-web-devicons'
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
          'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
-- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
-- Theme plugins
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'ryanoasis/vim-devicons' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
-- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
-- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use "williamboman/mason.nvim"
  -- use {
  --   "williamboman/nvim-lsp-installer",
  --   {
  --       "neovim/nvim-lspconfig",
  --       config = function()
  --           require("nvim-lsp-installer").setup {
  --               automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  --               ui = {
  --                   icons = {
  --                       server_installed = "✓",
  --                       server_pending = "➜",
  --                       server_uninstalled = "✗"
  --                   }
  --               }
  --           }
  --           local lspconfig = require("lspconfig")
  --           lspconfig.sumneko_lua.setup {}
  --       end
  --   }
  -- }
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
--  use 'williamboman/nvim-lsp-installer' -- Directly install form nvim
  use 'nanotee/sqls.nvim'
  use 'ethanholz/nvim-lastplace'
  use 'samirettali/shebang.nvim'
-- Trim withespace and useless lines
--  use 'cappyzawa/trim.nvim'
  use 'machakann/vim-highlightedyank'
-- lsp format to format at saving file
  use "lukas-reineke/lsp-format.nvim"

  use "onsails/lspkind.nvim"
-- test plugins : 
-- Lightweight floating statuslines
  use "b0o/incline.nvim"

-- window shading
  use 'sunjon/shade.nvim'

-- status line 
--  use "rebelot/heirline.nvim"

-- No neck pain 
--  use {"shortcuts/no-neck-pain.nvim", tag = "*" }
-- Test neogit https://github.com/TimUntersberger/
  use { 'TimUntersberger/neogit', 
    requires = 'nvim-lua/plenary.nvim'
  }
-- Test ToggleTerm
  use {"akinsho/toggleterm.nvim", tag = '*'}
-- Test transparency https://github.com/xiyaowong/nvim-transparent
--  use {"xiyaowong/nvim-transparent"}

-- Startup plugin
  use {
        "startup-nvim/startup.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    }

-- Test nvim notifications
  use {
  'mrded/nvim-lsp-notify',
  requires = { 'rcarriga/nvim-notify' },
  config = function()
    require('lsp-notify').setup({
      notify = require('notify'),
    })
  end
}

-- Noice plugin
  use{
    "folke/noice.nvim",
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
      }
  }
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        require("lspsaga").setup({})
    end,
    requires = { {"nvim-tree/nvim-web-devicons"} }
  })
  use { "catppuccin/nvim", as = "catppuccin" }

  use {
    'akinsho/git-conflict.nvim',
    tag = "*", 
    config = function()
        require('git-conflict').setup()
    end
    }

end)
