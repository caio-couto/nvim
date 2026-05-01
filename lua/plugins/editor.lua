return {
  -- Comments (gc, gcc, Ctrl+/)
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc",  mode = { "n", "v" }, desc = "Comment" },
      { "gcc", desc = "Comment line" },
      { "<C-/>", function() require("Comment.api").toggle.linewise.current() end, desc = "Toggle comment" },
      { "<C-/>", "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "Toggle comment" },
    },
    opts = {},
  },

  -- Auto-pairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Surround (sa = add, sd = delete, sr = replace)
  {
    "echasnovski/mini.surround",
    keys = {
      { "sa", mode = { "n", "v" }, desc = "Add surround" },
      { "sd", desc = "Delete surround" },
      { "sr", desc = "Replace surround" },
    },
    opts = {
      mappings = {
        add            = "sa",
        delete         = "sd",
        replace        = "sr",
        find           = "",
        find_left      = "",
        highlight      = "",
        update_n_lines = "",
      },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
      exclude = {
        filetypes = { "help", "lazy", "mason", "neo-tree", "TelescopePrompt" },
      },
    },
  },
}
