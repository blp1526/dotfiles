# Vim

## Session.vim

```markdown
:mksession
:qa
# vim -S Session.vim
vim
:source Session.vim
```

## Show character code

* normal mode `ga`
* command mode `:as`

see http://qiita.com/fieldville/items/89c3a5a2244b912592ea

## syntastic

### JSON syntax check

```markdown
npm install -g jsonlint
```

see http://note103.hateblo.jp/entry/2015/04/13/135645

### Perl on carton for @INC

```vim
let carton_path = system('carton exec perl -e "print join(q/,/,@INC)"')
let carton_pathes = split(carton_path, ",")
let lib_path = fnamemodify(finddir("lib", ";"), ":p")
let g:syntastic_perl_lib_path = carton_pathes + [lib_path]

let g:quickrun_config = {
\   'perl' : {
\       'cmdopt': '-Ilib',
\       'exec': 'carton exec perl %o %s',
\    },
\}
```

thanks to https://github.com/Kesin11/dotfiles/commit/9ff5831c856a24b071210919569015323e8aa839
