scriptencoding utf-8

" general settings {{{
" packages {{{
let s:plug_path = '~/.vim/autoload/plug.vim'
if empty(glob(s:plug_path))
  let s:plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent execute '!curl -fLo '.s:plug_path.' --create-dirs '.s:plug_url
  autocmd VimEnter * PlugInstall --sync | source '~/.vimrc'
endif

call plug#begin()
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'preservim/nerdtree'
  Plug 'simeji/winresizer'
  Plug 'thinca/vim-qfreplace'
call plug#end()
" }}}
" functions {{{
function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan guibg=darkgray gui=underline
endfunction
" }}}
" map {{{
" nnoremap {{{
nnoremap <silent><ESC><ESC> :nohlsearch<CR>
" tab
nnoremap <silent><C-c> :tabclose<CR>
nnoremap <silent><C-n> :tabnew<CR>
nnoremap <silent><C-h> :tabprevious<CR>
nnoremap <silent><C-l> :tabnext<CR>
nnoremap <silent><C-s> :tab split<CR>
" }}}
" inoremap {{{
" insert mode emacs keybindings
inoremap <silent><C-a> <Home>
inoremap <silent><C-e> <End>
inoremap <silent><C-b> <Left>
inoremap <silent><C-f> <Right>
inoremap <silent><C-d> <Del>
inoremap <silent><C-k> <C-o>D
inoremap <silent><C-p> <Up>
inoremap <silent><C-n> <Down>
" }}}
" cnoremap {{{
" command line mode emacs keybindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-o>D
" }}}
" tnoremap {{{
" exit terminal
tnoremap <ESC> <C-\><C-n>
" }}}
" }}}
" augroup {{{
augroup QuickFixAfterGrep
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

augroup MultiByteSpace
  autocmd!
  autocmd BufNew,BufRead * call JISX0208SpaceHilight()
augroup END

augroup Spell
  autocmd!
  autocmd Filetype gitcommit setlocal spell
augroup END
" }}}
" runtime {{{
" /usr/share/vim/vim74/ftplugin/man.vim
runtime macros/matchit.vim
runtime ftplugin/man.vim
" }}}
" options {{{
set grepprg=rg\ --vimgrep\ -i\ --hidden\ --glob=!.git/\ --glob=!vendor/
set noswapfile
set nobackup
set number
set nocompatible
set notagbsearch
set maxmempattern=2000000
set hlsearch
set cursorline
set nowrap
set ruler
set spelllang+=cjk
set ignorecase
set autoindent
set wildmenu
set wildmode=longest,full
set list
set listchars=tab:^\ ,trail:~
set pumheight=10
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=0
set splitbelow
set backspace=indent,eol,start
set foldmethod=indent
set foldcolumn=0
set foldlevel=99
set ttimeoutlen=10
set shortmess+=I
set textwidth=0
set smartcase
set nrformats=alpha
set tags+=.git/tags
set showtabline=2
set laststatus=2
" }}}
" }}}

" plugin settings {{{
" ctrlpvim/ctrlp.vim {{{
let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-n>'],
\ 'PrtSelectMove("k")':   ['<c-p>'],
\ 'PrtHistory(-1)':       ['<down>'],
\ 'PrtHistory(1)':        ['<up>'],
\ }
let g:ctrlp_match_window  = 'bottom,order:btt,min:1,max:100,results:100'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard | grep -v "^vendor/" | uniq']
let g:ctrlp_show_hidden   = 1
let g:ctrlp_cmd = 'CtrlPCurWD'
" }}}
" itchyny/lightline.vim {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" }}}
" preservim/nerdtree {{{
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 32
nnoremap <silent><Leader>n :NERDTreeToggle<CR>
" }}}
" }}}

set termguicolors
filetype plugin indent on
syntax on

" vim: foldmethod=marker
" vim: foldcolumn=0
" vim: foldlevel=0
