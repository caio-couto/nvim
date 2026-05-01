local map = vim.keymap.set

-- Save / quit
map({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>x", "<cmd>w | bd<cr>", { desc = "Save and close buffer" })

-- Move lines (Alt+Up/Down — VSCode style)
map("n", "<A-Up>",   "<cmd>m .-2<cr>==",       { desc = "Move line up" })
map("n", "<A-Down>", "<cmd>m .+1<cr>==",       { desc = "Move line down" })
map("v", "<A-Up>",   ":m '<-2<cr>gv=gv",       { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv",       { desc = "Move selection down" })
map("i", "<A-Up>",   "<Esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("i", "<A-Down>", "<Esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Better indent in visual (keep selection)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Open KEYMAPS.md (created in Task 16)
map("n", "<leader>?", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/KEYMAPS.md")
end, { desc = "Open keymap reference" })
