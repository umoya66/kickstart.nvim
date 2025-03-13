--[[
https://github.com/nvim-lua/kickstart.nvim
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,

      ---@type false | "classic" | "modern" | "helix"
      preset = 'helix',
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      -- local utils = require 'telescope.utils'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- nnoremap <leader>ff <cmd>Telescope find_files<cr>
      -- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      -- nnoremap <leader>fb <cmd>Telescope buffers<cr>
      -- nnoremap <leader>fh <cmd>Telescope help_tags<cr>

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      --
      -- Shortcut for searching current dif
      -- vim.keymap.set('f', '<leader>sf', function()
      --   builtin.find_files { cwd = utils.buffer_dir() }
      -- end, { desc = '[S]earch [f]current dir files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      -- if vim.g.have_nerd_font then
      --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      --   local diagnostic_signs = {}
      --   for type, icon in pairs(signs) do
      --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
      --   end
      --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
      -- end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true }
      --   local lsp_format_opt
      --   if disable_filetypes[vim.bo[bufnr].filetype] then
      --     lsp_format_opt = 'never'
      --   else
      --     lsp_format_opt = 'fallback'
      --   end
      --   return {
      --     timeout_ms = 5000,
      --     lsp_format = lsp_format_opt,
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { 'isort', 'black' },
        python = { 'black' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },

      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },
          -- change  to Classic completion keymaps
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          per_filetype = {
            codecompanion = { 'codecompanion' },
          },
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {

    'github/copilot.vim',
    opts = {},
    config = function() end,
  },

  -- {
  --   'olimorris/codecompanion.nvim',
  --   config = true,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   opts = {
  --     strategies = {
  --       -- Change the default chat adapter
  --       chat = {
  --         adapter = 'openai',
  --       },
  --     },
  --     opts = {
  --       -- Set debug logging
  --       log_level = 'DEBUG',
  --     },
  --   },
  -- },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search

  -- Michael Hatton additional plugins
  --
  --
  -- {
  --
  --   require 'nvim-tree/nvim-web-devicons',
  --   opts = {},
  -- },

  {
    'ibhagwan/fzf-lua',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- or if using mini.icons/mini.nvim
    dependencies = { 'echasnovski/mini.icons' },
    opts = {},
  },

  {
    'frankroeder/parrot.nvim',
    dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
    -- optionally include "rcarriga/nvim-notify" for beautiful notifications
    opts = {
      providers = {
        gemini = {
          api_key = os.getenv 'GEMINI_API_KEY',
        },
        openai = {
          api_key = os.getenv 'OPENAI_API_KEY',
        },
      },
    },
  },
  -- config = function()
  --   require('parrot').setup {
  --     -- Providers must be explicitly added to make them available.
  --     providers = {
  --       anthropic = {
  --         api_key = os.getenv 'ANTHROPIC_API_KEY',
  --       },
  --       gemini = {
  --         api_key = os.getenv 'GEMINI_API_KEY',
  --       },
  --       groq = {
  --         api_key = os.getenv 'GROQ_API_KEY',
  --       },
  --       mistral = {
  --         api_key = os.getenv 'MISTRAL_API_KEY',
  --       },
  --       pplx = {
  --         api_key = os.getenv 'PERPLEXITY_API_KEY',
  --       },
  --       -- provide an empty list to make provider available (no API key required)
  --       -- ollama = {},
  --       openai = {
  --         api_key = os.getenv 'OPENAI_API_KEY',
  --       },
  --       github = {
  --         api_key = os.getenv 'GITHUB_TOKEN',
  --       },
  --       nvidia = {
  --         api_key = os.getenv 'NVIDIA_API_KEY',
  --       },
  --       xai = {
  --         api_key = os.getenv 'XAI_API_KEY',
  --       },
  --     },
  --   }
  -- end,

  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    'junegunn/limelight.vim',
    opts = {},
    config = function() end,
  },
  {
    'junegunn/goyo.vim',
    opts = {},
    config = function() end,
  },
  {
    'junegunn/seoul256.vim',
    opts = {},
    config = function() end,
  },
  {
    'tpope/vim-surround',
    opts = {},
    config = function() end,
  },
  {
    'preservim/tagbar',
    opts = {},
    config = function() end,
  },
  {
    'wakatime/vim-wakatime',
    opts = {},
    config = function() end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    opts = {},
    config = function() end,
  },

  {
    'alexghergh/nvim-tmux-navigation', config = function()

    local nvim_tmux_nav = require('nvim-tmux-navigation')

    nvim_tmux_nav.setup {
        disable_when_zoomed = true -- defaults to false
    }

    vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
    vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
    vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
    vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
    vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
    vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

  end
  },

  { 'bbjornstad/pretty-fold.nvim', 
     -- Pretty Fold is a lua plugin for Neovim which provides framework for easy foldtext customization. 
     config = function()
     require('pretty-fold').setup{
	     'py', {
		     process_comment_signs = "delete",
		     comment_signs = { '#' },
         add_close_pattern = false,
	     }
     }
     end
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    -- icons = vim.g.have_nerd_font and {} or {
    --   cmd = '⌘',
    --   config = '🛠',
    --   event = '📅',
    --   ft = '📂',
    --   init = '⚙',
    --   keys = '🗝',
    --   plugin = '🔌',
    --   runtime = '💻',
    --   require = '🌙',
    --   source = '📄',
    --   start = '🚀',
    --   task = '📌',
    --   lazy = '💤 ',
    -- },
  },
})
-- I write prose in markdown, all the following is to help with that.
function _G.toggleProse()
  require('zen-mode').toggle {
    window = {
      backdrop = 1,
      width = 100,
      options = {
        signcolumn = 'no', -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
        foldcolumn = '0', -- disable fold column
        list = false, -- disable whitespace characters
      },
    },
    plugins = {
      gitsigns = { enabled = false },
      tmux = { enabled = false },
      kitty = { enabled = false },
      -- this will change the font size on wezterm when in zen mode
      -- See alse also the Plugins/Wezterm section in this projects README
      wezterm = {
        enabled = false,
        -- can be either an absolute font size or the number of incremental steps
        font = '+4', -- (10% increase per step)
      },
    },
    on_open = function()
      if vim.bo.filetype == 'markdown' or vim.bo.filetype == 'text' then
        --
        --  Hides status bar when only one file open
        vim.opt.laststatus = 1
        vim.opt.showmode = false
        vim.opt.showcmd = false
        vim.opt.spell = true
        vim.opt.textwidth = 80
        vim.opt.formatoptions = 'tcqwn'
        vim.opt.linespace = 15
        vim.opt.guifont = 'Menlo:h16'
        vim.opt.background = 'dark'

        vim.cmd 'syntax off' -- Or consider vim.o.syntax = nil or vim.o.syntax = "" or vim.o.syntax = false (less common, 'syntax off' command is more widely used and understood)
        vim.opt.scrolloff = 999

        -- Remove right sidebar
        vim.cmd 'set guioptions-=r'
        -- Remove left sidebars
        vim.cmd 'set guioptions-=L'

        --  Set the cursor to not blink
        vim.cmd 'set guicursor=a:blinkon0'
        --
        -- set Limelight settings
        -- Color name (:help cterm-colors) or ANSI code
        -- vim.cmd 'let g:limelight_conceal_ctermfg = "gray"'
        vim.g.limelight_conceal_ctermfg = 'gray'
        vim.g.limelight_conceal_ctermfg = 240

        -- Color name (:help gui-colors) or RGB color
        vim.g.limelight_conceal_guifg = 'DarkGray'
        vim.g.limelight_conceal_guifg = '#777777'

        -- Default: 0.5
        vim.g.limelight_default_coefficient = 0.7

        -- Number of preceding/following paragraphs to include (default: 0)
        vim.g.limelight_paragraph_span = 0

        -- Beginning/end of paragraph
        --   When there's no empty line between the paragraphs
        --   and each paragraph starts with indentation
        -- vim.cmd 'let g:limelight_bop = "^\\s"'
        -- vim.cmd 'let g:limelight_eop = "\ze\n^\\s"'

        -- Highlighting priority (default: 10)
        --   Set it to -1 not to overrule hlsearch
        vim.g.limelight_priority = -1
        vim.g.seoul256_background = 236
        vim.cmd 'colo seoul256'
        vim.cmd 'Limelight'
        vim.cmd 'Goyo'

        -- vim.keymap.set('n', 'j', 'gj', { noremap = true })
        -- vim.keymap.set('n', 'k', 'gk', { noremap = true })
      end
    end,
    on_close = function()
      vim.cmd 'set so=3'
      vim.cmd 'set rnu'
      if vim.bo.filetype == 'markdown' or vim.bo.filetype == 'text' then
        vim.cmd 'set nowrap'
        vim.cmd 'set nolinebreak'
        vim.cmd 'set colorcolumn=80'
      end
      vim.cmd 'set nospell'
      vim.cmd 'set nocompatible' -- Vim defaults rather than vi ones. Keep at top.
      vim.cmd 'filetype plugin indent on' -- Enable filetype-specific settings.
      vim.cmd 'syntax on' -- Enable syntax highlighting.
      vim.cmd 'set backspace=2' -- Make the backspace behave as most applications.
      vim.cmd 'set autoindent' -- Use current indent for new lines.
      vim.cmd 'set display=lastline' -- Show as much of the line as will fit.
      vim.cmd 'set wildmenu' -- Better tab completion in the commandline.
      vim.cmd 'set wildmode=list:longest' -- List all matches and complete to the longest match.
      vim.cmd 'set showcmd' -- Show (partial) command in bottom-right.
      vim.cmd 'set expandtab' -- Use spaces instead of tabs for indentation.
      vim.cmd 'set smarttab' -- Backspace removes 'shiftwidth' worth of spaces.
      vim.cmd 'set number' -- Show line numbers.
      vim.cmd 'set wrap' -- Wrap long lines.
      vim.cmd 'set laststatus=2' -- Always show the statusline.
      vim.cmd 'set ruler' -- Show the ruler in the statusline.
      vim.cmd 'set incsearch' -- Jump to search match while typing.
      vim.cmd 'set hlsearch' -- Highlight the last used search pattern.
      vim.cmd 'set ignorecase' -- Searching with / is case-insensitive.
      vim.cmd 'set smartcase' -- Disable 'ignorecase' if the term contains upper-case.
      vim.cmd 'set nrformats-=octal' -- Remove octal support from 'nrformats'.
      vim.cmd 'set tabstop=4' -- Size of a Tab character.
      vim.cmd 'set shiftwidth=0' -- Use same value as 'tabstop'.
      vim.cmd 'set softtabstop=-1' -- Use same value as 'shiftwidth'.
      vim.cmd 'set formatoptions+=ncroqlj' -- Control automatic formatting.
      vim.cmd 'colo tokyonight-night'

      vim.cmd 'Limelight!'
      vim.cmd 'Goyo!'

      -- vim.keymap.set('n', 'j', 'j', { noremap = true })
      -- vim.keymap.set('n', 'k', 'k', { noremap = true })
    end,
  }
end

vim.keymap.set('n', '<localleader>m', ':lua _G.toggleProse()<cr>', { noremap = true, silent = true, desc = 'Toggle Writing Mode' })
vim.keymap.set('n', '<localleader>l', ':Lazy<cr>', { noremap = true, silent = true, desc = 'Lazy Plugin Manager' })

--vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
vim.keymap.set('v', '//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>', { noremap = true, silent = true, desc = 'Search selected text' })


-- tmux navigator
-- nnoremap <silent> <C-h> <Cmd>NvimTmuxNavigateLeft<CR>
-- vim.keymap.set('n', '<C-h>', ':NvimTmuxNavigateLeft', { noremap = true, silent = true, desc = 'Tmux navigate left' })
-- -- nnoremap <silent> <C-j> <Cmd>NvimTmuxNavigateDown<CR>
-- vim.keymap.set('n', '<C-j>', ':NvimTmuxNavigateDown', { noremap = true, silent = true, desc = 'Tmux navigate down' })
-- -- nnoremap <silent> <C-k> <Cmd>NvimTmuxNavigateUp<CR>
-- vim.keymap.set('n', '<C-k>', ':NvimTmuxNavigateUp', { noremap = true, silent = true, desc = 'Tmux navigate up' })
-- -- nnoremap <silent> <C-l> <Cmd>NvimTmuxNavigateRight<CR>
-- vim.keymap.set('n', '<C-l>', ':NvimTmuxNavigateRight', { noremap = true, silent = true, desc = 'Tmux navigate right' })
-- -- nnoremap <silent> <C-\> <Cmd>NvimTmuxNavigateLastActive<CR>
-- vim.keymap.set('n', '<C-\\>', ':NvimTmuxNavigateLastActive', { noremap = true, silent = true, desc = 'Tmux navigate last active' })
-- -- nnoremap <silent> <C-Space> <Cmd>NvimTmuxNavigateNext<CR>
-- vim.keymap.set('n', '<C-Space>', ':NvimTmuxNavigateNext', { noremap = true, silent = true, desc = 'Tmux navigate next' })
--
--
--
-- set up folding
-- vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 100
vim.opt.foldlevelstart = 5
vim.opt.foldnestmax = 4

vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')

if vim.loop.os_uname().sysname == 'Linux' then
  -- Linux
elseif vim.loop.os_uname().sysname == 'Windows_NT' then
  -- Windows options here
elseif vim.loop.os_uname().sysname == 'Darwin' then -- 'Darwin' is the sysname for macOS
  -- Mac options here
  vim.g.tagbar_ctags_bin = '/opt/homebrew/Cellar/universal-ctags/p6.1.20241103.0/bin/ctags'
end

-- colorizer set update
---- Attaches to every FileType mode
require('colorizer').setup()

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require('colorizer').setup {
  'css',
  'javascript',
  html = {
    mode = 'foreground',
  },
}

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require('colorizer').setup({
  'css',
  'javascript',
  html = { mode = 'background' },
}, { mode = 'foreground' })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require('colorizer').setup {
  '*', -- Highlight all files, but customize some others.
  css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
  html = { names = false }, -- Disable parsing "names" like Blue or Gray
}

-- Exclude some filetypes from highlighting by using `!`
require('colorizer').setup {
  '*', -- Highlight all files, but customize some others.
  '!vim', -- Exclude vim from highlighting.
  -- Exclusion Only makes sense if '*' is specified!
}


vim.api.nvim_create_autocmd('FileType', {
	pattern = 'python',
	group = vim.api.nvim_create_augroup('py_indent', { clear = true }),
	callback = function ()
		vim.opt.foldmethod = 'indent'
	end,
})


-- require('nvim-treesitter.configs').setup {
--   pyfold = {
--     enable = true,
--     custom_foldtext = true, -- Sets provided foldtext on window where module is active
--   },
-- }

-- require('codecompanion').setup {
--   adapters = {
--     openai = require('codecompanion.adapters').extend('openai', {
--       env = {
--         api_key = 'OPENAI_API_KEY',
--       },
--     }),
--     -- ollama = require('codecompanion.adapters').extend('ollama', {
--     --   schema = {
--     --     model = {
--     --       default = 'codestral',
--     --     },
--     --   },
--     -- }),
--   },
--   strategies = {
--     chat = 'openai',
--     inline = 'openai',
--     tool = 'openai',
--   },
--   log_level = 'DEBUG',
-- }
-- require('codecompanion').setup {
--   adapters = {
--     llama3 = function()
--       return require('codecompanion.adapters').extend('ollama', {
--         name = 'llama3', -- Give this adapter a different name to differentiate it from the default ollama adapter
--         schema = {
--           model = {
--             default = 'phi3:3.8b-mini-4k-instruct-q6_K',
--           },
--           num_ctx = {
--             default = 4096,
--           },
--           num_predict = {
--             default = -1,
--           },
--         },
--       })
--     end,
--     openai = function()
--       return require('codecompanion.adapters').extend('openai', {
--         name = 'openai', -- Give this adapter a different name to differentiate it from the default ollama adapter
--         env = {
--           api_key = os.getenv 'OPENAI_API_KEY',
--         },
--         schema = {
--           model = {
--             default = 'gpt-3.5-turbo',
--           },
--           num_ctx = {
--             default = 4096,
--           },
--           num_predict = {
--             default = -1,
--           },
--         },
--       })
--     end,
--   },
--   strategies = {
--     chat = {
--       adapter = 'openai',
--     },
--     inline = {
--       adapter = 'openai',
--     },
--     agent = {
--       adapter = 'openai',
--     },
--   },
--   display = {
--     chat = {
--       window = {
--         layout = 'vertical', -- float|vertical|horizontal|buffer
--       },
--     },
--   },
--   opts = {
--     ---@param adapter CodeCompanion.Adapter
--     ---@return string
--     system_prompt = function(adapter)
--       if adapter.schema.model.default == 'llama3.1:latest' then
--         return 'My custom system prompt'
--       end
--       return 'My default system prompt'
--     end,
--   },
-- }

-- gemini = {
--   api_key = os.getenv 'GEMINI_API_KEY',
-- },
-- require('codecompanion').setup {
--   -- display = {
--   --   action_palette = {
--   --     width = 95,
--   --     height = 10,
--   --     prompt = 'Prompt ', -- Prompt used for interactive LLM calls
--   --     provider = 'default', -- default|telescope|mini_pick
--   --     opts = {
--   --       show_default_actions = true, -- Show the default actions in the action palette?
--   --       show_default_prompt_library = true, -- Show the default prompt library in the action palette?
--   --     },
--   --   },
--   -- },
--   adapters = {
--     openai = function()
--       return require('codecompanion.adapters').extend('openai', {
--         name = "openai", -- Give this adapter a different name to differentiate it from the default ollama adapter
--         schema = {
--           model = {
--             default = "o3-mini",
--           },
--           num_ctx = {
--             default = 16384,
--           },
--           num_predict = {
--             default = -1,
--           },
--         env = {
--           api_key = 'OPENAI_API_KEY',
--         },
--         },
--         })
--     end,
--   },
--   strategies = {
--     chat = 'openai',
--     inline = 'openai',
--     tool = 'openai',
--   },
--   log_level = 'DEBUG',
-- }
-- require('codecompanion').setup {
--   strategies = {
--     chat = {
--       adapter = 'anthropic',
--     },
--     inline = {
--       adapter = 'anthropic',
--     },
--   },
-- }
-- require("codecompanion").setup({
--   adapters = {
--     my_openai = function()
--       return require("codecompanion.adapters").extend("openai_compatible", {
--         env = {
--           url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
--           api_key = "OPENAI_API_KEY", -- optional: if your endpoint is authenticated
--           chat_url = "/v1/chat/completions", -- optional: default value, override if different
--         },
--         schema = {
--           model = {
--             default = "deepseek-r1-671b",  -- define llm model to be used
--           },
--           temperature = {
--             order = 2,
--             mapping = "parameters",
--             type = "number",
--             optional = true,
--             default = 0.8,
--             desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
--             validate = function(n)
--               return n >= 0 and n <= 2, "Must be between 0 and 2"
--             end,
--           },
--           max_completion_tokens = {
--             order = 3,
--             mapping = "parameters",
--             type = "integer",
--             optional = true,
--             default = nil,
--             desc = "An upper bound for the number of tokens that can be generated for a completion.",
--             validate = function(n)
--               return n > 0, "Must be greater than 0"
--             end,
--           },
--           stop = {
--             order = 4,
--             mapping = "parameters",
--             type = "string",
--             optional = true,
--             default = nil,
--             desc = "Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
--             validate = function(s)
--               return s:len() > 0, "Cannot be an empty string"
--             end,
--           },
--           logit_bias = {
--             order = 5,
--             mapping = "parameters",
--             type = "map",
--             optional = true,
--             default = nil,
--             desc = "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
--             subtype_key = {
--               type = "integer",
--             },
--             subtype = {
--               type = "integer",
--               validate = function(n)
--                 return n >= -100 and n <= 100, "Must be between -100 and 100"
--               end,
--             },
--           },
--         },
--       })
--     end,
--   },
-- })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
