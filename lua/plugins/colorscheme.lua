return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = false },
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      theme = "dragon",
      background = { dark = "dragon", light = "lotus" },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
