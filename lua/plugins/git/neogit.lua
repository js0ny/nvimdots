return {
  'NeogitOrg/neogit',
  config = true,
  dependencies = {
    'esmuellert/codediff.nvim',
  },
  cmd = {
    'Neogit',
  },
  keys = {
    { '<leader>gg', '<Cmd>Neogit<CR>', desc = 'Neogit' },
    { '<C-S-g>', '<Cmd>Neogit<CR>', desc = 'Neogit' },
  },
  opts = {
    console_timeout = 0,
    status = {
      mode_text = {
        M = '[M] modified',
        N = '[N] new file',
        A = '[A] added',
        D = '[D] deleted',
        C = '[C] copied',
        U = '[U] updated',
        R = '[R] renamed',
        T = '[T] changed',
        DD = '[DD] unmerged',
        AU = '[AU] unmerged',
        UD = '[UD] unmerged',
        UA = '[UA] unmerged',
        DU = '[DU] unmerged',
        AA = '[AA] unmerged',
        UU = '[UU] unmerged',
        ['?'] = '',
      },
    },
  },
}
