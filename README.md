# Ricardo's dotfiles

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/dotfiles/ricardogaviria/dotfiles` so that I can clone dotfiles from other inspirations and at the same level: ~/dotfiles) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/mathiasbynens/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

# Install debian packages

```bash
./apt.sh
```

# Install additional libraries

```bash
sh ./install.sh
```
# Courtesy of...
* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
* [Paul Irish](https://github.com/paulirish/dotfiles)
* [Balajis Coursera Startup Class](lecture/inde://github.com/startup-class/setup)
