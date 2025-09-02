return {
  "dense-analysis/ale",
  init = function () 
    vim.g.ale_virtualtext_cursor = 0
    vim.g.ale_fixers = {
      javascript = {'eslint'}
    }
    vim.g.ale_completion_enabled = 1
  end
}
