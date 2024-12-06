return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- hide clock from statusline, it's already in tmux
      opts.sections.lualine_z = {}
    end,
  },
}
