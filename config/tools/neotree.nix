{
  plugins = {
    mini-icons = {
      enable = true;
      mockDevIcons = true;
    };
    nui.enable = true;
  };
  # disable netrw by letting nvim assumes it has loaded
  globals.loaded_netrw = 1;
  plugins.neo-tree = {
    enable = true;
    settings = {
      use_popups_for_input = false;
      close_if_last_window = false;
      popup_border_style = "rounded";
      enable_git_status = true;
      enable_diagnostics = true;
      filesystem = {
        filtered_items = {
          hide_dotfiles = true;
          hide_gitignored = true;
        };
        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };
        use_libuv_file_watcher = true;
      };
      window.mappings = {
        "l" = "open";
        "h" = "close_node";
        "<C-S-f>" = "fuzzy_finder"; # suppress grug-far
      };
      source_selector = {
        winbar = true;
        statusline = false;
        truncation_character = "…";
      };
    };
  };
  keymaps = [
    {
      key = "<leader>E";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle Neo-tree";
    }
    {
      key = "<leader>ft";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle Neo-tree";
    }
    {
      key = "<C-S-e>";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle Neo-tree";
    }
  ];
  userCommands = {
    Explore = {
      desc = "Open Explorer";
      range = false;
      bang = true;
      command = "<cmd>Neotree toggle<CR>";
    };
  };
}
