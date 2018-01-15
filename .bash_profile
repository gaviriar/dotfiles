# .bash_profile file
# Shamelessly copied from:
# By Balaji S. Srinivasan (balajis@stanford.edu),
# mathiasbynens and paulirish
#
# Concepts:
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#
#    1) .bashrc is the *non-login* config for bash, run in scripts and after
#        first connection.
#
#    2) .bash_profile is the *login* config for bash, launched upon first
#        connection (in Ubuntu)
#
#    3) .bash_profile imports .bashrc in our script, but not vice versa.
#
#    4) .bashrc imports .bashrc_custom in our script, which can be used to
#        override variables specified here.
#
# When using GNU screen:
#
#    1) .bash_profile is loaded the first time you login, and should be used
#       only for paths and environmental settings

#    2) .bashrc is loaded in each subsequent screen, and should be used for
#       aliases and things like writing to .bash_eternal_history (see below)
#
# Do 'man bashrc' for the long version or see here:
# http://en.wikipedia.org/wiki/Bash#Startup_scripts
#
# When Bash starts, it executes the commands in a variety of different scripts.
#
#   1) When Bash is invoked as an interactive login shell, it first reads
#      and executes commands from the file /etc/profile, if that file
#      exists. After reading that file, it looks for ~/.bash_profile,
#      ~/.bash_login, and ~/.profile, in that order, and reads and executes
#      commands from the first one that exists and is readable.
#
#   2) When a login shell exits, Bash reads and executes commands from the
#      file ~/.bash_logout, if it exists.
#
#   3) When an interactive shell that is not a login shell is started
#      (e.g. a GNU screen session), Bash reads and executes commands from
#      ~/.bashrc, if that file exists. This may be inhibited by using the
#      --norc option. The --rcfile file option will force Bash to read and
#      execute commands from file instead of ~/.bashrc.

## -----------------------
## -- 1) Import .bashrc --
## -----------------------

# Factor out all repeated profile initialization into .bashrc
#  - All non-login shell parameters go there
#  - All declarations repeated for each screen session go there


# Load ~/.extra, ~/.path, ~/.bash_prompt, ~/.exports, ~/.aliases, ~/.functions and ~/.bashrc
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file;

# init z   https://github.com/rupa/z
. ~/projects/z/z.sh
#! if Z is not working then maybe try: source ~/MyCellar/z/z.sh


# Append to the Bash history file rather than overriding it
# See: http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
shopt -s histappend

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Ad tab completion for many Bash commands. 

if [ -f $(brew --prefix)/etc/bash_completion ]; then # Assuming HomeBrew and bash-completion package is installed too 
  . $(brew --prefix)/etc/bash_completion
elif [ -f /etc/bash_completion ]; then # If no bash-completion set by homebrew found 
	source /etc/bash_completion;
fi;

# Add auto-tab completion for SSH hostnames based on ~/.ssh/config
# More info on ssh configs: http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Set caps lock key as Ctrl on debian
# This temporarily remaps the CapsLock key to a Control key.
# The keyboard will return to the previous settings after a
# reboot. The Linux console and the X Window system each
# handles keypresses separately, so each must be remapped
# separately. First remap the X keyboard since this does not
# require root access.

# Remap the CapsLock key to a Control key for
# the X Window system.
if type setxkbmap >/dev/null 2>&1; then
        setxkbmap -layout us -option ctrl:nocaps 2>/dev/null
fi

# http://www.noah.org/wiki/CapsLock_Remap_Howto
