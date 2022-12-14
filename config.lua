--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Neovide
if vim.fn.exists("g:neovide") ~= 0 then
    vim.o.guifont = "Input"
end

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
vim.opt.cmdheight = 1
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.numberwidth = 4
vim.wo.conceallevel = 2
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('goto-preview').goto_preview_definition()<CR>"
lvim.keys.normal_mode["<C-c>"] = "<cmd>lua require('goto-preview').close_all_win()<CR>"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["t"] = {
    name = "Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

lvim.builtin.which_key.mappings["S"] = {
    name = "Session",
    c = { "<cmd>lua require('persisted').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persisted').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persisted').stop()<cr>", "Quit without saving session" },
}

lvim.builtin.which_key.mappings["d"] = {
    name = "Docker",
}

lvim.builtin.which_key.mappings["M"] = { "<cmd>MundoToggle<CR>", "Undo Tree" }

lvim.builtin.which_key.mappings["m"] = {
    name = "Markdown",
    t = { "<cmd>MkdnTableFormat<cr>", "Table format" },
}

lvim.builtin.which_key.mappings["i"] = {
    name = "Icons",
    a = { "<cmd>PickIcons<cr>", "Insert icons and symbols" },
    i = { "<cmd>PickIconsInsert<cr>", "Insert icons" },
    s = { "<cmd>PickAltFontAndSymbolsInsert<cr>", "Insert symbols" },
}

lvim.builtin.which_key.mappings["N"] = { "<cmd>ZkNotes<cr>",  "Wiki" }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- Configure Project
lvim.builtin.project.patterns = {
    "!=project",
    "!^Plugin",
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
    "package.json",
}

-- Configure Dashboard
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section = require("plugins.alpha").config.dashboard.section

-- Configure Notify
lvim.builtin.notify.active = true

-- Configure Terminal
lvim.builtin.terminal.active = true

-- Configure Nvimtree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.filters.exclude = { "node_modules" }

-- Configure Lualine
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.options.disabled_filetypes = {}

-- Configure Breadcrumbs
lvim.builtin.breadcrumbs.active = true

-- Configure Bufferline
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.options.offsets = {
    {
        filetype = "NvimTree",
        text = "??? ->",
        text_align = "right",
        -- highlight = "PanelHeading",
        highlight = "Directory",
        padding = 1,
    },
}

-- Configure Treesitter
lvim.builtin.treesitter.autotag.enable = true
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "tsx",
    "json",
    "lua",
    "php",
    "phpdoc",
    "python",
    "typescript",
    "css",
    "rust",
    "java",
    "yaml",
    "go",
    "html",
    "comment",
    "make",
    "dockerfile",
    "toml",
    "jsonc",
    "markdown",
    "markdown_inline",
    "svelte",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "intelephense" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("intelephense", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
-- end
-- Enable completion triggered by <c-x><c-o>
-- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        exe = "phpcs",
        autostart = true,
        filetypes = { "php" },
        args = { "--standard=" .. os.getenv("HOME") .. "/.config/lvim/rules/PSR-12.xml" },
    },
}

-- Additional Plugins
lvim.plugins = {
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = false,
                char = "???",
                filetype_exclude = { "help", "terminal", "alpha", "mason.nvim" },
                buftype_exclude = { "terminal" },
                show_trailing_blankline_indent = false,
                show_first_indent_level = false,
            }
        end
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require('colorizer').setup({
                filetypes = {
                    "*",
                    "!NvimTree",
                    "!sql",
                    "!mason.nvim",
                },
                user_default_options = {
                    names = false,
                },
            })
        end
    },
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = {
                    '<C-u>', '<C-d>', '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>', 'zt', 'zz', 'zb'
                },
                hide_cursor = true, -- Hide cursor while scrolling
                stop_eof = true, -- Stop at <EOF> when scrolling downwards
                use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = 'sine', -- Default easing function
                pre_hook = nil, -- Function to run before the scrolling animation starts
                post_hook = nil, -- Function to run after the scrolling animation ends
            })
        end,
    },
    {
        'kevinhwang91/nvim-hlslens',
    },
    {
        "petertriho/nvim-scrollbar",
        event = "BufRead",
        config = function()
            local colors = require("onedarker.palette")
            require("scrollbar").setup(
                {
                    folds = 1000,
                    max_lines = 10000,
                    handle = {
                        color = colors.alt_bg,
                    },
                    marks = {
                        Search = { color = colors.orange },
                        Error = { color = colors.error_red },
                        Warn = { color = colors.warning_orange },
                        Info = { color = colors.info_yellow },
                        Hint = { color = colors.hint_blue },
                        Misc = { color = colors.purple },
                    },
                    autocmd = {
                        render = {
                            "BufWinEnter",
                            "TabEnter",
                            "TermEnter",
                            "WinEnter",
                            "CmdwinLeave",
                            "TextChanged",
                            "VimResized",
                            "WinScrolled",
                        },
                    },
                    handlers = {
                        diagnostic = true,
                        search = true, -- Requires hlslens to be loaded
                    },
                }
            )
        end
    },
    {
        "ethanholz/nvim-lastplace",
        event = "BufRead",
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit",
                },
                lastplace_open_folds = true,
            })
        end,
    },
    {
        "olimorris/persisted.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persisted",
        config = function()
            require("persisted").setup()
            require("telescope").load_extension("persisted")
            vim.o.sessionoptions = "buffers,curdir,tabpages,folds,winpos,winsize"
        end,
    },
    {
        "ggandor/lightspeed.nvim",
        event = "BufRead",
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require "lsp_signature".setup()
        end
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require('goto-preview').setup {
                width = 120, -- Width of the floating window
                height = 25, -- Height of the floating window
                default_mappings = false, -- Bind default mappings
                resizing_mappings = true,
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
                -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
                -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
                -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
            }
        end
    },
    {
        "nathom/filetype.nvim",
        setup = function()
            vim.g.did_load_filetypes = 1
        end
    },
    {
        "m-demare/hlargs.nvim",
        event = "BufRead",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("hlargs").setup()
        end,
    },
    {
        "danymat/neogen",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("neogen").setup {
                enabled = true,
            }
        end,
    },
    {
        'esensar/nvim-dev-container',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require("devcontainer").setup {}
        end,
    },
    {
        "ziontee113/icon-picker.nvim",
        requires = { "stevearc/dressing.nvim" },
        config = function()
            require("icon-picker")
        end,
    },
    {
        "gpanders/editorconfig.nvim",
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
    },
    {
        "simnalamburt/vim-mundo",
        cmd = {
            "MundoToggle"
        },
        config = function()
            vim.g.mundo_right = 1
            vim.g.mundo_mirror_graph = 0
            vim.g.mundo_preview_bottom = 1
            vim.g.mundo_width = 30
            vim.g.mundo_preview_statusline = " "
            vim.g.mundo_tree_statusline = " "
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "potamides/pantran.nvim",
        config = function()
            require("pantran").setup({
                default_engine = "deepl",
            })
        end,
    },
    {
        'jakewvincent/mkdnflow.nvim',
        rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
        config = function()
            require('mkdnflow').setup({
                tables = {
                    trim_whitespace = true,
                    format_on_move = true,
                    auto_extend_rows = false,
                    auto_extend_cols = false
                },
            })
        end
    },
    {
        "mickael-menu/zk-nvim",
        config = function()
            require("zk").setup({
                picker = "telescope",
                lsp = {
                    config = {
                        cmd = { os.getenv("HOME") .. "/.config/lvim/external/bin/zk", "lsp" },
                        name = "zk",
                    },
                },
                auto_attach = {
                    enabled = true,
                    filetypes = { "markdown" },
                },
            })
        end,
    }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.cmd [[set awa]]
        vim.cmd [[setlocal nospell]]
    end
})

-- Add executables to config.lua
-- { exec, keymap, name}
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "lazydocker", "<leader>dL", "LazyDocker" }
