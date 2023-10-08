#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'


# Install rustup
printf "\n\n${red}[rust] =>${no_color} Install rustup\n\n"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
