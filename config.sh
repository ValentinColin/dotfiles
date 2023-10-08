export DOTFILES_PATH=$(dirname "$0")
export OS=$(uname -s)

# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

### OH MY POSH
eval "$(oh-my-posh init zsh --config $DOTFILES_PATH/config/oh-my-posh/theme/custom.json)"

### Load every config
for config_script in $DOTFILES_PATH/config/*/config.sh; do
	source "$config_script"
done
for config_script in $DOTFILES_PATH/config/*.sh; do
	source "$config_script"
done

### remove export
unset DOTFILES_PATH
unset OS
