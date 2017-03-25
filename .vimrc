scriptencoding utf-8

" personal settings {{{
" functions {{{
function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

function! CwdGitBranch()
  try
    if match(expand("%:p"), escape(getcwd(), "~")) == 0 && isdirectory(getcwd() . "/.git")
      " head_list is ['ref:', 'refs/heads/branch_name'] or commit hash
      let head_list = split(readfile(getcwd() . "/.git/HEAD")[0])
      let last_index = (len(head_list) - 1)
      let branch = substitute(head_list[last_index], "refs/heads/", "", "")
      return " " . branch  . " |"
    else
      return ""
    endif
  catch
    return " " . v:exception . " |"
  endtry
endfunction

function! FtOrNoFt()
  if &filetype !=? ""
    return &filetype
  else
    return "no ft"
  endif
endfunction
" }}}
" highlight {{{
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
highlight Search  ctermfg=0 ctermbg=14
highlight Visual  ctermfg=1 ctermbg=15

highlight Folded     ctermfg=0 ctermbg=10
highlight FoldColumn ctermfg=0 ctermbg=10

" http://secret-garden.hatenablog.com/entry/2016/08/16/000149
highlight link EndOfBuffer Ignore
" }}}
" key mapping {{{
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

" http://deris.hatenablog.jp/entry/2013/05/15/024932
" nnoremap / /\v

" tab
nnoremap <silent><C-c> :tabclose<CR>
nnoremap <silent><C-n> :tabnew<CR>
nnoremap <silent><C-h> :tabprevious<CR>
nnoremap <silent><C-l> :tabnext<CR>

" ctags
noremap <C-]> g<C-]>

" selected text replacement
vnoremap <C-t> :s/\%V

" tab new gf
nnoremap gf <C-w>gf
" }}}
" augroup {{{
augroup MultiByteSpace
  autocmd!
  autocmd BufNew,BufRead * call JISX0208SpaceHilight()
augroup END

augroup CustomSyntaxHighlight
  autocmd!
  autocmd BufNewFile,BufRead *.json.jbuilder set filetype=ruby
  autocmd BufNewFile,BufRead *.xlsx.axlsx    set filetype=ruby
  autocmd BufNewFile,BufRead *.cap           set filetype=ruby
  autocmd BufNewFile,BufRead Guardfile       set filetype=ruby
  autocmd BufNewFile,BufRead Capfile         set filetype=ruby
  autocmd BufNewFile,BufRead *.t             set filetype=perl
  autocmd BufNewFile,BufRead *.psgi          set filetype=perl
augroup END

" http://d.hatena.ne.jp/rdera/20081022/1224682665
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

augroup Log
  autocmd!
  autocmd BufNewFile,BufRead *.log     set cursorline
  autocmd BufNewFile,BufRead *.log*.gz set cursorline
augroup END

augroup Vint
  autocmd!
  autocmd BufNewFile,BufRead *.vim let g:syntastic_vim_checkers = ['vint']
augroup END
" }}}
" runtime {{{
" /usr/share/vim/vim74/ftplugin/man.vim
runtime macros/matchit.vim
runtime ftplugin/man.vim
" }}}
" set option {{{
set nocompatible
set hlsearch
set nowrap
set ruler
set ignorecase
set nobackup
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

set laststatus=2
set statusline=\|\ %t
set statusline+=%m
set statusline+=%r\ \|
set statusline+=%{CwdGitBranch()}
set statusline+=%=
set statusline+=\|\ %{&fileformat}\ \|
set statusline+=\ %{&encoding}\ \|
set statusline+=\ %{FtOrNoFt()}\ \|
set statusline+=\ %L\ \|
set statusline+=\ %l,%c\ \|
" }}}
" misc {{{
let g:mapleader = ','
noremap \ ,

" Netrw
" https://shapeshed.com/vim-netrw/
" netrw-i => CHANGE LISTING STYLE (THIN LOG WIDE TREE)
" netrw-t => BROWSING WITH A NEW TAB
" netrw-% => OPEN A NEW FILE IN NETRW'S CURRENT DIRECTORY
" netrw-d => MAKING A NEW DIRECTORY
" netrw-R => RENAMING FILES OR DIRECTORIES
" netrw-D => DELETING FILES OR DIRECTORIES
let g:netrw_liststyle = 3
let g:netrw_winsize = 75
let g:netrw_altv = 1
let g:netrw_alto = 1
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
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:100,results:100'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|vendor|local|tmp|coverage)|(\.(swp|ico|git|svn|ccache|cache))$'
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlPCurWD'
" }}}
" scrooloose/syntastic {{{
" http://qiita.com/ka2n/items/55a435c10a240ea5d434
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['eslint']
" http://d.hatena.ne.jp/oppara/20140515/p1
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
" let g:syntastic_vim_checkers = ['vint']
" https://github.com/scrooloose/syntastic/wiki/HTML:---tidy
let g:syntastic_html_tidy_exec = 'tidy5'
nnoremap <LEADER>st :call SyntasticToggleMode()<CR>
" }}}
" rking/ag.vim {{{
let g:ag_highlight = 1
" }}}
" MarcWeber/vim-addon-local-vimrc {{{
let g:local_vimrc = {'names':['.local-vimrc'],'hash_fun':'LVRHashOfFile'}
" }}}
" plasticboy/vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}
" soramugi/auto-ctags.vim {{{
let g:auto_ctags = 1
" }}}
" fatih/vim-go {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }}}
" }}}

filetype plugin indent on
syntax on

" vim: foldmethod=marker
" vim: foldcolumn=0
" vim: foldlevel=0
