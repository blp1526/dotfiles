# Mac

## Finder

### Show invisible files at 'open / save' dialogue

`Command + Shift + g`

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

## iTerm2

* Profile => Text => Unicode
  * Uncheck "Treat ambiguous-width characters as double width (not recommended)" for tmux

## TextEdit

### Select by the limits of the columns size

<kbd>option</kbd> + <kbd>command</kbd> + drag

## Substitute for netstat/ss

```
lsof -nP -iTCP
```
