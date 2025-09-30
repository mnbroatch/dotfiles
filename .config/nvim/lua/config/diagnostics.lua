vim.o.updatetime = 600
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      source = "always",
      focus = false
    })
  end,
})
