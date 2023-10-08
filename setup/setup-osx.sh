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
TEXT_HELPER="\nThis script aims to install a full setup for osx.
Following flags are available:

  -d    Copy dotfiles (.gitconfig, .gitignore_global, vscode settings) and update .zshrc to source config.

  -p    Install additional packages according to the given profile, available profiles are :
          -> 'base'
          -> 'rust'
        Default is no additional profile, this flag can be used multiple times.

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


# utils
install_clt() {
  printf "\n\n${red}Optional.${no_color} Installs Command Line Tools for Xcode from softwareupdate...\n\n"
  # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
  softwareupdate -i "$PROD" --verbose;
  printf "\Command Line Tools version installed :\n$PROD\n\n"
}

install_homebrew() {
  printf "\n\n${red}Optional.${no_color} Installs homebrew...\n\n"
  export NONINTERACTIVE=1 
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  printf "\nhomebrew version installed :\n$(homebrew --version)\n\n"
}

if [ -z "$(xcode-select -p)" ]; then
  while true; do
  printf "\nYou need Command Line Tools to run this script. Do you wish to install Command Line Tools?\n"
    read yn
    case $yn in
      [Yy]*)
        install_clt
		break;;
      [Nn]*)
        exit;;
      *)
        echo "\nPlease answer yes or no.\n";;
    esac
  done
fi

if [ -z "$(brew --version 2>/dev/null)" ]; then
  while true; do
  	printf "\nYou need homebrew to run this script. Do you wish to install homebrew?\n"
    read yn
    case $yn in
      [Yy]*)
        install_homebrew
		break;;
      [Nn]*)
        exit;;
      *)
        printf "\nPlease answer y or n.\n";;
    esac
  done
fi


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


# Install base profile
if [[ "$INSTALL_BASE" = "true" ]]; then
  printf "\n${red}${i}.${no_color} Install base profile\n"
  printf "⚠️  This can take a lot of time!\n"
  i=$(($i + 1))

  sh "$SCRIPT_PATH/profiles/osx/setup-base.sh"
fi


# Install rust profile
if [[ "$INSTALL_RUST" = "true" ]]; then
  printf "\n${red}${i}.${no_color} Install rust profile\n\n"
  i=$(($i + 1))

  sh "$SCRIPT_PATH/profiles/setup-rust.sh"
fi
