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
git clone https://github.com/gaviriar/dotfiles.git
ln -sf dotfiles/.screenrc .
ln -sf dotfiles/.bash_profile .
ln -sf dotfiles/.bashrc .
ln -sf dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

