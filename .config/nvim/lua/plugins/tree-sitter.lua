return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "css",
      "diff",
      "go",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "proto",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
    },
  },
}

-- return {
--   "nvim-treesitter/nvim-treesitter",
--   ---@type TSConfig
--   opts = {
--     highlight = { enable = true },
--     indent = { enable = true },
--     ensure_installed = {
--       "bash",
--       "c",
--       "css",
--       "go",
--       "html",
--       "javascript",
--       "json",
--       "lua",
--       "luadoc",
--       "luap",
--       "markdown",
--       "markdown_inline",
--       "proto",
--       "python",
--       "query",
--       "regex",
--       "sql",
--       "thrift",
--       "tsx",
--       "typescript",
--       "vim",
--       "vimdoc",
--       "yaml",
--     },
--     incremental_selection = {
--       enable = true,
--       keymaps = {
--         init_selection = "<C-space>",
--         node_incremental = "<C-space>",
--         scope_incremental = false,
--         node_decremental = "<bs>",
--       },
--     },
--   },
--   ---@param opts TSConfig
--   config = function(_, opts)
--     if type(opts.ensure_installed) == "table" then
--       ---@type table<string, boolean>
--       local added = {}
--       opts.ensure_installed = vim.tbl_filter(function(lang)
--         if added[lang] then
--           return false
--         end
--         added[lang] = true
--         return true
--       end, opts.ensure_installed)
--     end
--     require("nvim-treesitter.configs").setup(opts)
--
--     if load_textobjects then
--       -- PERF: no need to load the plugin, if we only need its queries for mini.ai
--       if opts.textobjects then
--         for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
--           if opts.textobjects[mod] and opts.textobjects[mod].enable then
--             local Loader = require("lazy.core.loader")
--             Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
--             local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
--             require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
--             break
--           end
--         end
--       end
--     end
--   end,
-- }
