# Ricardo's dotfiles

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Clone and set up

You can clone the repository wherever you want. (I like to keep it in `~/dotfiles/ricardogaviria/dotfiles` so that I can clone dotfiles from other inspirations and at the same level: ~/dotfiles) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/gaviriar/dotfiles.git
```

Symlink all relevant dotfiles to your home directory:
```bash
./symlink-setup.sh
```


# Courtesy of...
* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
* [Paul Irish](https://github.com/paulirish/dotfiles)
* [Balajis Coursera Startup Class](lecture/inde://github.com/startup-class/setup)

# Concepts:
http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
1) .bashrc is the *non-login* config for bash, run in scripts and after
    first connection.
2) .bash_profile is the *login* config for bash, launched upon first
    connection (in Ubuntu)
3) .bash_profile imports .bashrc in our script, but not vice versa.
4) .bashrc imports .bashrc_custom in our script, which can be used to
    override variables specified here.

When using GNU screen:
   1) .bash_profile is loaded the first time you login, and should be used
      only for paths and environmental settings

   2) .bashrc is loaded in each subsequent screen, and should be used for
      aliases and things like writing to .bash_eternal_history (see below)
Do 'man bashrc' for the long version or see here:
http://en.wikipedia.org/wiki/Bash#Startup_scripts
   
When Bash starts, it executes the commands in a variety of different scripts.
  1) When Bash is invoked as an interactive login shell, it first reads
     and executes commands from the file /etc/profile, if that file
     exists. After reading that file, it looks for ~/.bash_profile,
     ~/.bash_login, and ~/.profile, in that order, and reads and executes
     commands from the first one that exists and is readable.
  2) When a login shell exits, Bash reads and executes commands from the
     file ~/.bash_logout, if it exists.
  3) When an interactive shell that is not a login shell is started
     (e.g. a GNU screen session), Bash reads and executes commands from
     ~/.bashrc, if that file exists. This may be inhibited by using the
     --norc option. The --rcfile file option will force Bash to read and
     execute commands from file instead of ~/.bashrc.