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
  Plug 'aklt/plantuml-syntax'
  Plug 'cespare/vim-toml'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dense-analysis/ale'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'easymotion/vim-easymotion'
  Plug 'embear/vim-localvimrc'
  Plug 'elzr/vim-json'
  Plug 'fatih/vim-go'
  Plug 'github/copilot.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'jparise/vim-graphql'
  Plug 'othree/html5.vim'
  Plug 'plasticboy/vim-markdown'
  Plug 'previm/previm'
  Plug 'rust-lang/rust.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'sgur/vim-editorconfig'
  Plug 'simeji/winresizer'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'thinca/vim-qfreplace'
  Plug 'Yggdroot/indentLine'

  if has('nvim')
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'phaazon/hop.nvim'
  endif
call plug#end()
" }}}
" variables {{{
" netrw
let g:netrw_liststyle = 3
let g:netrw_winsize = 75
let g:netrw_altv = 1
let g:netrw_alto = 1
" }}}
" functions {{{
function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

" }}}
" highlight {{{
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
highlight StatusLine ctermbg=black
highlight Search  ctermfg=0 ctermbg=14
highlight Visual  ctermfg=1 ctermbg=15

highlight Folded     ctermfg=0 ctermbg=10
highlight FoldColumn ctermfg=0 ctermbg=10

" http://secret-garden.hatenablog.com/entry/2016/08/16/000149
highlight link EndOfBuffer Ignore
" }}}
" map {{{
" http://d.hatena.ne.jp/h1mesuke/20080327/p1
nnoremap <silent><ESC><ESC> :noh<CR>

" http://qiita.com/kuwana/items/d9778a9ec42a53b3aa10
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" http://cohama.hateblo.jp/entry/20130529/1369843236
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" tab
nnoremap <silent><C-c> :tabclose<CR>
nnoremap <silent><C-n> :tabnew<CR>
nnoremap <silent><C-h> :tabprevious<CR>
nnoremap <silent><C-l> :tabnext<CR>
nnoremap <silent><C-s> :tab split<CR>

" selected text replacement
vnoremap <C-t> :s/\%V

" tab new gf
nnoremap gf <C-w>gf

" search by yanked words
nnoremap <leader>y /<C-R>"<CR>

" spell suggestion
nnoremap <leader>s z=

" jump to the first line that contains the keyword under the cursor
" via :help [_CTRL-I
nnoremap <leader>k [<C-i>

" full path
nnoremap <C-g> 1<C-g>

" netrw
nnoremap <silent><LEADER>e :Explore<CR>
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

augroup Log
  autocmd!
  autocmd BufNewFile,BufRead *.log     setlocal cursorline
  autocmd BufNewFile,BufRead *.log*.gz setlocal cursorline
  autocmd Filetype           qf        setlocal cursorline
augroup END

augroup Spell
  autocmd!
  autocmd Filetype gitcommit setlocal spell
augroup END

augroup Systemd
  autocmd!
  autocmd BufNewFile,BufRead *.service set filetype=systemd
augroup END
" }}}
" runtime {{{
" /usr/share/vim/vim74/ftplugin/man.vim
runtime macros/matchit.vim
runtime ftplugin/man.vim
" }}}
" options {{{
" set clipboard=unnamedplus
" set grepprg=ag\ --unrestricted\ --hidden\ --ignore-dir=.git\ --ignore-dir=vendor
set grepprg=ag\ --hidden\ --ignore-dir=.git\ --ignore-dir=vendor
set noswapfile
set nobackup
set nonumber
set nocompatible
set notagbsearch
set maxmempattern=2000000
set hlsearch
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
" dhruvasagar/vim-table-mode {{{
let g:table_mode_corner='|'
" }}}
" easymotion/vim-easymotion {{{
if !has('nvim')
  map <leader>f <Plug>(easymotion-sn)
  omap <leader>f <Plug>(easymotion-tn)
endif
" }}}
" elzr/vim-json {{{
let g:vim_json_syntax_conceal = 0
" }}}
" embear/vim-localvimrc {{{
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0
" }}}
" fatih/vim-go {{{
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1

let g:go_metalinter_command = "golangci-lint run"

let g:go_fmt_command = 'goimports'
let g:go_fmt_options = {
    \ 'gofmt': '-s',
    \ }

let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1

augroup VimGo
  autocmd!
  autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <leader>d <Plug>(go-def-split)
  autocmd FileType go nmap <leader>e <Plug>(go-iferr)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>m <Plug>(go-metalinter)
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
augroup END
" }}}
" folke/tokyonight.nvim {{{
let s:lightline_colorscheme = 'wombat'
if has('nvim')
  colorscheme tokyonight
  let s:lightline_colorscheme = 'tokyonight'
endif
" }}}
" itchyny/lightline.vim {{{
let g:lightline = {
      \ 'colorscheme': s:lightline_colorscheme,
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
if has('nvim')
  nnoremap <leader>g :Telescope git_files<CR>
endif
" }}}
" phaazon/hop.nvim {{{
if has('nvim')
  :lua require'hop'.setup()
  nnoremap <leader>f :HopPattern<CR>
endif
" }}}
" plasticboy/vim-markdown {{{
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
" }}}
" previm/previm {{{
if has('mac')
  let g:previm_open_cmd = 'open'
endif
" }}}
" rust-lang/rust.vim {{{
let g:rustfmt_autosave = 1
" }}}
" scrooloose/nerdtree {{{
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 18
noremap <Leader>n :NERDTreeToggle<CR>
" }}}
" Yggdroot/indentLine {{{
let g:indentLine_enabled = 1
" }}}
" }}}

set termguicolors
filetype plugin indent on
syntax on

" vim: foldmethod=marker
" vim: foldcolumn=0
" vim: foldlevel=0
