return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- current_line_blame = true,
    _signs_staged_enable = true,
    _signs_staged = {
      add = {
        text = "┃",
      },
      change = {
        text = "┃",
      },
      delete = {
        text = "▁",
      },
      topdelete = {
        text = "▔",
      },
      changedelete = {
        text = "~",
      },
      untracked = { text = "|" },
    },

    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")
      map({ "n", "v" }, "<leader>ghs", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Rest Buffer")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>ghtb", gs.toggle_current_line_blame, "Toggle Blame Current Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff This ~")
      map({ "o", "x" }, "<leader>ghi", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}
