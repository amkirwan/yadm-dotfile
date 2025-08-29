return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  tag = "v1.10.0", -- Pin to v1.10 to avoid a breaking change in V1.11 API
  opts = {
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      bufferline = true,
      flash = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
    transparent_background = false,
    custom_highlights = function(colors)
      return {
        FlashLabel = { fg = colors.crust, bg = colors.mauve, style = { "bold" } },
        TreesitterContext = { link = "Headline6", default = true },
        TreesitterContextBottom = { sp = colors.dim, style = { "underline" } },
      }
    end,
  },
}
