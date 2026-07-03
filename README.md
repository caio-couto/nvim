# Configuração do Neovim

Configuração pessoal do Neovim, escrita em Lua e organizada em módulos. O foco
é ter um editor rápido, com atalhos no estilo do VSCode por cima dos padrões do
Vim, e suporte completo de LSP, formatação e realce de sintaxe para as
linguagens que uso no dia a dia.

Os plugins são gerenciados pelo [lazy.nvim](https://github.com/folke/lazy.nvim),
que se instala sozinho na primeira vez que o Neovim abre. Servidores de LSP,
formatadores e linters são baixados automaticamente pelo
[Mason](https://github.com/mason-org/mason.nvim) — você não precisa instalar
nenhum deles na mão.

## Linguagens com suporte

| Linguagem | LSP | Formatação |
|---|---|---|
| C# / .NET | roslyn | CSharpier |
| TypeScript / JavaScript | ts_ls + biome | Biome |
| Rust | rust-analyzer | rustfmt |
| Lua | lua_ls | StyLua |
| Markdown | marksman | — |
| HTML / CSS + Tailwind | tailwindcss | Biome |

O realce de sintaxe usa [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter),
que também baixa os parsers sozinho conforme necessário.

## Dependências

Instale estes programas antes de abrir o Neovim pela primeira vez. Sem eles,
partes da configuração simplesmente não funcionam.

### Obrigatórias

- **Neovim 0.12 ou superior** — a configuração usa APIs novas de LSP e
  diagnóstico que não existem em versões anteriores.
- **git** — usado pelo lazy.nvim para baixar os plugins.
- **Um compilador C** (`gcc`, `clang` ou equivalente) e **make** — o Treesitter
  compila os parsers localmente.
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** (`rg`) — busca por
  conteúdo (grep) usada pelo fzf-lua.
- **[fzf](https://github.com/junegunn/fzf)** — motor de busca fuzzy.
- **unzip** — o Mason usa para descompactar as ferramentas que baixa (sem ele,
  a instalação de vários servidores/formatadores falha silenciosamente).
- **Uma Nerd Font** — para os ícones aparecerem corretamente. Configure seu
  terminal para usá-la.

### Por linguagem

Instale apenas as que você for usar de fato.

- **C# / .NET:** o **.NET SDK** (uso o **SDK 10**), com o comando `dotnet` no
  `PATH`. Além do SDK, o formatador CSharpier precisa do **runtime ASP.NET Core**
  (`aspnet-runtime`) — só o SDK base não basta. No Arch, casando com o SDK 10:
  `sudo pacman -S aspnet-runtime-10.0`. O servidor de LSP (roslyn) e o CSharpier
  são instalados pelo Mason automaticamente.
- **TypeScript / JavaScript / Tailwind:** **Node.js** — necessário para os
  servidores de LSP (ts_ls, biome, tailwindcss).
- **Rust:** instale via **[rustup](https://rustup.rs/)** e adicione o
  rust-analyzer com `rustup component add rust-analyzer`. Diferente dos outros,
  ele não vem pelo Mason.

## Instalação

1. Faça backup da sua configuração atual, se tiver uma:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone este repositório:

   ```bash
   git clone <url-do-repositorio> ~/.config/nvim
   ```

3. Abra o Neovim. O lazy.nvim baixa os plugins e o Mason instala as ferramentas
   na primeira execução:

   ```bash
   nvim
   ```

4. Aguarde a instalação terminar, reinicie o Neovim e pronto.

Você pode verificar o estado das ferramentas com `:Mason`, os plugins com
`:Lazy` e a saúde geral com `:checkhealth`.

## Estrutura

```
init.lua              Ponto de entrada; carrega os módulos de config
lua/config/           Opções, atalhos, autocomandos e setup do lazy.nvim
lua/plugins/          Um arquivo por plugin (ou grupo de plugins)
KEYMAPS.md            Referência de todos os atalhos
```

Os atalhos estão documentados em [KEYMAPS.md](KEYMAPS.md). Dentro do editor,
pressione `<leader>fk` (leader é a barra de espaço) para uma lista pesquisável
de todos os atalhos ativos.
