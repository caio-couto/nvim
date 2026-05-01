return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<leader>gg", function()
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            float_opts = { border = "rounded" },
            hidden = true,
          })
          lazygit:toggle()
        end, desc = "Lazygit" },
    },
    opts = {
      shade_terminals = true,
      direction = "float",
      float_opts = { border = "rounded" },
    },
  },
}
