#!/bin/bash
#
# Requires https://github.com/dandavison/delta
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate "true"
git config --global merge.conflictstyle "diff3"
git config --global diff.colorMoved "default"
git config --global init.defaultBranch "main"
