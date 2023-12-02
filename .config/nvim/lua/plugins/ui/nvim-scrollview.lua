return {
  "dstein64/nvim-scrollview",
  dependencies = {
    "lewis6991/gitsigns.nvim",
  },
  opts = {},
  config = function(_, opts)
    require("scrollview").setup(opts)
    require("scrollview.contrib.gitsigns").setup({
      add_symbol = "│",
      change_symbol = "│",
      delete_symbol = "_",
    })
  end,
}
