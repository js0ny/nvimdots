vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
-- Ignore the user lua configuration
vim.opt.runtimepath:remove(vim.fn.stdpath("config")) -- ~/.config/nvim
vim.opt.runtimepath:remove(vim.fn.stdpath("config") .. "/after") -- ~/.config/nvim/after

-- Nixvim's internal module table
-- Can be used to share code throughout init.lua
local _M = {}

-- Set up global options {{{
do
    local nixvim_global_options = { clipboard = "unnamedplus", formatexpr = "v:lua.require'conform'.formatexpr()" }

    for k, v in pairs(nixvim_global_options) do
        vim.opt_global[k] = v
    end
end
-- }}}

-- Set up globals {{{
do
    local nixvim_globals = {
        autoformat = true,
        bullets_custom_mappings = { { "imap", "<M-CR>", "<Plug>(bullets-newline)" } },
        bullets_enabled_file_types = { "markdown", "gitcommit", "typst" },
        bullets_set_mappings = 0,
        loaded_netrw = 1,
        mapleader = " ",
        maplocalleader = "\\",
    }

    for k, v in pairs(nixvim_globals) do
        vim.g[k] = v
    end
end
-- }}}

-- Set up options {{{
do
    local nixvim_options = {
        autoindent = true,
        cmdheight = 0,
        conceallevel = 2,
        confirm = true,
        cursorline = true,
        encoding = "utf-8",
        expandtab = true,
        exrc = true,
        fileencoding = "utf-8",
        foldenable = true,
        foldexpr = "v:lua.vim.treesitter.foldexpr()",
        foldlevel = 99,
        foldlevelstart = 99,
        foldmethod = "expr",
        foldtext = "v:lua.ConfigFoldText()",
        grepformat = "%f:%l:%c:%m",
        grepprg = "/nix/store/axp6zlky4x2v3jwcbq24a2cz25hzlw9b-ripgrep-15.2.0/bin/rg --vimgrep --no-heading --smart-case",
        ignorecase = true,
        laststatus = 3,
        linebreak = true,
        mouse = "a",
        mousemoveevent = true,
        number = true,
        relativenumber = true,
        scrolloff = 5,
        shiftround = true,
        shiftwidth = 4,
        sidescrolloff = 10,
        smartcase = true,
        smartindent = false,
        tabstop = 4,
        termguicolors = true,
    }

    for k, v in pairs(nixvim_options) do
        vim.opt[k] = v
    end
end
-- }}}

require("lz.n").load({
    {
        "nvim-ts-autotag",
        after = function()
            require("nvim-ts-autotag").setup({})
        end,
        ft = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "xml" },
    },
    {
        "todo-comments.nvim",
        after = function()
            require("todo-comments").setup({})
        end,
        cmd = { "TodoTrouble", "TodoQuickFix", "TodoLocList" },
        event = { "BufRead" },
    },
    {
        "render-markdown.nvim",
        after = function()
            require("render-markdown").setup({
                bullet = { icons = { "󰮯 ", "● ", "○ ", "◆ ", "◇ " } },
                code = { position = "right", right_pad = 10, width = "block" },
                file_types = { "markdown", "Avante" },
                latex = {
                    bottom_pad = 0,
                    converter = "latex2text",
                    enabled = false,
                    highlight = "RenderMarkdownMath",
                    top_pad = 0,
                },
                link = {
                    custom = {
                        lua = { icon = " ", pattern = "%.lua" },
                        markdown = { icon = " ", pattern = "%.md" },
                        nix = { icon = "󱄅 ", pattern = "%.nix" },
                        python = { icon = " ", pattern = "%.py" },
                        rust = { icon = " ", pattern = "%.rust" },
                    },
                },
                render_modes = { "n", "c", "t" },
            })
        end,
        event = { "BufRead" },
        ft = { "markdown", "Avante" },
    },
    {
        "orgmode",
        after = function()
            require("orgmode").setup({})
        end,
        ft = { "org" },
    },
    {
        "oil.nvim",
        after = function()
            require("oil").setup({ default_file_explorer = false, delete_to_trash = true })
        end,
        cmd = { "Oil" },
    },
    {
        "neogit",
        after = function()
            require("neogit").setup({})
        end,
        cmd = "Neogit",
    },
    {
        "multicursors.nvim",
        after = function()
            require("multicursors").setup({
                DEBUG_MODE = true,
                create_commands = false,
                hint_config = { position = "top", type = "cmdline" },
                normal_keys = {
                    [","] = {
                        method = require("multicursors.normal_mode").clear_others,
                        opts = { desc = "Clear others" },
                    },
                },
            })
        end,
        event = { "InsertEnter" },
    },
    {
        "luasnip",
        after = function()
            require("luasnip").config.setup({ enable_autosnippets = true, history = true })

            require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/lsp-snippets" })
        end,
        event = { "InsertEnter" },
    },
    {
        "img-clip.nvim",
        after = function()
            require("img-clip").setup({
                default = {
                    drag_and_drop = { insert_mode = true },
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    use_absolute_path = true,
                },
            })
        end,
        cmd = { "PasteImage" },
        ft = { "avante", "markdown", "typst", "org", "tex" },
        keys = { "<localleader>p" },
    },
    {
        "conform.nvim",
        after = function()
            require("conform").setup({
                default_format_opts = { lsp_format = "fallback" },
                format_on_save = function(bufnr)
                    -- Disable with a global or buffer-local variable
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_format = "fallback" }
                end,
                formatters = { nixfmt = { args = { "-" } }, shfmt = { prepend_args = { "-i", "2" } } },
                formatters_by_ft = {
                    bash = { "shfmt" },
                    json = { "jq" },
                    jsonc = { "prettierd", "prettier", stop_after_first = true },
                    lua = { "stylua" },
                    nix = { "nixfmt", "keep-sorted" },
                    nu = { "nufmt" },
                    python = { "ruff", "black" },
                    sh = { "shfmt" },
                },
            })
        end,
        before = function()
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format({ async = true, lsp_format = "fallback", range = range })
            end, { range = true })

            vim.api.nvim_create_user_command("FormatToggle", function(args)
                local buffer_local = args.bang
                if buffer_local then
                    vim.b.disable_autoformat = not vim.b.disable_autoformat
                else
                    vim.g.disable_autoformat = not vim.g.disable_autoformat
                end

                local scope = buffer_local and "buffer" or "global"
                local status = buffer_local and vim.b.disable_autoformat or vim.g.disable_autoformat
                print(string.format("Format-on-save %s: %s", scope, status and "disabled" or "enabled"))
            end, {
                desc = "Toggle autoformat-on-save (use ! for buffer-local)",
                bang = true,
            })
        end,
        cmd = { "ConformInfo", "Format", "FormatToggle" },
        event = { "BufWritePre" },
    },
    {
        "codediff.nvim",
        after = function()
            require("codediff").setup({
                explorer = { position = "left" },
                highlights = { line_delete = "DiffDelete", line_insert = "DiffAdd" },
                keymaps = { view = { toggle_stage = "s" } },
            })
        end,
        cmd = { "CodeDiff" },
    },
    { "bullets.vim", ft = { "markdown", "gitcommit", "typst" } },
})
require("kanagawa").setup({})

vim.diagnostic.config({
    float = true,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.ERROR] = "",
        },
    },
    update_in_insert = true,
    virtual_lines = false,
    virtual_text = true,
})

function _G.ConfigFoldText()
    local hidden_count = vim.v.foldend - vim.v.foldstart
    local parts = { { vim.fn.getline(vim.v.foldstart), "ConfigFoldPreview" } }
    local end_text = vim.trim(vim.fn.getline(vim.v.foldend))
    if end_text ~= "" then
        table.insert(parts, { " ⋯ ", "ConfigFoldMuted" })
        table.insert(parts, { end_text, "ConfigFoldPreview" })
    end

    table.insert(parts, { "   ↙️ [" .. hidden_count .. " lines hidden]", "ConfigFoldTail" })
    return parts
end

local function wincmd_smart_split(func, reverse)
    local width = vim.api.nvim_win_get_width(0)
    if width > 80 and not reverse then
        vim.api.nvim_command("vsp")
    else
        vim.api.nvim_command("sp")
    end
    func()
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("my-grug-far-custom-keybinds", { clear = true }),
    pattern = { "grug-far" },
    callback = function(args)
        local bufnr = args.buf

        local function close()
            vim.api.nvim_buf_delete(bufnr, { force = true })
        end

        vim.keymap.set({ "n", "i" }, "<C-S-f>", close, {
            buffer = bufnr,
        })
    end,
})

vim.cmd([[colorscheme kanagawa
]])
require("mini.icons").setup({})

MiniIcons.mock_nvim_web_devicons()

require("which-key").setup({ preset = "modern" })

require("typst-preview").setup({
    dependencies_bin = {
        tinymist = "/nix/store/mpdcjcaxcdy8wr9r4j3prmrs3yixs5aj-tinymist-0.15.2/bin/tinymist",
        websocat = "/nix/store/rs33sxr2ia8p0nv3cfvmwzxqd7p0dx7h-websocat-1.14.0/bin/websocat",
    },
})

require("trouble").setup({})

require("treesj").setup({ use_default_keymaps = false })

require("treesitter-context").setup({ max_lines = 5, mode = "topline" })

-- Create autogroup for treesitter autocmds
local augroup = vim.api.nvim_create_augroup("nixvim_treesitter", { clear = true })

-- Detect nvim-treesitter API
local has_configs_module = pcall(require, "nvim-treesitter.configs")

if has_configs_module then
    require("nvim-treesitter.configs").setup({
        textobjects = {
            enable = true,
            lookahead = true,
            move = { set_jumps = true },
            select = { include_surrounding_whitespace = true, lookahead = true },
        },
    })
    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "*",
        callback = function(args)
            local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
            if not lang or not vim.treesitter.language.add(lang) or not vim.treesitter.query.get(lang, "folds") then
                return
            end

            local disabled = {}
            if type(disabled) == "function" and disabled(lang, args.buf, vim.bo[args.buf].filetype) then
                return
            elseif
                type(disabled) == "table"
                and (vim.list_contains(disabled, lang) or vim.list_contains(disabled, vim.bo[args.buf].filetype))
            then
                return
            end

            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"
        end,
    })
else
    require("nvim-treesitter").setup({
        textobjects = {
            enable = true,
            lookahead = true,
            move = { set_jumps = true },
            select = { include_surrounding_whitespace = true, lookahead = true },
        },
    })

    -- Enable features via an autocommand for modern nvim-treesitter
    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "*",
        callback = function(args)
            local buf = args.buf
            local filetype = vim.bo[buf].filetype
            local lang = vim.treesitter.language.get_lang(filetype)
            if not lang then
                return
            end
            local has_parser = vim.treesitter.language.add(lang)
            if not has_parser then
                return
            end

            local function has_query(query_name)
                return vim.treesitter.query.get(lang, query_name) ~= nil
            end

            local function add_undo_ftplugin(command)
                vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. " | " or "") .. command
            end

            local function is_disabled(disabled)
                if type(disabled) == "function" then
                    return disabled(lang, buf, filetype)
                elseif type(disabled) == "table" then
                    for _, disabled_language in ipairs(disabled) do
                        if disabled_language == lang or disabled_language == filetype then
                            return true
                        end
                    end
                end

                return false
            end

            local disabled_highlight = {}
            if has_query("highlights") and not is_disabled(disabled_highlight) then
                vim.treesitter.start(buf, lang)
                add_undo_ftplugin(("call v:lua.vim.treesitter.stop(%d)"):format(buf))

                local vim_syntax = false
                if vim_syntax == true or is_disabled(vim_syntax) then
                    vim.bo[buf].syntax = "ON"
                end
            end
            local disabled_indent = {}
            if has_query("indents") and not is_disabled(disabled_indent) then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                add_undo_ftplugin("setlocal indentexpr<")
            end
            local disabled_folding = {}
            if has_query("folds") and not is_disabled(disabled_folding) then
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[0][0].foldmethod = "expr"
                add_undo_ftplugin("setlocal foldexpr< foldmethod<")
            end
        end,
    })
end

require("snacks").setup({
    dashboard = {
        preset = {
            header = "     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n     ⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀\n     ⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀\n     ⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀\n     ⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀\n     ⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀\n     ⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀\n     ⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿ \n     ⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀\n     ⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀\n     ⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀\n     ⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀\n     ⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀\n     ⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀\n     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
            keys = {
                { { action = ":lua Snacks.dashboard.pick('files')", desc = "Find File", icon = " ", key = "f" } },
                { { action = ":ene | startinsert", desc = "New File", icon = " ", key = "n" } },
                { { action = ":lua Snacks.dashboard.pick('live_grep')", desc = "Find Text", icon = " ", key = "g" } },
                {
                    {
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                        desc = "Recent Files",
                        icon = " ",
                        key = "r",
                    },
                },
                { { desc = "Restore Session", icon = " ", key = "s", section = "session" } },
                { { action = ":qa", desc = "Quit", icon = " ", key = "q" } },
            },
        },
        sections = { { { section = "header" } }, { { gap = 1, padding = 1, section = "keys" } } },
    },
    image = {
        bo = { modifiable = false, modified = false },
        convert = { notify = true },
        enabled = true,
        formats = {
            "png",
            "jpg",
            "jpeg",
            "gif",
            "bmp",
            "webp",
            "tiff",
            "heic",
            "avif",
            "mp4",
            "mov",
            "avi",
            "mkv",
            "webm",
            "pdf",
            "icns",
        },
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true, ui_select = true },
    recent = {
        filter = {
            paths = {
                ["*.avi"] = false,
                ["*.avif"] = false,
                ["*.bmp"] = false,
                ["*.gif"] = false,
                ["*.heic"] = false,
                ["*.icns"] = false,
                ["*.jpeg"] = false,
                ["*.jpg"] = false,
                ["*.mkv"] = false,
                ["*.mov"] = false,
                ["*.mp4"] = false,
                ["*.pdf"] = false,
                ["*.png"] = false,
                ["*.tiff"] = false,
                ["*.webm"] = false,
                ["*.webp"] = false,
            },
        },
        finder = "recent_files",
        format = "file",
    },
    terminal = { enabled = true },
})

require("noice").setup({})

require("neo-tree").setup({
    close_if_last_window = false,
    enable_diagnostics = true,
    enable_git_status = true,
    filesystem = {
        filtered_items = { hide_dotfiles = true, hide_gitignored = true },
        follow_current_file = { enabled = true, leave_dirs_open = true },
        use_libuv_file_watcher = true,
    },
    popup_border_style = "rounded",
    source_selector = { statusline = false, truncation_character = "…", winbar = true },
    use_popups_for_input = false,
    window = { mappings = { ["<C-S-f>"] = "fuzzy_finder", h = "close_node", l = "open" } },
})

require("lualine").setup({})

require("lazydev").setup({
    enabled = function()
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
    end,
    library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
})

require("kitty-scrollback").setup({})

require("grug-far").setup({ headerMaxWidth = 80, windowCreationCommand = "rightbelow 40 vsplit" })

require("gitsigns").setup({
    current_line_blame = false,
    on_attach = function(bufnr)
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        map("n", "q", function()
            vim.api.nvim_buf_delete(bufnr, { force = true })
        end)
    end,
})

require("flash").setup({})

require("dropbar").setup({})

require("dapui").setup({})

require("dap").adapters = {
    codelldb = {
        executable = {
            args = { "--port", "${port}" },
            command = "/nix/store/6xssv0ihdrk2gcvjpvk0vdhrjzcdzj9v-vscode-extension-vadimcn-vscode-lldb-1.12.2/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
        },
        port = "${port}",
        type = "server",
    },
    debugpy = {
        args = { "-m", "debugpy.adapter" },
        command = "/nix/store/70kc4f8lrs2fazabalzl7didqjzgd17l-python3-3.14.7-env/bin/python",
        type = "executable",
    },
}

require("dap").configurations = {
    c = {
        {
            cwd = "${workspaceFolder}",
            name = "Launch executable",
            program = function()
                return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            request = "launch",
            type = "codelldb",
        },
    },
    cpp = {
        {
            cwd = "${workspaceFolder}",
            name = "Launch executable",
            program = function()
                return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            request = "launch",
            type = "codelldb",
        },
    },
    python = {
        {
            console = "internalConsole",
            cwd = "${workspaceFolder}",
            name = "Launch current file",
            program = function()
                return vim.fn.expand("%:p")
            end,
            pythonPath = function()
                for _, env in ipairs({ "VIRTUAL_ENV", "CONDA_PREFIX" }) do
                    local prefix = vim.env[env]
                    if prefix and vim.fn.executable(prefix .. "/bin/python") == 1 then
                        return prefix .. "/bin/python"
                    end
                end
                local python = vim.fn.exepath("python3")
                return python ~= "" and python
                    or "/nix/store/70kc4f8lrs2fazabalzl7didqjzgd17l-python3-3.14.7-env/bin/python"
            end,
            request = "launch",
            type = "debugpy",
        },
    },
    rust = {
        {
            cwd = "${workspaceFolder}",
            name = "Launch executable",
            program = function()
                return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            request = "launch",
            type = "codelldb",
        },
    },
}

require("cord").setup({})

require("colorful-winsep").setup({})

require("bufferline").setup({
    options = {
        close_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        indicator = { icon = "▎", style = "icon" },
        middle_mouse_command = "bdelete! %d",
        name_formatter = function(buf)
            -- Nix: truncate default.nix -> folder name with slash
            if buf.name:match("default.nix") then
                return vim.fn.fnamemodify(buf.path, ":h:t") .. "/"
            end
        end,
        numbers = "ordinal",
        show_buffer_icons = true,
    },
})

require("blink.pairs").setup({
    highlights = {
        cmdline = true,
        enabled = true,
        groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
        matchparen = {
            cmdline = false,
            enabled = true,
            group = "BlinkPairsMatchParen",
            include_surrounding = false,
            priority = 250,
        },
        unmatched_group = "BlinkPairsUnmatched",
    },
    mappings = {
        cmdline = true,
        enabled = true,
        pairs = {
            ["'"] = {
                {
                    "''",
                    languages = { "nix" },
                    when = function(ctx)
                        function is_inside_string()
                            NODE = "string_fragment"
                            local ok, node = pcall(vim.treesitter.get_node)
                            if not ok or not node then
                                return false
                            end
                            while node do
                                if node:type() == NODE then
                                    return true
                                end
                                node = node:parent()
                            end
                            return false
                        end
                        return ctx:text_before_cursor(1) == "'" and not is_inside_string()
                    end,
                },
            },
        },
    },
})

require("blink-cmp").setup({
    appearance = { nerd_font_variant = "normal" },
    cmdline = {
        completion = { list = { selection = { preselect = false } }, menu = { auto_show = true } },
        keymap = {
            ["<C-f>"] = { "select_and_accept", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            preset = "cmdline",
        },
    },
    completion = {
        documentation = { auto_show = true, window = { border = "single" } },
        menu = {
            border = "single",
            draw = {
                columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source" } },
                components = {
                    source = {
                        width = { max = 20 },
                        text = function(ctx)
                            local source = ctx.source_name

                            if ctx.source_id == "lsp" and ctx.item and ctx.item.client_id then
                                local client = vim.lsp.get_client_by_id(ctx.item.client_id)
                                if client then
                                    source = client.name
                                end
                            end

                            return " " .. source
                        end,
                        highlight = "BlinkCmpSource",
                    },
                },
            },
        },
    },
    enabled = function()
        local disabled_ft = { "TelescopePrompt", "dap-repl", "snacks_picker_list" }
        if vim.fn.getcmdtype() ~= "" then
            return true
        end
        return not vim.tbl_contains(disabled_ft, vim.bo.filetype)
    end,
    fuzzy = { implementation = "prefer_rust_with_warning" },
    keymap = {
        ["<C-b>"] = { "hide", "fallback" },
        ["<C-f>"] = { "select_and_accept" },
        ["<CR>"] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            "fallback",
        },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        preset = "default",
    },
    signature = { window = { border = "single" } },
    snippets = { preset = "luasnip" },
    sources = {
        default = { "lazydev", "lsp", "path", "snippets" },
        per_filetype = { markdown = { "lsp", "path", "snippets" }, org = { "orgmode" } },
        providers = {
            lazydev = { module = "lazydev.integrations.blink", name = "LazyDev", score_offset = 100 },
            orgmode = { fallbacks = { "buffer" }, module = "orgmode.org.autocompletion.blink", name = "Orgmode" },
            snippets = {
                enabled = function()
                    local MATH_NODES = {
                        displayed_equation = true,
                        inline_formula = true,
                        math_environment = true,
                        latex_block = true,
                        math = true,
                        math_block = true,
                        inline_math = true,
                        equation = true,
                        equation_environment = true,
                    }

                    if vim.bo.filetype ~= "markdown" then
                        return true
                    end
                    local ok, node = pcall(vim.treesitter.get_node)
                    if not ok or not node then
                        return false
                    end
                    while node do
                        if MATH_NODES[node:type()] then
                            return true
                        end
                        node = node:parent()
                    end
                    return false
                end,
            },
        },
    },
})

local function __nixvim_lsp_on_attach(client, bufnr, event) end

vim.lsp.handlers["client/registerCapability"] = (function(overridden)
    return function(err, res, ctx, ...)
        local result = overridden(err, res, ctx, ...)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if client == nil then
            return result
        end

        for bufnr, _ in pairs(client.attached_buffers) do
            __nixvim_lsp_on_attach(client, bufnr, {
                buf = bufnr,
                data = {
                    client_id = client.id,
                },
            })
        end

        return result
    end
end)(vim.lsp.handlers["client/registerCapability"])

-- Set up keybinds {{{
do
    local __nixvim_binds = {
        {
            action = function()
                Snacks.terminal()
            end,
            key = "<leader>!",
            mode = "",
            options = { desc = "Toggle Terminal" },
        },
        {
            action = function()
                Snacks.terminal({ cmd = "zsh" })
            end,
            key = "<leader>tf",
            mode = "",
            options = { desc = "Toggle Terminal (float)" },
        },
        {
            action = function()
                require("snacks").picker.smart()
            end,
            key = "<leader><space>",
            mode = "",
            options = { desc = "Pick files" },
        },
        {
            action = function()
                require("snacks").picker.grep({
                    glob = {
                        "!Cargo.lock",
                        "!composer.lock",
                        "!flake.lock",
                        "!go.sum",
                        "!package-lock.json",
                        "!pnpm-lock.yaml",
                        "!poetry.lock",
                        "!uv.lock",
                        "!yarn.lock",
                    },
                })
            end,
            key = "<leader>/",
            mode = "",
            options = { desc = "Grep files" },
        },
        {
            action = function()
                require("snacks").picker.resume()
            end,
            key = "<leader>R",
            mode = "",
            options = { desc = "Resume last pick" },
        },
        {
            action = function()
                require("snacks").picker.commands()
            end,
            key = "<leader>;",
            mode = "",
            options = { desc = "Show commands" },
        },
        {
            action = function()
                require("snacks").picker()
            end,
            key = "<leader>:",
            mode = "",
            options = { desc = "Pick Snacks" },
        },
        {
            action = function()
                require("snacks").picker.colorschemes()
            end,
            key = "<leader>ui",
            mode = "",
            options = { desc = "Change Colorscheme" },
        },
        {
            action = function()
                require("snacks").picker.zoxide()
            end,
            key = "<leader>pd",
            mode = "",
            options = { desc = "Change project directories (via zoxide)" },
        },
        {
            action = function()
                require("snacks").picker.git_status()
            end,
            key = "<leader>gs",
            mode = "",
            options = { desc = "Git Status" },
        },
        {
            action = function()
                require("snacks").picker.git_branches()
            end,
            key = "<leader>gt",
            mode = "",
            options = { desc = "Git Branches" },
        },
        {
            action = function()
                require("snacks").picker.git_log()
            end,
            key = "<leader>gc",
            mode = "",
            options = { desc = "Git Log (Commits)" },
        },
        {
            action = function()
                require("snacks").picker.files()
            end,
            key = "<leader>ff",
            mode = "",
            options = { desc = "Find Files" },
        },
        {
            action = function()
                require("snacks").picker.buffers()
            end,
            key = "<leader>fb",
            mode = "",
            options = { desc = "List buffers" },
        },
        {
            action = function()
                require("snacks").picker.buffers()
            end,
            key = "<leader>bB",
            mode = "",
            options = { desc = "List buffers" },
        },
        {
            action = function()
                require("snacks").picker.recent()
            end,
            key = "<leader>fh",
            mode = "",
            options = { desc = "Recent Files" },
        },
        {
            action = function()
                require("snacks").picker.lsp_symbols()
            end,
            key = "<leader>cs",
            mode = "",
            options = { desc = "Search Symbols" },
        },
        {
            action = function()
                require("snacks").picker.grep_word()
            end,
            key = "<leader>cS",
            mode = { "n", "x" },
            options = { desc = "Search Current Symbol" },
        },
        {
            action = function()
                require("snacks").picker.lsp_definitions()
            end,
            key = "gd",
            mode = "",
            options = { desc = "Goto definition" },
        },
        {
            action = function()
                require("snacks").picker.lsp_type_definitions()
            end,
            key = "gy",
            mode = "",
            options = { desc = "Goto T[y]pe Definition" },
        },
        {
            action = function()
                require("snacks").picker.lsp_references()
            end,
            key = "gr",
            mode = "",
            options = { desc = "References" },
        },
        { action = "%", key = "<Tab>", mode = { "n" }, options = { desc = "Match pairs" } },
        { action = '"+y', key = "<C-c>", mode = { "v" }, options = { desc = "Copy selection to system clipboard" } },
        { action = '<Esc>"+pi', key = "<C-v>", mode = { "i" }, options = { desc = "Paste from system clipboard" } },
        {
            action = "<Cmd>nohlsearch<Bar>diffupdate<CR>",
            key = "<Esc>",
            mode = { "n" },
            options = { desc = "Smart Esc" },
        },
        { action = "<gv", key = "<", mode = { "v" }, options = { desc = "Indent < and keep selection" } },
        { action = ">gv", key = ">", mode = { "v" }, options = { desc = "Indent > and keep selection" } },
        {
            action = "v:count == 0 ? 'gj' : 'j'",
            key = "j",
            mode = { "n", "x" },
            options = { desc = "Down", expr = true, silent = true },
        },
        {
            action = "v:count == 0 ? 'gj' : 'j'",
            key = "<Down>",
            mode = { "n", "x" },
            options = { desc = "Down", expr = true, silent = true },
        },
        {
            action = "v:count == 0 ? 'gk' : 'k'",
            key = "k",
            mode = { "n", "x" },
            options = { desc = "Up", expr = true, silent = true },
        },
        {
            action = "v:count == 0 ? 'gk' : 'k'",
            key = "<Up>",
            mode = { "n", "x" },
            options = { desc = "Up", expr = true, silent = true },
        },
        { action = vim.lsp.buf.definition, key = "<C-CR>", mode = "", options = { desc = "Goto Definition" } },
        { action = vim.lsp.buf.implementation, key = "gi", mode = "", options = { desc = "Goto Implementation" } },
        { action = vim.lsp.buf.code_action, key = "ga", mode = "", options = { desc = "Code Action" } },
        { action = vim.lsp.buf.hover, key = "K", mode = "", options = { desc = "Show hover" } },
        { action = vim.lsp.buf.rename, key = "cd", mode = { "n" }, options = { desc = "Rename symbols under cursor" } },
        {
            action = "<cmd>Trouble diagnostics toggle<cr>",
            key = "<leader>eE",
            mode = "",
            options = { desc = "Diagnostics (Trouble)" },
        },
        {
            action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            key = "<leader>ee",
            mode = "",
            options = { desc = "Buffer Diagnostics (Trouble)" },
        },
        {
            action = "<cmd>Trouble symbols toggle focus=false<cr>",
            key = "<leader>es",
            mode = "",
            options = { desc = "Symbols (Trouble)" },
        },
        {
            action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            key = "<leader>el",
            mode = "",
            options = { desc = "LSP Definitions / references / ... (Trouble)" },
        },
        {
            action = "<cmd>Trouble loclist toggle<cr>",
            key = "<leader>eL",
            mode = "",
            options = { desc = "Location List (Trouble)" },
        },
        {
            action = "<cmd>Trouble qflist toggle<cr>",
            key = "<leader>ef",
            mode = "",
            options = { desc = "Quickfix List (Trouble)" },
        },
        {
            action = function()
                require("snacks").git.blame_line()
            end,
            key = "<leader>gB",
            mode = "",
            options = { desc = "Blame line" },
        },
        {
            action = function()
                require("snacks").rename.rename_file()
            end,
            key = "<leader>fR",
            mode = "",
            options = { desc = "Rename file" },
        },
        {
            action = function()
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                require("grug-far").open({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            key = "<C-S-f>",
            mode = { "i", "n", "v" },
            options = { desc = "Search and Replace" },
        },
        {
            action = function()
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                require("grug-far").open({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            key = "<leader>fF",
            mode = { "n", "v" },
            options = { desc = "Search and Replace" },
        },
        { action = "<cmd>Gitsigns blame<CR>", key = "<leader>gb", mode = "", options = { desc = "Blame file" } },
        {
            action = "<cmd>Gitsigns toggle_current_line_blame<CR>",
            key = "<leader>tb",
            mode = "",
            options = { desc = "Toggle line blame" },
        },
        { action = "<cmd>Gitsigns prev_hunk<CR>", key = "[g", mode = "", options = { desc = "Prev hunk" } },
        { action = "<cmd>Gitsigns next_hunk<CR>", key = "]g", mode = "", options = { desc = "Next hunk" } },
        {
            action = function()
                require("dropbar.api").pick()
            end,
            key = "<Leader>@",
            mode = "",
            options = { desc = "Pick symbols in winbar" },
        },
        {
            action = function()
                require("dropbar.api").goto_context_start()
            end,
            key = "[;",
            mode = "",
            options = { desc = "Go to start of current context" },
        },
        {
            action = function()
                require("dropbar.api").select_next_context()
            end,
            key = "];",
            mode = "",
            options = { desc = "Select next context" },
        },
        {
            action = function()
                require("treesj").join()
            end,
            key = "gJ",
            mode = "",
            options = { desc = "Join lines" },
        },
        {
            action = function()
                require("treesitter-context").toggle()
            end,
            key = "<leader>tc",
            mode = "",
            options = { desc = "Toggle Treesitter Context" },
        },
        {
            action = function()
                require("img-clip").paste_image()
            end,
            key = "<localleader>p",
            mode = { "n" },
            options = { desc = "Paste image from clipboard" },
        },
        { action = "<cmd>BufferLineCyclePrev<CR>", key = "H", mode = "", options = { desc = "bp" } },
        { action = "<cmd>BufferLineCycleNext<CR>", key = "L", mode = "", options = { desc = "bn" } },
        {
            action = "<cmd>BufferLineGoToBuffer #<CR>",
            key = "<leader>b#",
            mode = "",
            options = { desc = "Switch to Buffer #" },
        },
        {
            action = "<cmd>BufferLineMovePrev<CR>",
            key = "<leader>b,",
            mode = "",
            options = { desc = "Move Buffer Left" },
        },
        {
            action = "<cmd>BufferLineMoveNext<CR>",
            key = "<leader>b.",
            mode = "",
            options = { desc = "Move Buffer Right" },
        },
        {
            action = "<cmd>BufferLinePick<CR>",
            key = "<leader>bb",
            mode = "",
            options = { desc = "Quick Switch Buffers" },
        },
        {
            action = "<cmd>BufferLineCloseOthers<CR>",
            key = "<leader>bD",
            mode = "",
            options = { desc = "Delete Other Buffers" },
        },
        {
            action = "<cmd>BufferLineCloseOthers<CR>",
            key = "<leader>bxx",
            mode = "",
            options = { desc = "Delete Other Buffers" },
        },
        {
            action = "<cmd>BufferLineCloseLeft<CR>",
            key = "<leader>bxh",
            mode = "",
            options = { desc = "Delete Buffers Left" },
        },
        {
            action = "<cmd>BufferLineCloseRight<CR>",
            key = "<leader>bxl",
            mode = "",
            options = { desc = "Delete Buffers Right" },
        },
        {
            action = "<cmd>BufferLineCloseOthers<CR>",
            key = "<leader>bX",
            mode = "",
            options = { desc = "Delete Other Buffers" },
        },
        { action = "<cmd>BufferLineTogglePin<CR>", key = "<leader>bt", mode = "", options = { desc = "Pin Buffer" } },
        {
            action = "<cmd>BufferLineGoToBuffer 1<CR>",
            key = "<leader>b1",
            mode = "",
            options = { desc = "Switch to Buffer #1" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 2<CR>",
            key = "<leader>b2",
            mode = "",
            options = { desc = "Switch to Buffer #2" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 3<CR>",
            key = "<leader>b3",
            mode = "",
            options = { desc = "Switch to Buffer #3" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 4<CR>",
            key = "<leader>b4",
            mode = "",
            options = { desc = "Switch to Buffer #4" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 5<CR>",
            key = "<leader>b5",
            mode = "",
            options = { desc = "Switch to Buffer #5" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 6<CR>",
            key = "<leader>b6",
            mode = "",
            options = { desc = "Switch to Buffer #6" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 7<CR>",
            key = "<leader>b7",
            mode = "",
            options = { desc = "Switch to Buffer #7" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 8<CR>",
            key = "<leader>b8",
            mode = "",
            options = { desc = "Switch to Buffer #8" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 9<CR>",
            key = "<leader>b9",
            mode = "",
            options = { desc = "Switch to Buffer #9" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 1<CR>",
            key = "<A-1>",
            mode = "",
            options = { desc = "Switch to Buffer #1" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 2<CR>",
            key = "<A-2>",
            mode = "",
            options = { desc = "Switch to Buffer #2" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 3<CR>",
            key = "<A-3>",
            mode = "",
            options = { desc = "Switch to Buffer #3" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 4<CR>",
            key = "<A-4>",
            mode = "",
            options = { desc = "Switch to Buffer #4" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 5<CR>",
            key = "<A-5>",
            mode = "",
            options = { desc = "Switch to Buffer #5" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 6<CR>",
            key = "<A-6>",
            mode = "",
            options = { desc = "Switch to Buffer #6" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 7<CR>",
            key = "<A-7>",
            mode = "",
            options = { desc = "Switch to Buffer #7" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 8<CR>",
            key = "<A-8>",
            mode = "",
            options = { desc = "Switch to Buffer #8" },
        },
        {
            action = "<cmd>BufferLineGoToBuffer 9<CR>",
            key = "<A-9>",
            mode = "",
            options = { desc = "Switch to Buffer #9" },
        },
        { action = "<cmd>Neotree toggle<CR>", key = "<leader>E", mode = "", options = { desc = "Toggle Neo-tree" } },
        { action = "<cmd>Neotree toggle<CR>", key = "<leader>ft", mode = "", options = { desc = "Toggle Neo-tree" } },
        { action = "<cmd>Neotree toggle<CR>", key = "<C-S-e>", mode = "", options = { desc = "Toggle Neo-tree" } },
        { action = "<cmd>Neogit<CR>", key = "<leader>gg", mode = "", options = { desc = "Neogit" } },
        { action = "<cmd>Neogit<CR>", key = "<C-S-g>", mode = "", options = { desc = "Neogit" } },
        {
            action = function()
                require("flash").jump()
            end,
            key = "s",
            mode = { "n", "x", "o" },
        },
        {
            action = function()
                require("flash").treesitter()
            end,
            key = "S",
            mode = { "n", "x", "o" },
        },
        {
            action = require("dap").toggle_breakpoint,
            key = "<leader>db",
            mode = "",
            options = { desc = "Toggle breakpoint" },
        },
        {
            action = require("dap").continue,
            key = "<leader>dc",
            mode = "",
            options = { desc = "Start / continue debugging" },
        },
        { action = require("dap").step_over, key = "<leader>dn", mode = "", options = { desc = "Step over" } },
        { action = require("dap").step_into, key = "<leader>di", mode = "", options = { desc = "Step into" } },
        { action = require("dap").step_out, key = "<leader>do", mode = "", options = { desc = "Step out" } },
        { action = require("dap").terminate, key = "<leader>dt", mode = "", options = { desc = "Terminate debugging" } },
        { action = require("dapui").toggle, key = "<leader>du", mode = "", options = { desc = "Toggle debug UI" } },
    }
    for i, map in ipairs(__nixvim_binds) do
        vim.keymap.set(map.mode, map.key, map.action, map.options)
    end
end
-- }}}

vim.filetype.add({
    extension = {
        axaml = "xml",
        bean = "beancount",
        ["code-snippets"] = "jsonc",
        magic = "libmagic",
        ["sublime-syntax"] = "yaml",
        xaml = "xml",
    },
    filename = { ["settings.json"] = "jsonc" },
})

do
    local cmds = {
        Explore = {
            command = "<cmd>Neotree toggle<CR>",
            options = { bang = true, desc = "Open Explorer", range = false },
        },
    }
    for name, cmd in pairs(cmds) do
        vim.api.nvim_create_user_command(name, cmd.command, cmd.options or {})
    end
end

-- LSP {{{
do
    local __lspCapabilities = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Capabilities configuration for blink-cmp
        capabilities = require("blink-cmp").get_lsp_capabilities(capabilities)

        return capabilities
    end

    local __setup = { capabilities = __lspCapabilities() }

    local __wrapConfig = function(cfg)
        if cfg == nil then
            cfg = __setup
        else
            cfg = vim.tbl_extend("keep", cfg, __setup)
        end
        return cfg
    end

    vim.lsp.config("basedpyright", __wrapConfig({}))
    vim.lsp.enable("basedpyright")
    vim.lsp.config(
        "clangd",
        __wrapConfig({
            cmd = {
                "clangd",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=none",
            },
            filetypes = { "c", "cpp", "cuda" },
            root_markers = { ".clangd", ".clang-format", "compile_commands.json", "compile_flags.txt" },
        })
    )
    vim.lsp.enable("clangd")
    vim.lsp.config("emmet_ls", __wrapConfig({}))
    vim.lsp.enable("emmet_ls")
    vim.lsp.config("lua_ls", __wrapConfig({}))
    vim.lsp.enable("lua_ls")
    vim.lsp.config(
        "nil_ls",
        __wrapConfig({
            on_attach = function(client, bufnr)
                if client.name == "nil_ls" then
                    client.server_capabilities.definitionProvider = false -- use nixd
                    client.server_capabilities.renameProvider = false -- use nixd
                end
            end,
        })
    )
    vim.lsp.enable("nil_ls")
    vim.lsp.config(
        "nixd",
        __wrapConfig({
            settings = {
                nixd = {
                    formatting = { command = { "nixfmt" } },
                    nixpkgs = {
                        expr = 'import (builtins.getFlake "github:js0ny/nixcfgs").inputs.nixpkgs { overlays = (builtins.getFlake "github:js0ny/nixcfgs").outputs.allOverlays; }',
                    },
                    options = {
                        ["flake-parts"] = { expr = '(builtins.getFlake "github:js0ny/nixcfgs").debug.options' },
                        ["home-manager"] = {
                            expr = '(builtins.getFlake "github:js0ny/nixcfgs").nixosConfigurations.crystal.options.home-manager.users.type.getSubOptions []',
                        },
                        nixos = {
                            expr = '(builtins.getFlake "github:js0ny/nixcfgs").nixosConfigurations.crystal.options',
                        },
                        nixvim = {
                            expr = '(builtins.getFlake "github:js0ny/nvimdots/nixvim").inputs.nixvim.nixvimConfigurations.aarch64-linux.default.options',
                        },
                    },
                },
            },
        })
    )
    vim.lsp.enable("nixd")
    vim.lsp.config("ruff", __wrapConfig({}))
    vim.lsp.enable("ruff")
    vim.lsp.config("stylua", __wrapConfig({}))
    vim.lsp.enable("stylua")
    vim.lsp.config(
        "yamlls",
        __wrapConfig({
            settings = {
                yaml = {
                    schemaStore = { enable = false, url = "" },
                    schemas = require("schemastore").yaml.schemas({}),
                },
            },
        })
    )
    vim.lsp.enable("yamlls")
end
-- }}}

require("typst-infect").setup({
    org = {
        enabled = true,
        variants = {
            inline = true,
            display = true,
            latex_env = false,
            equation_block = false,
            src_blocks = {
                "typst",
                "typst_math",
                "math",
            },
        },
    },
})

local limes_previous_ascii_mode = nil

local function limes_run(method, ...)
    local limes = "/nix/store/dnslmqvq424c08lqfgx6zazqb061zkdd-limes-0-unstable-2026-07-07/bin/limes"
    if not limes then
        return nil
    end
    local args = {
        limes,
        "--backend",
        "fcitx5-rime",
        "--mode",
        "ascii",
        method,
    }
    vim.list_extend(args, { ... })

    return vim.fn.system(args)
end

local is_ssh = vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil

local function limes_get_ascii_mode()
    local output = limes_run("get")
    if output:match("true") then
        return true
    elseif output:match("false") then
        return false
    end
    return nil
end

local function limes_set_ascii_mode(enabled)
    limes_run("set", tostring(enabled))
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
    local group = vim.api.nvim_create_augroup("InputMethod", { clear = true })

    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = limes_switch_to_en,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = limes_restore_layout,
    })
end

require("sops").setup({})

Snacks = require("snacks")
vim.api.nvim_create_user_command("Rename", function(args)
    Snacks.rename.rename_file()
end, {
    desc = "Rename current buffer",
})
vim.api.nvim_create_user_command("GitBrowse", function(args)
    Snacks.gitbrowse.open()
end, {
    desc = "Open remote with browser",
})
vim.api.nvim_create_user_command("GotoGitRoot", function(args)
    vim.fn.chdir(Snacks.git.get_root())
end, {
    desc = "Change to Git Root Directory",
})
vim.api.nvim_create_user_command("TermNew", function(args)
    Snacks.terminal.open()
end, {
    desc = "Create a new terminal",
})
vim.api.nvim_create_user_command("TermToggle", function(args)
    Snacks.terminal.toggle()
end, {
    desc = "Create a new terminal",
})

vim.api.nvim_create_user_command("Mkdir", function()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then
        vim.notify("Mkdir: current buffer has no file name", vim.log.levels.ERROR)
        return
    end

    local directory = vim.fs.dirname(file)
    local ok, result = pcall(vim.fn.mkdir, directory, "p")

    if not ok or (result == 0 and vim.fn.isdirectory(directory) == 0) then
        vim.notify("Mkdir: failed to create " .. directory, vim.log.levels.ERROR)
        return
    end

    vim.notify("Created directory: " .. directory)
end, {
    desc = "Create the current buffer's parent directory",
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = vim.api.nvim_create_augroup("StopSnippetOnInsertLeave", {
        clear = true,
    }),
    callback = function()
        if vim.snippet.active() then
            vim.snippet.stop()
        end
    end,
})

require("code_runner").setup({
    mode = "float",
    filetype = {
        python = "python3 -u",
        javascript = "node",
    },
})

local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    require("dapui").close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    require("dapui").close()
end

-- Set up autogroups {{
do
    local __nixvim_autogroups = { nixvim_binds_LspAttach = { clear = true }, nixvim_lsp_on_attach = { clear = false } }

    for group_name, options in pairs(__nixvim_autogroups) do
        vim.api.nvim_create_augroup(group_name, options)
    end
end
-- }}
-- Set up autocommands {{
do
    local __nixvim_autocommands = {
        {
            callback = function(event)
                do
                    -- client and bufnr are supplied to the builtin `on_attach` callback,
                    -- so make them available in scope for our global `onAttach` impl
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client == nil then
                        return
                    end

                    __nixvim_lsp_on_attach(client, event.buf, event)
                end
            end,
            desc = "Run LSP onAttach",
            event = "LspAttach",
            group = "nixvim_lsp_on_attach",
        },
        {
            callback = function(args)
                do
                    local __nixvim_binds = {}

                    for i, map in ipairs(__nixvim_binds) do
                        local options = vim.tbl_extend("keep", map.options or {}, { buffer = args.buf })
                        vim.keymap.set(map.mode, map.key, map.action, options)
                    end
                end
            end,
            desc = "Load keymaps for LspAttach",
            event = "LspAttach",
            group = "nixvim_binds_LspAttach",
        },
        {
            callback = function()
                vim.bo.indentexpr = ""
                vim.bo.cindent = true
            end,
            event = "FileType",
            pattern = "cs",
        },
        {
            callback = function(args)
                vim.keymap.set("n", "q", "<cmd>bd<cr>", {
                    buffer = args.buf,
                    silent = true,
                    nowait = true,
                    desc = "Close image",
                })
            end,
            event = "FileType",
            pattern = "image",
        },
    }

    for _, autocmd in ipairs(__nixvim_autocommands) do
        vim.api.nvim_create_autocmd(autocmd.event, {
            group = autocmd.group,
            pattern = autocmd.pattern,
            buffer = autocmd.buffer,
            desc = autocmd.desc,
            callback = autocmd.callback,
            command = autocmd.command,
            once = autocmd.once,
            nested = autocmd.nested,
        })
    end
end
-- }}
