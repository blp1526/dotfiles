-- general settings {{{
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

nnoremap <silent><leader>t :split\|terminal<CR>

augroup TerminalNoNumber
  autocmd!
  autocmd TermOpen * setlocal nonumber
augroup END
]])
-- }}}

-- plugin settings {{{
require('plugins')
-- folke/tokyonight.nvim {{{
vim.cmd([[
colorscheme tokyonight
]])
-- }}}
-- hrsh7th/nvim-cmp {{{
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
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
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
-- }}}
-- itchyny/lightline.vim {{{
-- https://github.com/itchyny/lightline.vim/issues/245#issuecomment-375136013
vim.cmd([[
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'tab': {
      \   'active': [ 'tabnum', 'cwd', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'cwd', 'filename', 'modified' ]
      \ },
      \ 'tab_component_function': {
      \   'cwd': 'LightlineCurrentDirectory'
      \ }
      \ }
function! LightlineCurrentDirectory(n) abort
  return fnamemodify(getcwd(tabpagewinnr(a:n), a:n), ':t')
endfunction
]])
-- }}}
-- neovim/nvim-lspconfig {{{
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end
-- }}}
-- nvim-telescope/telescope.nvim {{{
require('telescope').setup {
  defaults = { file_ignore_patterns = { '^./.git/' } }
}

vim.cmd([[
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>f :Telescope find_files hidden=true<CR>
nnoremap <leader>g :Telescope ghq list<CR>
]])
-- }}}
-- phaazon/hop.nvim {{{
require('hop').setup()
vim.cmd([[
nnoremap <leader>e :HopPattern<CR>
]])
-- }}}
-- williamboman/nvim-lsp-installer {{{
local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require "lspconfig"
lsp_installer.setup()
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup {
    on_attach = on_attach,
  }
end
-- }}}
-- }}}

--" vim: foldmethod=marker
--" vim: foldcolumn=0
--" vim: foldlevel=0
