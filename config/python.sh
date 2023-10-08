##############
### CONFIG ###
##############

### Alias
alias py=python3
alias pip=pip3
alias pipup="pip3 install --upgrade pip"

### Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### Poetry
export PATH="/etc/poetry/bin:$PATH"
