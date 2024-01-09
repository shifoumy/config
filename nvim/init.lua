--------------------------------------------------------------------> Plugins
vim.opt.mouse = nil
vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
---------------------------------------------------------------------> Global config
require "packer_plugins"

local opt = vim.opt
vim.o.breakindent = true
vim.g.mapleader = ":"
opt.ignorecase = true
-- opt.mouse = "a"
opt.autoindent = true
opt.hlsearch = true
opt.number = true
opt.cursorline = true
opt.laststatus = 2
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.ruler = true
opt.syntax = "on"
opt.smartcase = true
opt.ignorecase = true
opt.list = true
-- old
vim.opt.clipboard:prepend {"unnamedplus"}
--Set colorscheme
vim.o.termguicolors = true
-- vim.cmd [[colorscheme onedark]]
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--Set theme :
-- require('onedark').setup {
--     style = 'darker',
--
-- }
-- require('onedark').load()

--------------------------------------------------------------------> Mappings
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
require "config_telescope"

require("nvim-tree").setup({
    -- git = {
    --     enable = true,
    --     ignore = false,
    --     show_on_dirs = true,
    --     show_on_open_dirs = true,
    --     timeout = 400,
    -- },
})
--

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {"bold"},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
}

--Map blankline
-- vim.g.indent_blankline_char = '┊'
-- vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
-- vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
-- vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Treesitter configuration
require("nvim-treesitter.configs").setup{
}
require 'treesitter_config'

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup()

-- LSP settings
-- local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
-- nvim-cmp setup
require "cmp_config"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
    dockerls = {},
    bashls = {},
    jsonls = {},
    yamlls = {},
    cmake = {},
    --sqlls = {

    --},
    pylsp = {
        configurationSources = {"black"},
        plugins = {
            black = {
                enable = true,
                line_length = 88
            },
            flake8 = {
                enable = false
            },
            pycodestyle = {
                enable = false
            },
            pylint = {
                enable = false
            }
        },
        formatCommand = {"black"}
    }
}
require("lsp-format").setup{
    -- python = {
    --     sync = true,
    --     order = {"black"}
    -- }
}
for lsp, lspsettings in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    settings = lspsettings
  }
end

------------------------------nvim last place
require'nvim-lastplace'.setup{}

-----Shebang commands
vim.g.shebang_commands = {
    py = '/usr/bin/env python3'
}
vim.g.shebang_shells = {
    py = 'python3'
}

-- Trailing and trim whitespace
require('trim').setup({
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  disable = {"markdown"},

  -- if you want to ignore space of top
  patterns = {
    [[%s/\s\+$//e]],
    [[%s/\($\n\s*\)\+\%$//]],
    [[%s/\(\n\n\)\n\+/\1/]],
  },
})

require('nvim-ts-autotag').setup()
require('nvim-autopairs').setup()

-- test plugins

-- require'shade'.setup({
--   overlay_opacity = 75,
--   opacity_step = 1,
--   keys = {
--     brightness_up    = '<C-Up>',
--     brightness_down  = '<C-Down>',
--     toggle           = '<Leader>s',
--   }
-- })

require('incline').setup()
-- require "no_neck_pain_config"
require "evil_lualine_theme"

require('neogit').setup({})

require('toggleterm').setup({
  direction = 'vertical',
  size = function(term)
    if term.direction == "horizontal" then
      return 25
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

-- Transparency
--require("transparent").setup({
--    enable = true,
--    extra_groups = { -- table/string: additional groups that should be cleared
--    -- In particular, when you set it to 'all', that means all available groups
--
--    -- example of akinsho/nvim-bufferline.lua
--    "BufferLineTabClose",
--    "BufferlineBufferSelected",
--    "BufferLineFill",
--    "BufferLineBackground",
--    "BufferLineSeparator",
--    "BufferLineIndicatorSelected",
--    },
--    exclude = {},
--})

require("startup").setup({theme = "evil"})

require "noice_config"

require "config_indent-blankline"
