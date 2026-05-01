local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked region briefly
autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),

  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("TrimTrailingWhitespace", { clear = true }),
  pattern = "*",

  callback = function()
    if not vim.bo.modifiable or vim.bo.readonly then return end
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Restore cursor position when reopening a file
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),

  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-close terminal buffer when process exits
autocmd("TermClose", {
  group = augroup("TerminalAutoClose", { clear = true }),
  
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})
