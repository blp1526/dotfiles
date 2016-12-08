scriptencoding utf-8

" http://deris.hatenablog.jp/entry/2013/05/02/192415
let g:mapleader = ','
noremap \ ,

" plugin settings {{{
" Shougo/NeoBundle.vim {{{
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('$HOME/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'rking/ag.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'othree/html5.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'fatih/vim-go'
NeoBundle 'moll/vim-node'
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'vim-utils/vim-man'
NeoBundle 'simeji/winresizer'
NeoBundle 'othree/yajs.vim'
NeoBundle 'MarcWeber/vim-addon-local-vimrc'
NeoBundle 'tmux-plugins/vim-tmux'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'justmao945/vim-clang'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'blp1526/eighty.vim'
NeoBundle 'blp1526/storage.vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }}}
" Shougo/neocomplete.vim {{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}
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
" myhere/vim-nodejs-complete {{{
" http://ellengummesson.com/blog/2015/05/03/nodejs-complete-for-vim/
autocmd FileType javascript set completeopt-=preview
" }}}
" easymotion/vim-easymotion {{{
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
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
nnoremap <LEADER>s :call SyntasticToggleMode()<CR>
" }}}
" elzr/vim-json {{{
let g:vim_json_syntax_conceal = 0
" }}}
" rking/ag.vim {{{
let g:ag_highlight=1
" }}}
" MarcWeber/vim-addon-local-vimrc {{{
let g:local_vimrc = {'names':['.local-vimrc'],'hash_fun':'LVRHashOfFile'}
" }}}
" plasticboy/vim-markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}
" itchyny/lightline.vim {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': '|', 'right': '|' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
  if &filetype == 'help'
    return ''
  elseif &modified
    return '+'
  elseif &modifiable
    return ''
  else
    return ''
  endif
endfunction

function! LightLineReadonly()
  if &filetype == 'help'
    return ''
  elseif &readonly
    return '|'
  else
    return ''
  endif
endfunction

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
" }}}
" justmao945/vim-clang {{{
let g:clang_c_options   = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
" }}}
" soramugi/auto-ctags.vim {{{
let g:auto_ctags = 1
" }}}
" blp1526/eighty.vim {{{
let g:eighty_vim_threshold = 78
" }}}
" }}}

" personal settings {{{
" highlight {{{
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
highlight Search  ctermfg=0 ctermbg=14
highlight Visual  ctermfg=1 ctermbg=15
" http://stackoverflow.com/questions/1294790/change-tilde-color-in-vim
" FIXME: Change NonText ctermfg by background color
highlight NonText ctermfg=white

highlight Folded     ctermfg=0 ctermbg=10
highlight FoldColumn ctermfg=0 ctermbg=10

function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

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

" Explore
nnoremap <silent><LEADER>ex :Explore<CR>
" }}}
" augroup {{{
" http://qiita.com/katton/items/bc9720826120f5f61fc1
augroup LastSpace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
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
augroup END

augroup HardTab
  autocmd!
  autocmd BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
  autocmd BufNewFile,BufRead *.c  set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
  autocmd BufNewFile,BufRead *.h  set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
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
" matchit {{{
if !exists('loading_matchit')
  runtime macros/matchit.vim
endif
" }}}
" set option {{{
set nowrap
noremap <silent><F2> :set number!<CR>
set ruler
set ignorecase
set nobackup
set autoindent
set wildmenu
set wildmode=longest,full
set list
set listchars=tab:^\ ,trail:~
set laststatus=2
set pumheight=10
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=0
set splitbelow
" http://blog.pg1x.com/entry/2014/08/22/081215
set backspace=indent,eol,start
" http://rbtnn.hateblo.jp/entry/2014/11/30/174749
set foldmethod=indent
set foldcolumn=0
set foldlevel=99
set ttimeoutlen=10
" http://d.hatena.ne.jp/tacroe/20100612/1276294999
set shortmess+=I
set textwidth=0
" http://deris.hatenablog.jp/entry/2013/05/15/024932
set smartcase
" http://m.designbits.jp/14022515/
set nrformats=alpha
syntax on
" }}}
" }}}

" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
