# Linux Desktop

## Tweak Tool

### Emacs key binding

Keyboard and Mouse => Key theme => Emacs

## Switch the different windows of the same application (US keyboard)

```markdown
Alt + `
```

## Open image

```markdown
$ feh foo.png
$ eog foo.png
```

See [this](http://unix.stackexchange.com/questions/35333/what-is-the-fastest-way-to-view-images-from-the-terminal).

## Dump gnome terminal profiles

```markdown
$ dconf dump /org/gnome/terminal/legacy/profiles:/
$ dconf dump /org/gnome/terminal/legacy/profiles:/:<Profile ID>/ > my.dconf
$ dconf load /org/gnome/terminal/legacy/profiles:/:<Profile ID>/ < my.dconf
```
