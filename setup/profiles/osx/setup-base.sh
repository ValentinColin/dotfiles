#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'


# Script path
DOTFILES_DIR="${0:a:h}/../../dotfiles"


# Updating homebrew cache
printf "\n\n${red}[base] =>${no_color} Update homebrew\n\n"
brew update


# Install homebrew cli packages
printf "\n\n${red}[base] =>${no_color} Install homebrew packages (cli)\n\n"
brew install --formulae \
  bat \
  bat-extras \
  chafa \
  exa \
  exiftool \
  ffmpeg \
  fzf \
  gh \
  git \
  glab \
  gnupg \
  jq \
  nmap \
  ripgrep \
  rsync \
  isacikgoz/taps/tldr \
  tree \
  wget \
  yq \
  zsh

# Change the default shell
chsh -s $(where zsh)

# Install homebrew graphic app packages
printf "\n\n${red}[base] =>${no_color} Install homebrew packages (graphic)\n\n"
brew install --cask \
  docker \
  openvpn-connect \
  rectangle \
  visual-studio-code


# Generate gpg keys
read -p "Do you want generate GPG key for signing commit/tag? [yN]" yn
if [[ "$yn" = "y" ]]; then
  printf "\n\n${red}[base] =>${no_color} Generate gpg keys\n\n"
  gpg --full-generate-key
  key_id=$(gpg --list-secret-keys --keyid-format LONG | grep sec | sed -nE 's/.*\/([[:alnum:]]+) .*/\1/p')
  git config --global user.signingkey "$key_id"
fi
