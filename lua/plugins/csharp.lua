return {
  -- Suporte a C# / .NET via Roslyn (Microsoft.CodeAnalysis.LanguageServer).
  -- O servidor `roslyn` é instalado pelo Mason (registro do Crashdummyy, ver
  -- lsp.lua). Este plugin cuida de iniciar e anexar o LSP nos buffers `.cs`;
  -- por isso ele fica de fora do `automatic_enable` do mason-lspconfig.
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    opts = {
      -- Opções do próprio plugin. Padrões já funcionam bem; deixe vazio.
    },
    config = function(_, opts)
      -- `capabilities` (nvim-cmp) e os keymaps de LSP vêm do setup global
      -- em lsp.lua (`vim.lsp.config("*")` + autocmd LspAttach), então aqui
      -- só configuramos o que é específico do Roslyn.
      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
        },
      })

      require("roslyn").setup(opts)
    end,
  },
}
