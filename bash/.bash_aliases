alias ll='ls -lh'
alias la='ls -lha'
alias ..='cd ..'
alias ...='cd ../..'

alias ns='netstat -plntu'

function exe() { docker exec -it $1 /bin/bash; }
alias up='docker-compose up --build'
alias down='docker-compose down'
