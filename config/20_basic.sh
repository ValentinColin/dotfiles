##################
### Paramètres ###
##################

enable_eza=true
enable_eza_tree=true
enable_bat=true

if [[ "$(uname -s)" = "Darwin" ]]; then
	export TLDR_OS=osx
else
	export TLDR_OS=linux
fi

###############
### ALIASES ###
###############

alias root="sudo su"

alias pts="ls /dev/pts"
alias mypt="readlink /proc/self/fd/0"

alias password="head -c 32 /dev/urandom | sha256sum | base64 | head -c 32"

# Liste des groupes
alias glist="cat /etc/group | awk -F: '{print $ 1}' | sort"

# function to set the title of the terminal
set_title () {
    echo -en "\e]0;$*\a"
}

### Raccourci terminal
alias reload='exec $SHELL'
alias quit=exit

### Raccourci d'ouverture de dossier dans le finder
if [ "$OS" = "Linux" ]; then
	alias finder=nautilus
	alias rc="nautilus ~/git/.dotfiles/"
elif [ "$OS" = "Darwin" ]; then
	alias rc="open ~/git/.dotfiles/"
fi

#############################
### BASIC COMMAND ALIASES ###
#############################

### ls / eza
if command -v eza &>/dev/null; then
#if [ $enable_eza = "true" ]; then
	# Remplacement de ls par eza
	alias ls="eza --classify --icons --group-directories-first"
	alias la="eza --classify --icons --group-directories-first --all"
	alias ll="eza --classify --icons --group-directories-first --long --header --group --git"
	alias lla="eza --classify --icons --group-directories-first --all --long --header --group --git"

	# Remplacement de tree par celui de eza
	if [ "$enable_eza_tree" = "true" ]; then
		alias tree="eza --tree --classify"
	fi
else
	if [ "$OS" = "Linux" ]; then
		alias ls="ls -F --color=auto"
	elif [ "$OS" = "Darwin" ]; then
		alias ls="ls -F"
	fi
	alias la="ls -a -F"
	alias ll="ls -al -FG"
fi

### cat / bat
#if [ which bat &>/dev/null ]; then
if [ $enable_bat = "true" ]; then
	alias bat="bat --pager 'less -RF'"
fi

### cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Crée un dossier et rentre dedans avec cd
mcd () {
	mkdir -p -- "$1" && cd -P -- "$1" || exit
}

cdl () {
	cd "$1" && ls
}

### man
man () {
	# termcap terminfo
	# ks      smkx      make the keypad send commandsg
	# ke      rmkx      make the keypad send digits
	# vb      flash     emit visual bell
	# mb      blink     start blink
	# md      bold      start bold
	# me      sgr0      turn off bold, blink and underline
	# us      smul      start underline
	# ue      rmul      stop underline
	# so      smso      start standout (reverse video)
	# se      rmso      stop standout
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[45;93m' \
    LESS_TERMCAP_se=$'\e[0m' \
    command man "$@"
}
