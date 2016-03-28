# Vim

## Show character code

* normal mode `ga`
* command mode `:as`

see http://qiita.com/fieldville/items/89c3a5a2244b912592ea


## neobundle.vim

To develop a vim plugin at local path.

```vim
NeoBundle 'eighty.vim', {
\ 'base' : '~/.ghq/github.com/blp1526',
\ 'type' : 'nosync'
\ }
```

## syntastic

JSON syntax check

```markdown
npm install -g jsonlint
```

see http://note103.hateblo.jp/entry/2015/04/13/135645
