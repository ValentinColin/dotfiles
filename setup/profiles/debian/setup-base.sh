#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'


# Install utils packages
printf "\n\n${red}[base] =>${no_color} Install apt packages\n\n"
sudo apt install -y \
  bat \
  chafa \
  curl \
  exa \
  fzf \
  gnupg2 \
  jq \
  man \
  man-db \
  manpages-dev \
  nmap \
  ripgrep \
  rsync \
  tree \
  wget \
  yq


# Install tldr++
if [ ! -x "$(command -v tldr)" ]; then
  printf "\n\n${red}[base] =>${no_color} Install tldr++\n\n"
  curl -L -o /tmp/tldr.tar.gz $(curl -s "https://api.github.com/repos/isacikgoz/tldr/releases/latest" \
      | jq -r --arg a $(dpkg --print-architecture) '.assets[] | select(.name | match("tldr_.*_linux_" + $a + "\\.tar\\.gz")) | .browser_download_url') \
    && tar -C /tmp -xzf /tmp/tldr.tar.gz \
    && sudo mv /tmp/tldr /usr/local/bin
fi


# Create symlink for bat : https://github.com/sharkdp/bat#on-ubuntu-using-apt
if [ ! -L ~/.local/bin/bat ]; then
  printf "\n\n${red}[base] =>${no_color} Create symlink for bat\n\n"
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
fi


# Install bat-extras for additional bat commands
if [ ! -f /usr/local/bin/batman ]; then
  printf "\n\n${red}[base] =>${no_color} Install bat-extras\n\n"
  git clone -b "$(curl -s https://api.github.com/repos/eth-p/bat-extras/releases/latest | jq -r '.tag_name')" --depth 1 https://github.com/eth-p/bat-extras /tmp/bat-extras \
    && sudo /tmp/bat-extras/build.sh --install
fi


# Install docker and start/enable the daemon by default
if [ ! -x "$(command -v docker)" ]; then
  printf "\n\n${red}[base] =>${no_color} Install docker\n\n"
  sudo apt install -y lsb-release gnupg2 apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/debian.gpg	
  sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
	sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl start docker && sudo systemctl enable docker
fi

# Add group docker if missing
if [ ! -z $(grep -q -E "^docker:" /etc/group)]; then
  printf "\n\n${red}[base] =>${no_color} Add docker group\n\n"
  sudo groupadd docker
fi

# Add user in docker group is missing
if [ -z "$(groups $USER | grep 'docker')" ]; then
  printf "\n\n${red}[base] =>${no_color} Add user to docker group\n\n"
  sudo usermod -aG docker $USER
fi

# Generate gpg keys
printf "Do you want generate GPG key for signing commit/tag?
note: The key will be added to your global .gitconfig file\n"
read yn
if [[ "$yn" = "y" ]]; then
  printf "\n\n${red}[base] =>${no_color} Generate gpg keys\n\n"
  gpg --full-generate-key
  key_id=$(gpg --list-secret-keys --keyid-format LONG | grep sec | sed -nE 's/.*\/([[:alnum:]]+) .*/\1/p')
  git config --global user.signingkey "$key_id"
fi