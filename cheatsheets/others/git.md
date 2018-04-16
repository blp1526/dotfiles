# Git

## Use subdirectory as a new repository

```markdown
# http://qiita.com/uasi/items/77d41698630fef012f82
git clone ~/repo1 ~/repo2
cd ~/repo2
git filter-branch --subdirectory-filter subdir HEAD
```

## Add git subcommands

* Run `ls -l $(git --exec-path)`, then get git subcommand file name format.
  * Read `https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables`.
* Add `git-xxx` file name format executable file to your $PATH.
  * Read `https://github.com/tj/git-extras`.
