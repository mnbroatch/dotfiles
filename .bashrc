set -o vi 

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

bind "TAB:menu-complete"

HISTFILESIZE=1000000
HISTSIZE=1000000

export PS1="\$PWD \$ "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias wintermsettings="vim /mnt/c/Users/Flanders/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

alias meg="cd ~/Programming/megagame"

source ~/paths.sh

if [[ $SAVED_PWD != $PWD  ]]
then
  cd $SAVED_PWD
fi

function setCWD(){
  echo export SAVED_PWD=$(pwd) > ~/paths.sh
}

