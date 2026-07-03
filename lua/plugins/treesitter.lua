return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"markdown",
				"markdown_inline",
				"tsx",
				"typescript",
				"javascript",
				"rust",
				"c_sharp",
				"toml",
				"json",
				"yaml",
				"html",
				"css",
				"regex",
				"diff",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			local q = vim.treesitter.query
			local function first_node(captured)
				if not captured then
					return nil
				end
				return type(captured) == "table" and captured[1] or captured
			end

			q.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
				local node = first_node(match[pred[2]])
				if not node then
					return
				end
				local alias = vim.treesitter.get_node_text(node, bufnr):lower()
				local aliases = { js = "javascript", ts = "typescript", py = "python", rs = "rust", sh = "bash" }
				metadata["injection.language"] = aliases[alias] or alias
			end, { force = true, all = false })

			q.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
				local node = first_node(match[pred[2]])
				if not node then
					return
				end
				local mime = vim.treesitter.get_node_text(node, bufnr)
				local parts = vim.split(mime, "/", {})
				metadata["injection.language"] = parts[#parts]
			end, { force = true, all = false })
		end,
	},
}
