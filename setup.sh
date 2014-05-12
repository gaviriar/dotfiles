# #!/bin/bash
# git pull and install dotfiles as well
cd $HOME
if [-d dotfiles.old/ ]; then
    rm -rf dotfiles.old
fi
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi

cd "$(dirname "$0")"
git pull
function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "setup.sh" --exclude "README.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
source ~/.bash_profile
