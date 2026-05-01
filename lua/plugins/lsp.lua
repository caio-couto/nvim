return {
  -- Mason: install LSP servers / formatters / linters
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "lua_ls", "ts_ls", "biome" },
      -- Modern path: auto-enable installed servers via `vim.lsp.enable()`.
      -- Exclude `stylua`: it's installed via mason-tool-installer for use as a
      -- formatter (conform.nvim), not as an LSP server.
      automatic_enable = { exclude = { "stylua" } },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "stylua", "biome" },
      auto_update = false,
      run_on_start = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic UI
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
      })

      -- LspAttach: keymaps wired only for buffers with an LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end
          map("n", "gd",        vim.lsp.buf.definition,     "Go to definition")
          map("n", "gD",        vim.lsp.buf.declaration,    "Go to declaration")
          map("n", "gi",        vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gr",        vim.lsp.buf.references,     "References")
          map("n", "K",         vim.lsp.buf.hover,          "Hover")
          map("n", "[d",        function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
          map("n", "]d",        function() vim.diagnostic.jump({ count =  1 }) end, "Next diagnostic")
          map("n", "<F2>",      vim.lsp.buf.rename,         "Rename symbol")
          map("n", "<F12>",     vim.lsp.buf.definition,     "Go to definition")
          map("n", "<S-F12>",   vim.lsp.buf.references,     "References")
          map({ "n", "v" }, "<C-.>",      vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>cr", vim.lsp.buf.rename,        "Rename symbol")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
          map("n", "<leader>cs", vim.lsp.buf.document_symbol, "Document symbols")
          -- <leader>cf is set globally by conform.nvim's keys
        end,
      })

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = { command = "clippy" },
            procMacro = { enable = true },
          },
        },
      })

      -- ts_ls and biome use defaults; mason-lspconfig auto-enables them
      -- (automatic_enable = true) so no vim.lsp.config / enable needed here.

      -- rust_analyzer is installed via `rustup component add rust-analyzer`,
      -- not mason — enable it explicitly so it attaches.
      vim.lsp.enable("rust_analyzer")
    end,
  },
}
