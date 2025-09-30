
Windows:
```

Terminal:
winget search Microsoft.PowerShell
winget install --id Microsoft.PowerShell --source winget

Powershell:
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" -Name "Scancode Map" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x01,0x00,0x3a,0x00,0x3a,0x00,0x01,0x00,0x00,0x00,0x00,0x00)) -Force
wsl --install

right click title bar -> settings
	- default profile: Ubuntu

Restart terminal

sudo apt update
sudo apt install build-essential
sudo apt install ripgrep

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

Restart terminal

nvm install --lts
npm install -g typescript-language-server typescript

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

get ssh key, place in ~/.ssh
get claude-api-key, place in ~
chmod 600 ~/.ssh/id_ed123456

mkdir ~/.Programming
cd ~/.Programming
git clone git@github.com:mnbroatch/dotfiles.git
cp -r ~/Programming/dotfiles/. ~
rm -rf ~/.git ~/README ~/win
git config --global user.email "mnbroatch@gmail.com"
git config --global user.name "Matthew Broatch"
git config --global core.excludesFile ~/.gitignore *TODO: ADD TO DOTFILES REPO*

vim
:Lazy update

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts
```

also includes a very hacky powershell script for getting my workspace set up how I likes it
