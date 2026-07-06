local busctl = vim.fn.exepath('busctl')

if busctl == '' then
  return
end

local previous_ascii_mode = nil

local rime_bus = 'org.fcitx.Fcitx5'
local rime_path = '/rime'
local rime_iface = 'org.fcitx.Fcitx.Rime1'

local function dbus_call(method, ...)
  local args = {
    busctl,
    '--user',
    'call',
    rime_bus,
    rime_path,
    rime_iface,
    method,
  }

  vim.list_extend(args, { ... })

  return vim.fn.system(args)
end

local function get_ascii_mode()
  local output = dbus_call('IsAsciiMode')
  -- busctl output example: "b true\n" or "b false\n"
  if output:match('true') then
    return true
  elseif output:match('false') then
    return false
  end
  return nil
end

local function set_ascii_mode(enabled)
  dbus_call('SetAsciiMode', 'b', enabled and 'true' or 'false')
end

local function switch_to_en()
  previous_ascii_mode = get_ascii_mode()

  if previous_ascii_mode ~= nil then
    set_ascii_mode(true)
  end
end

local function restore_layout()
  if previous_ascii_mode ~= nil then
    set_ascii_mode(previous_ascii_mode)
  end
end

vim.opt.ttimeoutlen = 150

local group = vim.api.nvim_create_augroup('InputMethod', { clear = true })

vim.api.nvim_create_autocmd('InsertLeave', {
  group = group,
  callback = switch_to_en,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  group = group,
  callback = restore_layout,
})
