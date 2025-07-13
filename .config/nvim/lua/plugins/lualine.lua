return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, {
      require("tmux-status").tmux_windows,
      cond = require("tmux-status").show,
      padding = { left = 3 },
    })
    table.insert(opts.sections.lualine_z, {
      require("tmux-status").tmux_session,
      cond = require("tmux-status").show,
      padding = { left = 3 },
    })
  end,
}
