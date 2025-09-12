-- general settings
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- basic options
vim.opt.grepprg = 'rg --vimgrep -i --hidden --glob=!.git/ --glob=!vendor/'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.number = true
vim.opt.compatible = false
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.ruler = true
vim.opt.spelllang = 'en,cjk'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest,full'
vim.opt.list = true
vim.opt.listchars = 'tab:^ ,trail:~'
vim.opt.pumheight = 10
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.splitbelow = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.foldmethod = 'indent'
vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.ttimeoutlen = 10
vim.opt.shortmess:append('I')
vim.opt.textwidth = 0
vim.opt.nrformats = 'alpha'
vim.opt.tags:append('.git/tags')
vim.opt.showtabline = 2
vim.opt.laststatus = 2
vim.opt.termguicolors = true

-- filetype settings
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- keymaps
local keymap = vim.keymap.set
local keymap_opts = { noremap = true, silent = true }

-- normal mode
keymap('n', '<ESC><ESC>', ':nohlsearch<CR>', keymap_opts)
keymap('n', '<C-c>', ':tabclose!<CR>', keymap_opts)
keymap('n', '<C-n>', ':tabnew<CR>', keymap_opts)
keymap('n', '<C-h>', ':tabprevious<CR>', keymap_opts)
keymap('n', '<C-l>', ':tabnext<CR>', keymap_opts)
keymap('n', '<C-s>', ':tab split<CR>', keymap_opts)

-- insert mode emacs keybindings
keymap('i', '<C-a>', '<Home>', keymap_opts)
keymap('i', '<C-e>', '<End>', keymap_opts)
keymap('i', '<C-b>', '<Left>', keymap_opts)
keymap('i', '<C-f>', '<Right>', keymap_opts)
keymap('i', '<C-d>', '<Del>', keymap_opts)
keymap('i', '<C-k>', '<C-o>D', keymap_opts)
keymap('i', '<C-p>', '<Up>', keymap_opts)
keymap('i', '<C-n>', '<Down>', keymap_opts)

-- command line mode emacs keybindings
keymap('c', '<C-a>', '<Home>', { noremap = true })
keymap('c', '<C-e>', '<End>', { noremap = true })
keymap('c', '<C-b>', '<Left>', { noremap = true })
keymap('c', '<C-f>', '<Right>', { noremap = true })
keymap('c', '<C-d>', '<Del>', { noremap = true })
keymap('c', '<C-k>', '<C-o>D', { noremap = true })

-- terminal mode
keymap('t', '<ESC>', '<C-\\><C-n>', keymap_opts)

-- autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- multibyte space highlight
local function jisx0208_space_highlight()
  vim.cmd('syntax match JISX0208Space "　" display containedin=ALL')
  vim.cmd('highlight JISX0208Space term=underline ctermbg=LightCyan guibg=darkgray gui=underline')
end

local multibyte_space_group = augroup('MultiByteSpace', { clear = true })
autocmd({ 'BufNew', 'BufRead' }, {
  group = multibyte_space_group,
  callback = jisx0208_space_highlight,
})

-- spell check for git commit
local spell_group = augroup('Spell', { clear = true })
autocmd('FileType', {
  group = spell_group,
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- quickfix after grep
local quickfix_group = augroup('QuickFixAfterGrep', { clear = true })
autocmd('QuickFixCmdPost', {
  group = quickfix_group,
  pattern = '*grep*',
  command = 'cwindow',
})

-- runtime files
vim.cmd('runtime macros/matchit.vim')
vim.cmd('runtime ftplugin/man.vim')

-- plugin settings
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = {
              'rg',
              '--files',
              '--hidden',
              '--glob=!.git/',
            },
          },
        },
      })

      -- telescope keymaps
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
      vim.keymap.set('n', '<leader>fc', builtin.commands, {})
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
      vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, {})
      vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})
      vim.keymap.set('n', '<leader>fR', builtin.lsp_references, {})
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme tokyonight')
    end,
  },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/nvim-cmp' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'tokyonight',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        tabline = {
          lualine_a = { 'tabs' },
          lualine_b = {},
          lualine_c = { 
            {
              function()
                return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
              end,
              icon = '📁'
            }
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        extensions = { 'nvim-tree', 'quickfix' }
      })
    end,
  },
  { 'neovim/nvim-lspconfig' },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 32,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { '^.git$' },
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
      keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', keymap_opts)
    end,
  },
  { 'simeji/winresizer' },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()
    end,
  },
})

-- hrsh7th/nvim-cmp
local cmp = require('cmp')
cmp.setup({
  window = {},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})
-- neovim/nvim-lspconfig
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local setup_lsp = function()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require('mason-lspconfig').setup()

  require('mason-lspconfig').setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ['lua_ls'] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyDone',
  callback = setup_lsp,
})
