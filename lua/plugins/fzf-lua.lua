return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- VSCode-style
      { "<C-p>",       "<cmd>FzfLua files<cr>",            desc = "Find files" },
      { "<C-S-p>",     "<cmd>FzfLua commands<cr>",         desc = "Command palette" },
      -- Leader chains
      { "<leader>ff",  "<cmd>FzfLua files<cr>",            desc = "Find files" },
      { "<leader>fg",  "<cmd>FzfLua live_grep<cr>",        desc = "Live grep" },
      { "<leader>fb",  "<cmd>FzfLua buffers<cr>",          desc = "Buffers" },
      { "<leader>fr",  "<cmd>FzfLua oldfiles<cr>",         desc = "Recent files" },
      { "<leader>fh",  "<cmd>FzfLua helptags<cr>",         desc = "Help tags" },
      { "<leader>fs",  "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>fd",  "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
      { "<leader>fc",  "<cmd>FzfLua commands<cr>",         desc = "Commands" },
      { "<leader>fk",  "<cmd>FzfLua keymaps<cr>",          desc = "Keymaps (live)" },
    },
    opts = {
      "telescope",       -- profile: telescope-like UX
      winopts = {
        height = 0.85,
        width  = 0.85,
        preview = { layout = "vertical", vertical = "down:45%" },
      },
      files = {
        formatter = "path.filename_first",
      },
    },
  },
}
