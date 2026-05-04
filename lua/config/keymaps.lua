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

-- Keymap reference — show KEYMAPS.md in a floating window
local function open_keymaps_reference()
  local path = vim.fn.stdpath("config") .. "/KEYMAPS.md"
  local lines = vim.fn.readfile(path)

  local width = math.min(100, math.floor(vim.o.columns * 0.85))
  local height = math.floor(vim.o.lines * 0.85)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Keymaps (q to close, e to edit) ",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, nowait = true, desc = "Close" })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, nowait = true, desc = "Close" })
  vim.keymap.set("n", "e", function()
    vim.cmd("close")
    vim.cmd("edit " .. path)
  end, { buffer = buf, nowait = true, desc = "Edit KEYMAPS.md" })
end

vim.api.nvim_create_user_command("Keymaps", open_keymaps_reference, { desc = "Show keymap reference" })

map("n", "<leader>?", open_keymaps_reference, { desc = "Show keymap reference" })
