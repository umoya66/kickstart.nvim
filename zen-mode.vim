
    {
      'folke/zen-mode.nvim',
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },

     -- I write prose in markdown, all the following is to help with that.
function _G.toggleProse()
  require("zen-mode").toggle({
    window = {
      backdrop = 1,
      width = 80
    },
    plugins = {
      gitsigns = { enabled = true },
      tmux = { enabled = true },
      kitty = {
        enabled = true,
      },
    },
    on_open = function()
      if (vim.bo.filetype == "markdown" or vim.bo.filetype == "telekasten") then
        vim.cmd 'set so=999'
        vim.cmd 'set nornu nonu'
        vim.cmd 'set wrap'
        vim.cmd 'set linebreak'
        vim.cmd 'set colorcolumn=0'

        vim.keymap.set('n', 'j', 'gj', {noremap = true})
        vim.keymap.set('n', 'k', 'gk', {noremap = true})
      end
    end,
    on_close = function()
      vim.cmd 'set so=3'
      vim.cmd 'set rnu'
      if (vim.bo.filetype == "markdown" or vim.bo.filetype == "telekasten") then
        vim.cmd 'set nowrap'
        vim.cmd 'set nolinebreak'
        vim.cmd 'set colorcolumn=80'
      end

      vim.keymap.set('n', 'j', 'j', {noremap = true})
      vim.keymap.set('n', 'k', 'k', {noremap = true})
    end
  })
end

vim.keymap.set(
  'n',
  '<localleader>m',
  ':lua _G.toggleProse()<cr>',
  {noremap = true, silent = true, desc = "Toggle Writing Mode"}
) 
