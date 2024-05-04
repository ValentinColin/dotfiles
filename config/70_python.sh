##############
### CONFIG ###
##############

### Alias
alias py=python3
alias pip=pip3
alias pipup="pip3 install --upgrade pip"

### Pyenv
if command -v pyenv &>/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

### Poetry
if command -v poetry &>/dev/null; then
    export PATH="/etc/poetry/bin:$PATH"
fi
