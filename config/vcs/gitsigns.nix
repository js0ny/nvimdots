{
  plugins.gitsigns = {
    enable = true;
    settings = {
      current_line_blame = false;
      on_attach = /* lua */ ''
        function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          map('n', 'q', function()
            vim.api.nvim_buf_delete(bufnr, { force = true })
          end)
        end
      '';
    };
  };
  keymaps = [
    {
      key = "<leader>gb";
      action = "<cmd>Gitsigns blame<CR>";
      options.desc = "Blame file";
    }
    {
      key = "<leader>tb";
      action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
      options.desc = "Toggle line blame";
    }
    {
      key = "[g";
      action = "<cmd>Gitsigns prev_hunk<CR>";
      options.desc = "Prev hunk";
    }
    {
      key = "]g";
      action = "<cmd>Gitsigns next_hunk<CR>";
      options.desc = "Next hunk";
    }
  ];
}
