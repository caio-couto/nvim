return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function nmap(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
        end
        nmap("<leader>gh", function() gs.nav_hunk("next") end, "Next hunk")
        nmap("<leader>gH", function() gs.nav_hunk("prev") end, "Previous hunk")
        nmap("<leader>gp", gs.preview_hunk,                    "Preview hunk")
        nmap("<leader>gr", gs.reset_hunk,                      "Reset hunk")
        nmap("<leader>gs", gs.stage_hunk,                      "Stage hunk")
        nmap("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },
}
