scriptencoding utf-8

" personal settings {{{
" variables {{{
let s:vimrc_kernel_path = substitute('/lib/modules/'.system('uname -r').'/build/include', "\\n", "", "")
let s:package_path = '~/.vim/pack/mypack/start/'
let s:vimrc_packages = [
      \ 'vim-jp/vimdoc-ja',
      \ 'kana/vim-tabpagecd',
      \ 'ctrlpvim/ctrlp.vim',
      \ 'tpope/vim-endwise',
      \ 'scrooloose/syntastic',
      \ 'plasticboy/vim-markdown',
      \ 'simeji/winresizer',
      \ 'editorconfig/editorconfig-vim',
      \ 'fatih/vim-go',
      \ 'PProvost/vim-ps1',
      \ 'scrooloose/nerdtree',
      \ 'easymotion/vim-easymotion',
      \ 'thinca/vim-qfreplace',
      \ 'rust-lang/rust.vim',
      \ 'embear/vim-localvimrc',
      \ 'rhysd/vim-clang-format',
      \ ]
" }}}
" functions {{{
function! InstallPackages()
  call system('mkdir -p ' . s:package_path)
  for l:author_name_repo_name in s:vimrc_packages
    let l:repo_name = split(l:author_name_repo_name, '/')[1]
    if !isdirectory(expand(s:package_path . l:repo_name))
      let l:git_clone     = 'git clone --depth 1'
      let l:clone_from    = 'https://github.com/' . l:author_name_repo_name . '.git'
      let l:clone_to      = s:package_path . l:repo_name
      let l:clone_command = join([l:git_clone, l:clone_from, l:clone_to], ' ')
      echo l:clone_command
      call system(l:clone_command)
      execute 'helptags ' . l:clone_to . '/doc'
      echo (join(['clone', l:author_name_repo_name, 'completed'], ' ')) . "\n"
    endif
  endfor
endfunction

function! UpdatePackages()
  let l:dirs = split(globpath(s:package_path, '*'), "\n")
  for l:dir in l:dirs
    let l:command = 'git -C ' . l:dir . ' pull --ff origin master'
    echo l:command
    call system(l:command)
  endfor
  echo "all git pull finished"
endfunction

function! JSONBeautifier()
  silent execute '%!jq .'
endfunction
command! JSONBeautifier call JSONBeautifier()

function! JSONMinifier()
  silent execute '%!jq -c .'
endfunction
command! JSONMinifier call JSONMinifier()

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

" https://www.kaoriya.net/blog/2014/12/28/
" see :help %:h (filename-modifiers)
function! s:GetBufferDirectory()
  let path = expand('%:p:h')
  let cwd = getcwd()
  let dir = '.'
  if match(path, escape(cwd, '\')) != 0
    let dir = path
  elseif strlen(path) > strlen(cwd)
    let dir = strpart(path, strlen(cwd) + 1)
  endif
  return dir . (exists('+shellslash') && !&shellslash ? '\' : '/')
endfunction
" }}}
" run once {{{
if has('vim_starting')
  call InstallPackages()
endif
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

" http://deris.hatenablog.jp/entry/2013/05/15/024932
" nnoremap / /\v

" tab
nnoremap <silent><C-c> :tabclose<CR>
nnoremap <silent><C-n> :tabnew<CR>
nnoremap <silent><C-h> :tabprevious<CR>
nnoremap <silent><C-l> :tabnext<CR>
nnoremap <silent><C-s> :tab split<CR>

" ctags
" noremap <C-]> g<C-]>

" selected text replacement
vnoremap <C-t> :s/\%V

" tab new gf
nnoremap gf <C-w>gf

" kaoriya keymap
cnoremap <C-X> <C-R>=<SID>GetBufferDirectory()<CR>

" spell suggestion
nnoremap <leader>s z=

" jump to the first line that contains the keyword under the cursor
" via :help [_CTRL-I
nnoremap <leader>k [<C-i>

" full path
nnoremap <C-g> 1<C-g>
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
  autocmd BufNewFile,BufRead *.log     setlocal cursorline
  autocmd BufNewFile,BufRead *.log*.gz setlocal cursorline
  autocmd Filetype           qf        setlocal cursorline
augroup END

augroup CorCPP
  autocmd!
  autocmd Filetype c   setlocal colorcolumn=80
  autocmd Filetype cpp setlocal colorcolumn=80
augroup END

augroup Spell
  autocmd!
  autocmd Filetype gitcommit setlocal spell
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
" options {{{
set clipboard=unnamedplus
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
" to search kernel functions by '[ CTRL-I', see :help include-search.
let &path = s:vimrc_kernel_path.",".&path

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
" scrooloose/syntastic {{{
let g:syntastic_c_include_dirs            = [s:vimrc_kernel_path]
let g:syntastic_enable_perl_checker       = 1
let g:syntastic_perl_checkers             = ['perl']
let g:syntastic_ruby_checkers             = ['rubocop']
let g:syntastic_eruby_ruby_quiet_messages = { 'regex': 'possibly useless use of a variable in void context' }
let g:syntastic_javascript_checkers       = ['eslint']
let g:syntastic_html_tidy_exec            = 'tidy5'
" }}}
" plasticboy/vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
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

let g:go_metalinter_autosave_enabled = ['vet', 'gofmt', 'golint']

let g:go_fmt_command = 'goimports'
let g:go_fmt_options = {
    \ 'gofmt': '-s',
    \ }

let g:go_fmt_autosave = 0
let g:go_metalinter_autosave = 0

augroup VimGo
  autocmd!
  autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>m <Plug>(go-metalinter)
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>e <Plug>(go-iferr)
augroup END
" }}}
" rust-lang/rust.vim {{{
let g:rustfmt_autosave = 1
" }}}
" embear/vim-localvimrc {{{
let g:localvimrc_ask = 0
" }}}
" scrooloose/nerdtree {{{
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 18
noremap <Leader>n :NERDTreeToggle<CR>
" }}}
" easymotion/vim-easymotion {{{
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" }}}
" }}}

filetype plugin indent on
syntax on

" vim: foldmethod=marker
" vim: foldcolumn=0
" vim: foldlevel=0
