return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format buffer" },
    },
    init = function()
      vim.g.disable_autoformat = false
      vim.api.nvim_create_user_command("FormatToggle", function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Format-on-save: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
      end, {})
      vim.keymap.set("n", "<leader>cF", "<cmd>FormatToggle<cr>", { desc = "Toggle format on save" })
    end,
    opts = {
      formatters_by_ft = {
        typescript      = { "biome" },
        typescriptreact = { "biome" },
        javascript      = { "biome" },
        javascriptreact = { "biome" },
        json            = { "biome" },
        jsonc           = { "biome" },
        rust            = { "rustfmt" },
        cs              = { "csharpier" },
        lua             = { "stylua" },
      },
      format_on_save = function(buf)
        if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then return end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    },
  },
}
