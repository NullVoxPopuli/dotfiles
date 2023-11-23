#!/bin/bash
#
# Requires https://github.com/dandavison/delta
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
# delta.diff-so-fancy
# https://github.com/dandavison/delta/blob/a3fd4bb710bfbf96cae92d083555236ca131a09d/src/features/diff_so_fancy.rs
# ( but with normal highlighting )
git config --global delta.file-style "omit"
git config --global delta.hunk-header-style "file bold line-number syntax"
git config --global delta.hunk-header-file-style "#bbbbbb"
git config --global delta.hunk-header-line-number-style "#0088aa"
git config --global delta.hunk-header-decoration-style "bold yellow ul ol"
# n/N for forward/back
git config --global delta.navigate "true"
git config --global delta.side-by-side "true"
git config --global delta.syntax-theme "TwoDark"

git config --global merge.conflictstyle "diff3"
git config --global diff.colorMoved "default"
git config --global init.defaultBranch "main"

git config --global user.email "199018+NullVoxPopuli@users.noreply.github.com"
git config --global user.name "NullVoxPopuli"

