return {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("live_grep_args")
      end,
    },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    keys = {
      {
        "<leader>sxg",
        ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "live grep w/ args",
      },
    },
  },
}
