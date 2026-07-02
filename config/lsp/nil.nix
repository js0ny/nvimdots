{
  plugins.lsp.servers.nil_ls = {
    enable = true;
    onAttach.function = /* lua */ ''
      if client.name == 'nil_ls' then
        client.server_capabilities.definitionProvider = false -- use nixd
        client.server_capabilities.renameProvider = false -- use nixd
      end
    '';
  };
}
