#! /bin/bash

#rails start - To start the server in development environment
#rails start production (or whatever you need) - To start the server in production environment
#rails stop - To stop the server
#rails stop -9 - To stop the server sending -9 kill signal
#rails restart - To restart the server in development environment
#rails restart production - To restart the server in production environment
#rails whatever - Will send the call to original rails command

function rails() {
  if [ "$1" = "start" ]; then
    if [ "$2" = "" ]; then
    	RENV="development"
     	rails server -e "$RENV"
    else
    	RENV="$2"
     	rails server -d -e "$RENV"
    fi
    return 0
  elif [ "$1" = "stop" ]; then
    if [ -f tmp/pids/server.pid ]; then
      kill $2 $(cat tmp/pids/server.pid)
      return 0
    else
      echo "Não existe nenhum servidor do rails rodando."
      return 1
    fi
  elif [ "$1" = "restart" ]; then
    rails stop && rails start $2
  else
    command rails $@
  fi;
}