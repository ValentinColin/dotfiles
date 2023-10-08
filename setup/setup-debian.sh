#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'

# Console step increment
i=1

# Get project directories
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Default
COPY_DOTFILES="false"
INSTALL_BASE="false"
INSTALL_RUST="false"

# Declare script helper
TEXT_HELPER="\nThis script aims to install a full setup for debian.
Following flags are available:

  -d    Copy dotfiles.

  -p    Install additional packages according to the given profile, available profiles are :
          -> 'base'
          -> 'rust'
        Default is no profile, this flag can be used with a CSV list (ex: -p "base,rust").

  -h    Print script help.\n\n"

print_help() {
  printf "$TEXT_HELPER"
}

# Parse options
while getopts hdp: flag; do
  case "${flag}" in
    d)
      COPY_DOTFILES="true";;
    p)
      [[ "$OPTARG" =~ "base" ]] && INSTALL_BASE="true"
      [[ "$OPTARG" =~ "rust" ]] && INSTALL_RUST="true";;
    h | *)
      print_help
      exit 0;;
  esac
done


# Apt upgrade
sudo apt -y update && sudo apt -y upgrade


# Install oh-my-posh
if [ -z "$POSH_SHELL_VERSION" ]; then
  printf "\nInstall oh-my-posh\n\n"

  brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

# Settings
printf "\nScript settings:
  -> install ${red}[base]${no_color} profile: ${red}$INSTALL_BASE${no_color}
  -> install ${red}[rust]${no_color} profile: ${red}$INSTALL_RUST${no_color}\n"


# Copy dotfiles
if [[ "$COPY_DOTFILES" = "true" ]]; then
  printf "\n${red}${i}.${no_color} Copy dotfiles\n\n"
  i=$(($i + 1))

  cp -v "$SCRIPT_PATH/dotfiles/.gitconfig" "$HOME/.gitconfig"
  cp -v "$SCRIPT_PATH/dotfiles/.gitignore_global" "$HOME/.gitignore_global"

  echo ". ~/git/dotfiles/config.sh" >> ~/.zshrc
fi

# Install zsh
if [ ! -x "$(command -v zsh)" ]; then
  printf "\n${red}${i}.${no_color} Install zsh\n\n"
  sudo apt install -y zsh
fi

# Make zsh the default shell
if [[ ! "$SHELL" =~ "zsh" ]]; then
  printf "\n${red}${i}.${no_color} Make zsh the default shell for $USER\n\n"
  sudo chsh -s $(which zsh) "$USER"
fi


# Install base profile
if [[ "$INSTALL_BASE" = "true" ]]; then
  i=$(($i + 1))
  printf "\n${red}${i}.${no_color} Install base profile\n\n"

  sh "$SCRIPT_PATH/profiles/debian/setup-base.sh"
fi

# Install rust profile
if [[ "$INSTALL_RUST" = "true" ]]; then
  i=$(($i + 1))
  printf "\n${red}${i}.${no_color} Install rust profile\n\n"

  sh "$SCRIPT_PATH/profiles/setup-rust.sh"
fi
