# CHEATSHEET

## Colored dmesg by less

```markdown
# see https://superuser.com/questions/940014/pipe-to-less-but-keep-the-highlighting
$ dmesg --human --color=always
# or $ dmesg --color=always | less -R -N
```
