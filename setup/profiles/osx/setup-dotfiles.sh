#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'


# Script path
DOTFILES_DIR="${0:a:h}/../../dotfiles"


# .zshrc
printf "\n\n${red}[dotefiles] =>${no_color} setup .zshrc\n\n"


# .gitconfig
printf "\n\n${red}[dotefiles] =>${no_color} setup .gitconfig\n\n"
cp $DOTFILES_DIR/.gitconfig ~/.gitconfig
# TODO setup gpg signing key
#git config --global user.signingkey "..."


# .gitignore_global
printf "\n\n${red}[dotefiles] =>${no_color} setup .gitignore_global\n\n"
cp $DOTFILES_DIR/.gitignore_global ~/.gitignore_global
