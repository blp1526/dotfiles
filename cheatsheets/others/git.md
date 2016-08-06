# Git

## Use subdirectory as a new repository

```markdown
# http://qiita.com/uasi/items/77d41698630fef012f82
git clone ~/repo1 ~/repo2
cd ~/repo2
git filter-branch --subdirectory-filter subdir HEAD
```
