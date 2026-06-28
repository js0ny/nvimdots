{
  plugins.grug-far = {
    enable = true;
    lazyLoad = {
      enable = false;
      settings = {
        cmd = [
          "GrugFar"
          "GrugFarWithin"
        ];
        keys = [
          {
            key = "<C-S-f>";
            action.__raw = /* lua */ ''
              function()
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                require("grug-far").open({
                  transient = true,
                  prefills = {
                    filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                  },
                })
              end
            '';
            mode = [
              "n"
              "v"
            ];
            desc = "Search and Replace";
          }
          "<leader>fF"
        ];
      };
    };
    settings = {
      headerMaxWidth = 80;
      windowCreationCommand = /* vim */ "rightbelow 40 vsplit";
    };
  };
  keymaps = [
    {
      key = "<C-S-f>";
      action.__raw = /* lua */ ''
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end
      '';
      mode = [
        "n"
        "v"
      ];
      options.desc = "Search and Replace";
    }
    {
      key = "<leader>fF";
      action.__raw = /* lua */ ''
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end
      '';
      mode = [
        "n"
        "v"
      ];
      options.desc = "Search and Replace";
    }
  ];
  extraConfigLuaPre = /* lua */ ''
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('my-grug-far-custom-keybinds', { clear = true }),
      pattern = { 'grug-far' },
      callback = function(args)
        local bufnr = args.buf

        local function close()
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end

        vim.keymap.set({ 'n', 'i' }, '<C-S-f>', close, {
          buffer = bufnr,
        })
      end,
    })
  '';
}
