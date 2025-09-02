NODE_OPTIONS=--disable-warning=ExperimentalWarning

source ~/.claude-api-key

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

source ~/paths.sh

if [[ $SAVED_PWD != $PWD  ]]
then
  cd $SAVED_PWD
fi

function setCWD(){
  echo export SAVED_PWD=$(pwd) > ~/paths.sh
}

alias vim="nvim"

alias wintermsettings="vim /mnt/c/Users/{REPLACE WITH USERNAME}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

rreplace() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: rreplace <search> <replace> [glob]"
    return 1
  fi

  local search="$1"
  local replace="$2"
  local glob="${3:-.}"   # default = current dir

  files=$(rg -l "$search" "$glob")

  if [[ -z "$files" ]]; then
    echo "No matches found."
    return 1
  fi

  echo "$files" | xargs sed -i "s/${search}/${replace}/g"
}

rrename() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: rrename <search> <replace> [glob]"
    return 1
  fi

  local search="$1"
  local replace="$2"
  local glob="${3:-*}"  # default = all files in current dir

  # Find files recursively whose names contain $search
  local files
  files=$(find . -type f -name "*$search*" -not -path "*/.git/*" -not -path "*/node_modules/*")

  if [[ -z "$files" ]]; then
    echo "No files found matching '$search'."
    return 1
  fi

  # Rename each file
  while IFS= read -r file; do
    local dir
    local base
    dir=$(dirname "$file")
    base=$(basename "$file")
    local newbase="${base//$search/$replace}"
    local newpath="$dir/$newbase"

    if [[ "$file" != "$newpath" ]]; then
      echo "Renaming: $file → $newpath"
      mv "$file" "$newpath"
    fi
  done <<< "$files"
}

