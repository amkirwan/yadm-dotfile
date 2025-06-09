return {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "stevearc/dressing.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("live_grep_args")
      end,
    },
  },
}
