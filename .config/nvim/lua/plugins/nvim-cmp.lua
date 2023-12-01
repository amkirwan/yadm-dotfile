return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind.nvim",
    {
      "zbirenbaum/copilot-cmp",
      dependencies = "copilot.lua",
      opts = {},
      config = function(_, opts)
        local copilot_cmp = require("copilot_cmp")
        copilot_cmp.setup(opts)
        -- attach cmp source whenever copilot attaches
        -- fixes lazy-loading issues with the copilot cmp source
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "copilot" then
            copilot_cmp._on_insert_enter({})
          end
        end)
      end,
    },
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- this way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    opts.snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    }

    opts.sources = {
      { name = "path" },
      { name = "copilot", priority = 100, group_index = 1 },
      { name = "nvim_lsp", keyword_length = 1 },
      { name = "buffer", keyword_length = 3 },
      { name = "luasnip", keyword_length = 2 },
    }

    opts.window = {
      documentation = cmp.config.window.bordered(),
    }

    opts.formatting = {
      fields = { "menu", "abbr", "kind" },
      format = function(entry, item)
        local menu_icon = {
          copilot = "",
          nvim_lsp = "λ",
          luasnip = "Σ",
          buffer = "β",
          path = "🖫",
        }

        lspkind.cmp_format({
          mode = "symbol", -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function(_, vim_item)
            return vim_item
          end,
        })

        item.menu = menu_icon[entry.source.name]
        return item
      end,
    }
  end,
}
