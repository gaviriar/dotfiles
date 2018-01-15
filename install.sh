#!/usr/bin/env bash

# install NVM 
# NOTE: version number will change
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# Install rupa-z for easy directory jumping
git clone https://github.com/rupa/z.git ~/projects/z
chmod +x ~/projects/z/z.sh 
