-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require('nvim-web-devicons')
require("nvim-surround").setup()
require("bufferline").setup({
  options = {
    show_buffer_icons = true,
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    separator_style = "padded_slant",
    indicator = {
      style = 'underline',
    },
    diagnostics = "nvim_lsp",
    color_icons = true, -- whether or not to add the filetype icon highlights
  },
})

-- git.nvim is the simple clone of the plugin vim-fugitive
require('git').setup()

-- Use treesitter to autoclose and autorename html tag
require('nvim-ts-autotag').setup()

-- A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
require('colorizer').setup()

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
}

All_Servers = {
  "cssls",
  "eslint",
  "gopls",
  "graphql",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "tsserver",
  "yamlls"
}

-- plugin that allows you to easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface --
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = All_Servers,
  automatic_installation = true,
})

require('mason-null-ls').setup({
  ensure_installed = { "stylua", "jq", "jsonlint",  "zsh", "prettierd"}
})

local wk = require("which-key")
wk.register(mappings, opts)

require('Comment').setup()

require("nvim-autopairs").setup()

require('alpha').setup(require'alpha.themes.startify'.config)

require('marks').setup()

-- terminal --
require('toggleterm').setup({
  size = 13,
  open_mapping = [[<c-\>]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
})

require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
  end
})

