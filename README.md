# Dotfiles :wrench:

This project aims to provide dotfiles templates and common scripts for setup and configure various command.

## config

These config provide every config you need in your shell and are read each time a zsh shell is launched.

```sh
config/
├── oh-my-posh/
│  └── theme/
│     └── custom.json
├── zsh/
│  ├── antigen/
│  │  └── antigen.zsh
│  ├── born2root.txt
│  ├── config.sh
│  └── explicit_aliases.sh
├── 10_cargo.sh
├── 20_basic.sh
├── 30_compiler.sh
├── 40_docker.sh
├── 50_git.sh
├── 60_ssh.sh
├── 70_python.sh
└── 80_gpg.sh
```

## Dotfiles

The `dotfiles/` folder provides the following dotfiles templates :

```sh
dotfiles/
├── .gitconfig
├── .gitignore_global
└── .vscode/
   ├── extensions.json
   └── settings.json
```

> *There is no `.zshrc` template, as you only need to source [`config.sh`](./config.sh) (which is done by [setup](#setup)).*

## Setup

These scripts are intended to install common packages on proper os :

- [setup-osx.sh](./setup/setup-osx.sh)
- [setup-debian.sh](./setup/setup-debian.sh)
- [setup-windows.ps1](./setup/setup-powershell.ps1)

### Only for osx/debian

It can install severals profiles in addition to the core install by providing `-p <profile_name>` *(example: `./setup-osx.sh -p base`)*. The following additional profiles are available :

- [base](#base) *- base packages*
- [rust](#rust) *- rust developer oriented packages*

> *For more infos use `-h` flag with the script to print help.*

> *Packages can come from different sources such as homebrew, apt, npm, etc...*

> *Apt come with [WakeMeOps](https://docs.wakemeops.com/) repository.*

### Base

| Package                                                               | Description                                       | Type    | OSX installation  | Debian installation |
| --------------------------------------------------------------------- | ------------------------------------------------- | ------- | ----------------- | ------------------- |
| [bat](https://github.com/sharkdp/bat)                                 | cat command enhanced                              | cli     | homebrew          | apt                 |
| [bat-extras](https://github.com/eth-p/bat-extras)                     | bat combo with other commands                     | cli     | homebrew          | shell               |
| [chafa](https://hpjansson.org/chafa/)                                 | image viewer in terminal                          | cli     | homebrew          | apt                 |
| [docker](https://www.docker.com/)                                     | docker engine                                     | cli     | -                 | shell               |
| [exa](https://the.exa.website)                                        | ls command enhanced                               | cli     | homebrew          | apt                 |
| [exiftool](https://exiftool.org/)                                     | metadata writer and reader tool                   | cli     | homebrew          | apt                 |
| [ffmpeg](https://ffmpeg.org/)                                         | audio video manipulation tool                     | cli     | homebrew          | apt                 |
| [fzf](https://github.com/junegunn/fzf)                                | command-line fuzzy finder                         | cli     | homebrew          | apt                 |
| [gh](https://cli.github.com/)                                         | github cli                                        | cli     | homebrew          | apt                 |
| [git](https://git-scm.com)                                            | git cli                                           | cli     | homebrew          | apt                 |
| [glab](https://gitlab.com/gitlab-org/cli)                             | gitlab cli                                        | cli     | homebrew          | apt                 |
| [gnupg](https://gnupg.org/)                                           | encryption tool                                   | cli     | homebrew          | apt                 |
| [jq](https://stedolan.github.io/jq/)                                  | json processor tool                               | cli     | homebrew          | apt                 |
| [nmap](https://nmap.org/)                                             | port scanning utility                             | cli     | homebrew          | apt                 |
| [ripgrep](https://github.com/BurntSushi/ripgrep)                      | regex pattern search cli (usefull for bat-extras) | cli     | homebrew          | apt                 |
| [rsync](https://rsync.samba.org/)                                     | file transfer tool                                | cli     | homebrew          | apt                 |
| [tldr++](https://github.com/isacikgoz/tldr)                           | cheatsheet interactive cli                        | cli     | homebrew          | go                  |
| [tree](https://mama.indstate.edu/users/ice/tree/)                     | filesystem display as tree                        | cli     | homebrew          | apt                 |
| [wget](https://www.gnu.org/software/wget/)                            | internet file retriever                           | cli     | homebrew          | apt                 |
| [yq](https://github.com/mikefarah/yq)                                 | yaml processor tool                               | cli     | homebrew          | apt                 |
| [docker](https://www.docker.com/products/docker-desktop/)             | docker desktop                                    | desktop | homebrew *- cask* | -                   |
| [openvpn-connect](https://openvpn.net/client-connect-vpn-for-mac-os/) | vpn client                                        | desktop | homebrew *- cask* | -                   |
| [vscode](https://code.visualstudio.com/)                              | ide                                               | desktop | homebrew *- cask* | -                   |
| [rectangle](https://rectangleapp.com)                                 | window manager tool                               | desktop | homebrew *- cask* | -                   |

### Rust

| Package                     | Description          | Type | OSX installation | Debian installation |
| --------------------------- | -------------------- | ---- | ---------------- | ------------------- |
| [rustup](https://rustup.rs) | Rust tools installer | cli  | shell            | shell               |
