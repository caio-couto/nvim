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
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      theme = "dragon",
      background = { dark = "dragon", light = "lotus" },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")

      -- Clear backgrounds the colorscheme's `transparent` flag misses,
      -- so the terminal background shows through everywhere.
      local function clear_bg()
        local groups = {
          "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
          "SignColumn", "LineNr", "CursorLineNr", "EndOfBuffer", "VertSplit", "WinSeparator",
          "Pmenu", "PmenuSbar", "PmenuThumb", "TelescopeNormal", "TelescopeBorder",
          "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer", "NeoTreeWinSeparator",
          "GitSignsAdd", "GitSignsChange", "GitSignsDelete",
          "DiagnosticVirtualTextError", "DiagnosticVirtualTextWarn",
          "DiagnosticVirtualTextInfo", "DiagnosticVirtualTextHint",
        }
        for _, g in ipairs(groups) do
          vim.api.nvim_set_hl(0, g, { bg = "none" })
        end
      end
      clear_bg()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_bg })
    end,
  },
}
