# Referência de Atalhos

Leader: `<Espaço>`. Pressione `<leader>fk` para uma lista pesquisável (fuzzy) de todos os atalhos ativos no nvim em tempo real.

## Estilo VSCode

| Tecla | Ação |
|---|---|
| `Ctrl+P` | Buscar arquivos |
| `Ctrl+Shift+P` | Paleta de comandos |
| `Ctrl+B` | Alternar explorador de arquivos |
| `Ctrl+S` | Salvar |
| `Ctrl+/` | Alternar comentário |
| `Ctrl+.` | Ação de código |
| `F2` | Renomear |
| `F12` | Ir para definição |
| `Shift+F12` | Referências |
| `Alt+Cima` / `Alt+Baixo` | Mover linha |

## Padrões do Vim preservados

`hjkl`, `w/b/e`, `f/t`, `gg/G`, `0/$`, `%`, `/`, `?`, `n/N`, `:w`, `:q`, `Ctrl+W h/j/k/l` (janelas), `Ctrl+F`/`Ctrl+B` (página), `Ctrl+D`/`Ctrl+U` (meia página), `Ctrl+O`/`Ctrl+I` (jumplist).

## `<leader>f` — buscar (fzf-lua)

| Tecla | Ação |
|---|---|
| `<leader>ff` | Buscar arquivos |
| `<leader>fg` | Grep em tempo real |
| `<leader>fb` | Buffers abertos |
| `<leader>fr` | Arquivos recentes |
| `<leader>fh` | Tags de ajuda |
| `<leader>fs` | Símbolos do workspace |
| `<leader>fd` | Diagnósticos |
| `<leader>fc` | Comandos |
| `<leader>fk` | Atalhos (em tempo real) |

## `<leader>g` — git

| Tecla | Ação |
|---|---|
| `<leader>gg` | Lazygit |
| `<leader>gb` | Blame da linha |
| `<leader>gh` / `<leader>gH` | Próximo / anterior hunk |
| `<leader>gp` | Pré-visualizar hunk |
| `<leader>gr` | Resetar hunk |
| `<leader>gs` | Stage do hunk |

## `<leader>c` — código (LSP)

| Tecla | Ação |
|---|---|
| `<leader>cr` | Renomear |
| `<leader>ca` | Ação de código |
| `<leader>cf` | Formatar buffer |
| `<leader>cF` | Alternar formatação ao salvar |
| `<leader>cd` | Mostrar diagnóstico (flutuante) |
| `<leader>cs` | Símbolos do documento |

## `<leader>h` — harpoon

| Tecla | Ação |
|---|---|
| `<leader>ha` | Adicionar arquivo |
| `<leader>hh` | Alternar menu rápido |
| `<leader>1` … `<leader>4` | Saltar para arquivo fixado 1-4 |
| `<leader>hn` / `<leader>hp` | Próximo / anterior |

## `<leader>e` — explorador

| Tecla | Ação |
|---|---|
| `<leader>e` | Revelar arquivo atual no neo-tree |
| `Ctrl+B` | Alternar neo-tree |

## Rápidos

| Tecla | Ação |
|---|---|
| `<leader>w` | Salvar |
| `<leader>q` | Sair |
| `<leader>x` | Salvar e fechar buffer |
| `<leader>?` | Abrir este arquivo |

## LSP (automático, quando há LSP anexado)

| Tecla | Ação |
|---|---|
| `gd` | Definição |
| `gD` | Declaração |
| `gi` | Implementação |
| `gr` | Referências |
| `K` | Hover (documentação ao passar) |
| `[d` / `]d` | Diagnóstico anterior / próximo |

## Treesitter textobjects

| Tecla | Seleciona |
|---|---|
| `af` / `if` | Função (externo/interno) |
| `ac` / `ic` | Classe (externo/interno) |
| `aa` / `ia` | Parâmetro (externo/interno) |
| `]f` / `[f` | Próximo / anterior início de função |
| `]c` / `[c` | Próxima / anterior início de classe |

## Multi-cursor (vim-visual-multi)

Funciona em modo normal e visual. `Ctrl+D` é a tecla principal — comportamento idêntico ao VSCode.

| Tecla | Ação |
|---|---|
| `Ctrl+D` | Selecionar palavra sob cursor (1ª vez) / adicionar próxima ocorrência (subsequentes) |
| `Ctrl+x` | Pular ocorrência atual e ir para a próxima |
| `Ctrl+Shift+Cima` / `Ctrl+Shift+Baixo` | Adicionar cursor uma linha acima / abaixo |
| `Ctrl+Shift+L` | Selecionar todas as ocorrências da palavra |
| `Esc` | Sair do modo multi-cursor |

Dentro do modo multi-cursor você pode editar normalmente — qualquer comando do Vim (`c`, `d`, `i`, `a`, `~`, etc.) é replicado em todos os cursores. Para mais comandos de navegação/edição, veja `:h visual-multi`.

## Surround (mini.surround)

| Tecla | Ação |
|---|---|
| `sa{movimento}{char}` | Adicionar surround (cercar) |
| `sd{char}` | Remover surround |
| `sr{antigo}{novo}` | Substituir surround |

## Navegação entre buffers sem abas visíveis

- `<leader>fb` — seletor fuzzy de buffers
- `<leader>1`-`<leader>4` — teleporte via Harpoon
- `Ctrl+^` (padrão do Vim) — alternar entre os dois buffers mais recentes
