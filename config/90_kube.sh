##############
### CONFIG ###
##############

alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl delete"
alias kl="kubectl logs"

#######################
### AUTO COMPLETION ###
#######################

source <(kubectl completion zsh)

# /!\ Must be call AFTER setting aliases
compdef k=kubectl
