    local limes_previous_ascii_mode = nil

    local function limes_run(method, ...)
      local limes = ${lib.getExe limes}
      local args = {
        limes,
        '--backend',
        'fcitx5-rime',
        '--mode',
        'ascii',
        method
      }
      vim.list_extend(args, { ... })

      return vim.fn.system(args)
    end

    local is_ssh = vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil

    local function limes_get_ascii_mode()
        local output = limes_run('get')
        -- busctl output example: "b true\n" or "b false\n"
        if output:match('true') then
        return true
        elseif output:match('false') then
        return false
        end
        return nil
    end

    local function limes_set_ascii_mode(enabled)
      limes_run("set", {tostring(enabled)})
    end

    local function limes_switch_to_en()
      limes_previous_ascii_mode = limes_get_ascii_mode()

      if limes_previous_ascii_mode ~= nil then
        limes_set_ascii_mode(true)
      end
    end

    local function limes_restore_layout()
      if limes_previous_ascii_mode ~= nil then
        limes_set_ascii_mode(limes_previous_ascii_mode)
      end
    end

    vim.opt.ttimeoutlen = 150

    if not is_ssh then
      local group = vim.api.nvim_create_augroup('InputMethod', { clear = true })

      vim.api.nvim_create_autocmd('InsertLeave', {
        group = group,
        callback = limes_switch_to_en,
      })

      vim.api.nvim_create_autocmd('InsertEnter', {
        group = group,
        callback = limes_restore_layout,
      })
    end
