#############################################################################
#                                                                           #
#                   ------- Useful Docker Aliases -------                   #
#                                                                           #
#     # Usage:                                                              #
#     d               : docker                                              #
#     dc              : docker compose                                      #
#     dcu             : docker compose up -d                                #
#     dcd             : docker compose down                                 #
#     swarm           : docker swarm                                        #
#     di <container>  : docker inspect <container>                          #
#     dim             : docker images                                       #
#     dcl             : docker container list                               #
#     dnl             : docker network list                                 #
#     dvl             : docker volume list                                  #
#     dl              : docker compose logs -f                              #
#     dps             : docker ps                                           #
#     dpsa            : docker ps -a                                        #
#     dsp             : docker system prune --all                           #
#     dx <container>  : execute a shell inside the RUNNUNG <container>      #
#     dnames          : names of all running containers                     #
#     dip             : IP addresses of all running containers              #
#     dsr <container> : stop then remove <container>                        #
#     drmc            : remove all exited containers                        #
#                                                                           #
#############################################################################

alias d=docker
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias swarm="docker swarm"
alias di="docker inspect"
alias dim="docker images"
alias dcl="docker container list"
alias dnl="docker network list"
alias dvl="docker volume list"
alias dl="docker compose logs -f"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.State}}\t{{.Status}}'"
alias dpsa="docker ps -a"
alias dsp="docker system prune --all"

function _trysh() {
    docker exec $1 which $2 >/dev/null &&
    echo "docker exec -it $1 $2" &&
    docker exec -it $1 $2
}

function dx() {
    container=`docker ps --format "{{.Names}}" | fzf`
    for shell in zsh bash sh; do
        _trysh $container $shell && break
    done
}

function dnames {
	for ID in `docker ps | awk '{print $1}' | grep -v 'CONTAINER'`
	do
    	docker inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
	done
}

function dip {
    echo "IP addresses of all named running containers"

    for DOC in `dnames-fn`
    do
        IP=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$DOC"`
        OUT+=$DOC'\t'$IP'\n'
    done
    echo -e $OUT | column -t
    unset OUT
}

function dsr {
	docker stop $1;docker rm $1
}

function drmc {
       docker rm $(docker ps --all -q -f status=exited)
}
