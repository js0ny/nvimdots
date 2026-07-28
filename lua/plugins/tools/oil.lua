return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  cmd = { 'Oil' }, -- only load when explicitly call `:Oil`
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    default_file_explorer = true,
  },
}
