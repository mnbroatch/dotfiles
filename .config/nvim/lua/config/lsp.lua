local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript' },
  callback = function(args)
    local buf = args.buf
    local root = vim.fs.dirname(vim.fs.find({ 'tsconfig.json', 'package.json' }, { upward = true })[1])
    if not root then
      root = vim.fn.getcwd()
    end

    vim.lsp.start({
      name = 'tsserver',
      cmd = { 'typescript-language-server', '--stdio' },
      root_dir = root,
      on_attach = on_attach,
      bufnr = buf,
    })
  end,
})
