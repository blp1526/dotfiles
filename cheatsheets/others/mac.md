# Mac

## Finder

### Show invisible files at 'open / save' dialogue

`Command + Shift + g`

see [this](http://inforati.jp/apple/mac-tips-techniques/system-hints/how-to-use-move-to-folder-command-in-a-open-or-save-dialog-in-macos.html).

### Show no icons on the desktop

* Finder => Preferences
  * Uncheck all checkboxes at "Show these items on the desktop:"

## Samba

```markdown
mount_smbfs //foo.com/documents mnt/documents
```

## ftps

```markdown
brew install lftp
lftp username@example.com
set ftp:passive-mode on
set ftp:ssl-protect-data true
put example.iso
```

see [this](http://qiita.com/mazgi/items/f25bb6baa2cc5bbddc9a).

## iTerm2

* Profile => Text => Unicode
  * Uncheck "Treat ambiguous-width characters as double width (not recommended)" for tmux

## TextEdit

### Select by the limits of the columns size

<kbd>option</kbd> + <kbd>command</kbd> + drag

see [this](http://qiita.com/mogulla3/items/ca5bfa585ef19ed1eb9b).
