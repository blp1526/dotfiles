scriptencoding utf-8

" personal settings {{{
" functions {{{
function! InstallPackages()
  let l:package_path = '~/.vim/pack/mypack/start/'
  call system('mkdir -p ' . l:package_path)
  let l:author_name_repo_name_list = [
        \ 'kana/vim-tabpagecd',
        \ 'ctrlpvim/ctrlp.vim',
        \ 'tpope/vim-endwise',
        \ 'scrooloose/syntastic',
        \ 'rking/ag.vim',
        \ 'plasticboy/vim-markdown',
        \ 'simeji/winresizer',
        \ 'MarcWeber/vim-addon-local-vimrc',
        \ 'soramugi/auto-ctags.vim',
        \ 'editorconfig/editorconfig-vim',
        \ 'fatih/vim-go',
        \ 'PProvost/vim-ps1',
        \ 'Shougo/neocomplete.vim',
        \ 'scrooloose/nerdtree'
        \ ]
  for l:author_name_repo_name in l:author_name_repo_name_list
    let l:repo_name = split(l:author_name_repo_name, '/')[1]
    if !isdirectory(expand(l:package_path . l:repo_name))
      let l:git_clone     = 'git clone --depth 1'
      let l:clone_from    = 'https://github.com/' . l:author_name_repo_name . '.git'
      let l:clone_to      = l:package_path . l:repo_name
      let l:clone_command = join([l:git_clone, l:clone_from, l:clone_to], ' ')
      echo l:clone_command
      call system(l:clone_command)
      echo (join(['clone', l:author_name_repo_name, 'completed'], ' ')) . "\n"
    endif
  endfor
endfunction

function! Exhelp()
  let l:exhelp = [
        \ "=== :Explore easy doc ===",
        \ "netrw-i => CHANGE LISTING STYLE (THIN LOG WIDE TREE)",
        \ "netrw-t => BROWSING WITH A NEW TAB",
        \ "netrw-% => OPEN A NEW FILE IN NETRW'S CURRENT DIRECTORY",
        \ "netrw-d => MAKING A NEW DIRECTORY",
        \ "netrw-R => RENAMING FILES OR DIRECTORIES",
        \ "netrw-D => DELETING FILES OR DIRECTORIES"
        \ ]
  echo join(l:exhelp, "\n")
endfunction
command! Exhelp call Exhelp()

function! JSONFormatter()
  silent execute '%!python -m json.tool'
endfunction
command! JSONFormatter call JSONFormatter()

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
" run once {{{
if has('vim_starting')
  call InstallPackages()
endif
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
set tags+=.git/tags
set path+=$KERNEL_PATH

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
let g:ctrlp_match_window  = 'bottom,order:btt,min:1,max:100,results:100'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|vendor|local|tmp|coverage)|(\.(swp|ico|git|svn|ccache|cache))$'
let g:ctrlp_show_hidden   = 1
let g:ctrlp_cmd = 'CtrlPCurWD'
" }}}
" scrooloose/syntastic {{{
let g:syntastic_c_include_dirs      = [$KERNEL_PATH]
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers       = ['perl']
let g:syntastic_ruby_checkers       = ['rubocop']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_tidy_exec      = 'tidy5'
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
let g:auto_ctags_directory_list = ['.git']
" }}}
" fatih/vim-go {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = 'goimports'
" }}}
" scrooloose/nerdtree {{{
let g:NERDTreeShowHidden = 1
" }}}
" Shougo/neocomplete.vim {{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}
" }}}

filetype plugin indent on
syntax on

" vim: foldmethod=marker
" vim: foldcolumn=0
" vim: foldlevel=0
