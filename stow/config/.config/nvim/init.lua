vim.cmd([[
" general settings {{{
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
" }}}
]])

require('plugins')
require('hop').setup()

vim.cmd([[
" plugin settings {{{
" folke/tokyonight.nvim {{{
colorscheme tokyonight
" }}}
" itchyny/lightline.vim {{{
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" }}}
" nvim-telescope/telescope.nvim {{{
nnoremap <leader>f :Telescope git_files show_untracked=true<CR>
" }}}
" phaazon/hop.nvim {{{
nnoremap <leader>e :HopPattern<CR>
" }}}
" }}}

" vim: foldmethod=marker
" vim: foldcolumn=0
" vim: foldlevel=0
]])

