return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<C-b>",      "<cmd>Neotree toggle<cr>",          desc = "Toggle file explorer" },
      { "<leader>e",  "<cmd>Neotree reveal<cr>",          desc = "Reveal current file" },
    },
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      git_status_async = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        position = "right",
        width = 32,
        mappings = {
          ["<space>"] = "none",      -- free up leader
          ["o"] = "open",
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)

      -- Refresh git status in the tree right after saving any file.
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("NeoTreeGitRefresh", { clear = true }),
        callback = function()
          local ok, events = pcall(require, "neo-tree.events")
          if ok then events.fire_event(events.GIT_EVENT) end
        end,
      })
    end,
  },
}
