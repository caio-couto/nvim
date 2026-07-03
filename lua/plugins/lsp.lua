return {
  -- Mason: install LSP servers / formatters / linters
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    opts = {
      ui = { border = "rounded" },
      -- Registro extra do Crashdummyy: contém o pacote `roslyn` (LSP de C#),
      -- que não existe no registro oficial do Mason.
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
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
      ensure_installed = { "lua_ls", "ts_ls", "biome", "marksman", "tailwindcss" },
      -- Modern path: auto-enable installed servers via `vim.lsp.enable()`.
      -- Exclude `stylua`: it's installed via mason-tool-installer for use as a
      -- formatter (conform.nvim), not as an LSP server.
      -- Exclude `roslyn`: the C# server is managed by roslyn.nvim, not lspconfig.
      automatic_enable = { exclude = { "stylua", "roslyn" } },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "stylua", "biome", "csharpier", "roslyn" },
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
          local code_action = function() vim.cmd("FzfLua lsp_code_actions") end
          map({ "n", "v" }, "<C-.>",      code_action,              "Code action")
          map("n", "<leader>cr", vim.lsp.buf.rename,                 "Rename symbol")
          map({ "n", "v" }, "<leader>ca", code_action,               "Code action")
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

      vim.lsp.config("tailwindcss", {
        -- Only attach in real Tailwind projects — default root_dir falls back
        -- to package.json/.git, which makes it scan every JS workspace.
        root_markers = {
          "tailwind.config.js", "tailwind.config.cjs",
          "tailwind.config.mjs", "tailwind.config.ts",
          "postcss.config.js",  "postcss.config.cjs",
          "postcss.config.mjs", "postcss.config.ts",
        },
        -- Drop the massive default list down to what we actually use.
        filetypes = {
          "html", "css", "scss", "sass", "less",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "vue", "svelte", "astro",
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
