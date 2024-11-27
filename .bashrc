alias gpullgame="git pull origin $1 --no-rebase"
alias cleangspot="git clean -fdx"
alias cum="git commit -m "

function cleandb(){ 
  if [ $# -eq 0 ] 
  then 
    echo 'Usage: cleandb <database-name> <route/to/dump?>'
    return
  fi 

  mysql -uroot -pz10mz10m -v -e "DROP DATABASE $1;"
  mysql -uroot -pz10mz10m -v -e "CREATE DATABASE $1;"
  if [ $# -eq 2 ]
  then
    mysql -uroot -pz10mz10m -v $1 < $2
  fi
}

function gspot(){
  [ $# -eq 0 ] && git diff HEAD && return
 
  (( $1 <= -1 )) || [[ $1 == "h" ]] && echo "Usage: gspot <count> (checks HEAD) || gdiff <branch> (checks 1 commit back) || gdiff <branch> <count>" && return

  if [ $# -eq 1 ]
  then
    if [ -n "$1" ] &&  [ "$1" -eq "$1" ]
    then 
      git diff HEAD~$1
    else 
        git diff $1~1 
    fi 
  else 
    git diff $1~$2
  fi
}
