#!/bin/bash
# configure git
# https://git-scm.com/docs/git-config

echo ""
echo "**Don't forget to manually set user.name and user.email!**"
echo "git config --global user.name \"John Doe\""
echo "git config --global user.email johndoe@example.com"; echo

#set -x

# convert git:// to https:// since git:// ports are often blocked
git config --global url.https://github.com/.insteadOf git://github.com/

# alias co, br, ci, dt
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.dt 'difftool -y'

# 'git ls' shows git log but pretty=short colors
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h %Creset%s %Cblue[%cn]"'

# 'git ll' shows last commit's file changes or 'git ll <commit_hash>' shows that commit's changes
git config --global alias.ll 'show --pretty=format:"%n%C(yellow)%h %Creset%s %Cblue[%cn]%n" --name-status -r'

# set difftool
git config --global diff.tool gvimdiff
git config --global --add difftool.prompt false

# editor when making commits
git config --global core.editor vi

# create global .gitignore file & add to config
echo "*.swp" > ~/.gitignore_global
echo ".*.swp" >> ~/.gitignore_global
echo ".DS_Store" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# add global commit template to config
# https://gist.github.com/adeekshith/cd4c95a064977cdc6c50
git config --global commit.template ~/.git_commit_template

# prints out config when done
git config --list
