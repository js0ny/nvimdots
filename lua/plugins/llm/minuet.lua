local utils = require('core.utils')
return {
  'milanglacier/minuet-ai.nvim',
  event = 'InsertEnter',
  enabled = false,
  cmd = { 'Minuet' },
  opts = {
    provider = 'openai_fim_compatible',
    provider_options = {
      -- TODO:
      openai_fim_compatible = {
        api_key = function()
          return ''
          -- return utils.system_with_env({})
        end,
        name = 'deepseek',
        optional = {
          max_tokens = 256,
          top_p = 0.9,
        },
      },
    },
  },
}
