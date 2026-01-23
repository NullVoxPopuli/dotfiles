## Top 10 Committers

```bash
git log --format='%aN <%aE>' | \
    sort | \
    uniq --count | \
    sort --numeric-sort --reverse | \
    head --lines=10
```


## Top 10 Committers by lines 

### added in the last year

```bash
git log --since="1 year ago" --numstat --format="%aN" |
awk '
  NF==1 { author=$0 }
  NF==3 { added[author] += $1 }
  END {
    for (a in added) print added[a], a
  }
' | sort -nr | head -10
```

### removed in the last year

```bash
git log --since="1 year ago" --numstat --format="%aN" |
awk '
  NF==1 { author=$0 }
  NF==3 { removed[author] += $2 }
  END {
    for (a in removed) print removed[a], a
  }
' | sort -nr | head -10
```

### total changed lines 

```bash
git log --since="1 year ago" --numstat --format="%aN" |
awk '
  NF==1 { author=$0 }
  NF==3 { changed[author] += $1 + $2 }
  END {
    for (a in changed) print changed[a], a
  }
' | sort -nr | head -10
```
