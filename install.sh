#!/usr/bin/env bash

# install NVM 
# NOTE: version number will change
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# Install rupa-z for easy directory jumping
if [ ! -d ~/projects/z ]; then
    git clone https://github.com/rupa/z.git ~/projects/z
    chmod +x ~/projects/z/z.sh 
fi

# Install virtualenv 
sudo pip install virtualenv
sudo pip install virtualenvwrapper
sudo pip install --upgrade pip

# Create directory where envs will live
if [ ! -d ~/.virtualenvs ]; then
    mkdir ~/.virtualenvs
fi

# If this is your first time dont forget to update your .bashrc
# personally I do this on the .extras dotfile on my machine as this is really more of a machine specific thing that I do not want to polute my .bashrc with
# It's up to you really
# courtesy: http://exponential.io/blog/2015/02/10/install-virtualenv-and-virtualenvwrapper-on-ubuntu/
printf '\n%s\n%s\n%s' '# virtualenv' 'export WORKON_HOME=~/.virtualenvs' 'source /usr/local/bin/virtualenvwrapper.sh'>> ~/.extra
