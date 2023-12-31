-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.keys.insert_mode["jj"] = "<esc>"
--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT


-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedark"
vim.cmd("let g:sonokai_style = 'andromeda'")
vim.cmd("let g:sonokai_enable_italic_comment = 1")
vim.opt.shiftwidth = 4
lvim.format_on_save = false
lvim.builtin.terminal.open_mapping = "<c-t>"
lvim.builtin.terminal.direction = "float"
lvim.builtin.nvimtree.setup.auto_reload_on_write=true
-- vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true })

-- python
lvim.builtin.treesitter.ensure_installed = {
    "python",
}
-- lvim.plugins = {
--     "ChristianChiarulli/swenv.nvim",
--     "stevearc/dressing.nvim",
--     "ludovicchabant/vim-gutentags"
-- }
lvim.builtin.which_key.mappings["C"] = {
    name = "Python",
    c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
vim.g.python3_host_prog = '/data/home/taolinzhang/miniconda3/bin/python3'

local function open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
-- lvim.builtin.nvimtree.setup.open_on_setup = true

lvim.builtin.terminal.size = 90
-- lvim.builtin.terminal.direction = "vertical"
lvim.keys.normal_mode["<C-b>"] = "<esc><cmd>ToggleTermSendCurrentLine<CR>"
lvim.keys.visual_mode["<C-b>"] = ":'<,'>ToggleTermSendVisualLines<CR>"
lvim.keys.term_mode["<C-l>"] = "<C-l>"
lvim.keys.normal_mode["∆"] = ":m .+1<CR>=="
lvim.keys.normal_mode["˚"] = ":m .-2<CR>=="
lvim.keys.visual_mode["∆"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["˚"] = ":m '<-2<CR>gv=gv"
lvim.keys.insert_mode["∆"] = "<Esc>:m .+1<CR>==gi"
lvim.keys.insert_mode["˚"] = "<Esc>:m .-2<CR>==gi"
lvim.keys.insert_mode["<c-=>"] = "<Esc>:Autopep8<CR>==gi"
lvim.keys.visual_mode["<c-=>"] = ":Autopep8<CR>"
lvim.keys.normal_mode["<c-=>"] = ":Autopep8<CR>"
lvim.keys.visual_mode["d"] = '\"_d'
lvim.keys.visual_mode["dd"] = '\"_dd'
lvim.keys.normal_mode["d"] = '\"_d'
lvim.keys.normal_mode["dd"] = '\"_dd'
lvim.keys.visual_mode["x"] = '\"_x'
lvim.keys.visual_mode["c"] = '\"_c'
lvim.keys.normal_mode["x"] = '\"_x'
lvim.keys.normal_mode["c"] = '\"_c'

-- vim.keymap.set('n', '<leader>C', require('osc52').copy_operator, {expr = true})
-- vim.keymap.set('n', '<leader>CC', '<leader>C_', {remap = true})
-- vim.keymap.set('v', '<leader>C', require('osc52').copy_visual)
-- osc52 copy function
function copy()
    if vim.v.event.operator == 'y' and vim.v.event.regname == 'c' then
        require('osc52').copy_register('c')
    end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

-- nvim-osc52 clipboard provider
local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
    return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end
vim.g.clipboard = {
    name = 'osc52',
    copy = {['+'] = copy, ['*'] = copy},
    paste = {['+'] = paste, ['*'] = paste},
}

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["<F2>"] = ":set spell!<CR>" -- toggle spell check
lvim.keys.normal_mode["<F4>"] = ":set spelllang=en<CR>"
lvim.keys.normal_mode["<F3>"] = ":set spelllang=pt_br<CR>"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
-- lvim.keys.normal_mode["<A-l>"] = "<end><cmd>ToggleTermSend!a<C-l>" -- Davi - Press <crtl>+<alt>+l to clear the terminal

-- lvim.keys.normal_mode["<A-l>"] = "<C-l>" -- Davi - Press <crtl>+<alt>+l to clear the terminal


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
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
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
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

-- Additional Plugins
lvim.plugins = {
    { "folke/tokyonight.nvim" },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    { "lervag/vimtex" },
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     run = "cd app && npm install",
    --     ft = "markdown",
    --     config = function()
    --         vim.g.mkdp_auto_start = 0
    --     end,
    -- },
    { "JuliaEditorSupport/julia-vim" },
    { "rafi/awesome-vim-colorschemes" },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup()
        end,
    },
    {"tell-k/vim-autopep8"},
    {'ojroques/nvim-osc52',
    },
    {"ChristianChiarulli/swenv.nvim"},
    {"stevearc/dressing.nvim"},
    {"ludovicchabant/vim-gutentags"},
    {"neoclide/coc-python"},
}
vim.g.autopep8_disable_show_diff=1

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
