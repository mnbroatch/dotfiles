if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

HISTFILESIZE=1000000
HISTSIZE=1000000

export PS1="\W \$"

export TERM=xterm

reacttemplate (){
  cp -a ~/Programming/templates/react-template/. .	

  new_thing_title=$1
  new_name=$2
  new_thing_lower=${new_thing_title,,}
  new_thing_upper=${new_thing_title^^}

  if [ "$new_thing_title" = "" ]; then
    $new_thing_title = "Thing"
    $new_thing_lower = "thing"
    $new_thing_upper = "THING"
  fi

  find * | rename -s Thing $new_thing_title
  find * | rename -s thing $new_thing_lower

  find * -not -path "*node_modules*" -type f -exec vim -c "set nomore" -c "argdo %s/THING/$new_thing_upper/ge | update" -c "argdo %s/Thing/$new_thing_title/ge | update" -c "argdo %s/thing/$new_thing_lower/ge | update" -c "argdo %S/react-template/$new_name/ge | update" -c "wq" {} +
}


ghmake(){
  git init
  repo_name=$1
  password=$2
  dir_name=`basename $(pwd)`

  if [ "$repo_name" = "" ]; then
    echo "Repo will be '$dir_name'"
    repo_name=$dir_name
  fi

  echo -n "Creating Github repository '$repo_name' ..."
  curl -u "mnbroatch:'$password'" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1

  echo -n "Pushing local code to remote ..."
  git remote add origin https://github.com/mnbroatch/$repo_name.git
  git add .
  git commit -m 'initial commit'

  git push -u origin master

  open https://github.com/mnbroatch/$repo_name.git
  echo " done! "
}


mkcd () {
  mkdir "$1"
  cd "$1"
}

alias w3m="w3m -B"
