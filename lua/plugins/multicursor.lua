return {
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      -- Disable default mappings — we override only the ones we want.
      vim.g.VM_default_mappings = 0

      vim.g.VM_maps = {
        -- VSCode-style: cursor on word + Ctrl+D = select word; press again = next match
        ["Find Under"]         = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        -- Skip current occurrence, jump to next (VSCode: Ctrl+K Ctrl+D)
        ["Skip Region"]        = "<C-x>",
        -- Add cursor on the line above/below
        ["Add Cursor Up"]      = "<C-S-Up>",
        ["Add Cursor Down"]    = "<C-S-Down>",
        -- Select every match in the buffer (VSCode: Ctrl+Shift+L)
        ["Select All"]         = "<C-S-l>",
      }

      -- Quieter exit (no "exited from VM mode" message)
      vim.g.VM_silent_exit = 1
    end,
  },
}
