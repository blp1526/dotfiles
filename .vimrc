" -- Shougo/NeoBundle.vim do
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
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'todesking/vint-syntastic'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'rking/ag.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'othree/html5.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'moll/vim-node'
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'vim-utils/vim-man'
NeoBundle 'simeji/winresizer'
NeoBundle 'othree/yajs.vim'
NeoBundle 'thinca/vim-quickrun'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" -- end

" -- kien/ctrlp.vim do
let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-n>'],
\ 'PrtSelectMove("k")':   ['<c-p>'],
\ 'PrtHistory(-1)':       ['<down>'],
\ 'PrtHistory(1)':        ['<up>'],
\ }
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:100,results:100'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
" -- end

" -- thinca/vim-quickrun do
let g:quickrun_config = { '*': { 'split': '' } }
let g:quickrun_config._ = { 'runner': 'vimproc' }
let g:quickrun_config['javascript.mocha'] = {
\ 'command': 'mocha',
\ 'cmdopt': '--reporter spec',
\ 'exec': ['%c %o %s']
\ }
augroup Mocha
  autocmd!
  autocmd BufNewFile,BufRead *_mocha.js set filetype=javascript.mocha
augroup END
" -- end

" -- kannokanno/previm do
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
" -- end

" -- myhere/vim-nodejs-complete do
" http://ellengummesson.com/blog/2015/05/03/nodejs-complete-for-vim/
autocmd FileType javascript set completeopt-=preview
" -- end

" -- easymotion/vim-easymotion do
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" -- end

" -- scrooloose/nerdtree do
let g:NERDTreeShowHidden = 1
" http://blog.livedoor.jp/kumonopanya/archives/51048805.html
nnoremap <silent><C-t> :NERDTreeToggle<CR>
vnoremap <silent><C-t><Esc> :NERDTreeToggle<CR>
onoremap <silent><C-t> :NERDTreeToggle<CR>
inoremap <silent><C-t><Esc> :NERDTreeToggle<CR>
cnoremap <silent><C-t><C-u> :NERDTreeToggle<CR>
" -- end

" -- scrooloose/syntastic do
" http://qiita.com/ka2n/items/55a435c10a240ea5d434
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vim_checkers = ['vint']
" https://github.com/scrooloose/syntastic/wiki/HTML:---tidy
let g:syntastic_html_tidy_exec = 'tidy5'
" -- end

" -- elzr/vim-json do
let g:vim_json_syntax_conceal = 0
" -- end

" -- Shougo/neocomplcache do
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default' : '',
\ 'vimshell' : $HOME.'/.vimshell_hist',
\ 'scheme' : $HOME.'/.gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
" -- end

" -- rking/ag.vim do
let g:ag_highlight=1
" -- end

" -- plasticboy/vim-markdown do
let g:vim_markdown_folding_disabled=1
" -- end

" -- like a macvim-kaoriya scripts
" c_CTRL-X
" Input current buffer's directory on command line.
" http://www.kaoriya.net/blog/2014/12/28/
cnoremap <C-X> <C-R>=<SID>GetBufferDirectory()<CR>
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
" -- end

" -- personal settings do
set hlsearch
" http://stackoverflow.com/questions/762515/vim-remap-key-to-toggle-line-numbering
set nowrap
noremap <silent><F1> :set wrap!<CR>
set number
noremap <silent><F2> :set number!<CR>
set ruler
set ignorecase
set nobackup
set autoindent
set wildmenu
set list
set listchars=tab:^\ ,trail:~
set laststatus=2
set pumheight=10
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=0
set splitbelow
" http://blog.pg1x.com/entry/2014/08/22/081215
set backspace=indent,eol,start
" http://844196.com/post/114133954334/vim
" set synmaxcol=300
" set lazyredraw
" set ttyfast

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
highlight Search  ctermfg=0 ctermbg=14
highlight Visual  ctermfg=1 ctermbg=15
" http://stackoverflow.com/questions/1294790/change-tilde-color-in-vim
highlight NonText ctermfg=0

highlight Folded     ctermfg=0 ctermbg=10
highlight FoldColumn ctermfg=0 ctermbg=10

" http://d.hatena.ne.jp/h1mesuke/20080327/p1
nnoremap <silent><ESC><ESC> :noh<CR>

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

" ctags
noremap <C-]> g<C-]>

" http://nvie.com/posts/how-i-boosted-my-vim/
" http://deris.hatenablog.jp/entry/2013/05/02/192415
let mapleader = ","
noremap \ ,

" about autocmd / augroup
" http://qiita.com/s_of_p/items/b61e4c3a0c7ee279848a

" http://secondlife.hatenablog.jp/entry/20050107/1105029582
autocmd FileType yaml nmap ,e :execute '!ruby -ryaml -e "begin;YAML::load(open('."'"."%"."'".","."'"."r"."'".').read);rescue ArgumentError=>e;puts e;end"'

" http://qiita.com/katton/items/bc9720826120f5f61fc1
augroup LastSpace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

augroup MultiByteSpace
  autocmd!
  autocmd BufNew,BufRead * call JISX0208SpaceHilight()
augroup END

augroup RailsSyntaxHighlight
  autocmd!
  autocmd BufNewFile,BufRead *.json.jbuilder set filetype=ruby
  autocmd BufNewFile,BufRead *.xlsx.axlsx    set filetype=ruby
  autocmd BufNewFile,BufRead *.cap           set filetype=ruby
augroup END

augroup HardTab
  autocmd!
  autocmd BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
  autocmd BufNewFile,BufRead *.c  set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
augroup END

if !exists('loading_matchit')
  runtime macros/matchit.vim
endif

" http://rbtnn.hateblo.jp/entry/2014/11/30/174749
syntax on
" ---- end
