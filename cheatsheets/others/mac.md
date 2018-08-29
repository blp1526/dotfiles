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

## Update hosts

```
sudo vim /private/etc/hosts
sudo killall -HUP mDNSResponder
```
