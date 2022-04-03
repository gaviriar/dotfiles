# .bash_profile file
# Shamelessly copied and inspired from:
# - Balaji S. Srinivasan (balajis@stanford.edu)
# - mathiasbynens
# - paulirish

# Factor out all repeated profile initialization into .bashrc
#  - All non-login shell parameters go there
#  - All declarations repeated for each screen session go there

# Load ~/.extra, ~/.path, ~/.bash_prompt, ~/.exports, ~/.aliases, ~/.functions, ~/.bashrc and ~/.vault
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,vault}; do
  [ -r "$file" ] && source "$file"
done
unset file;

# init z   https://github.com/rupa/z
. ~/my_cellar/z/z.sh
#! if Z is not working then maybe try: source ~/MyCellar/z/z.sh

## History
# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '

# keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL="ignoredups"       # no duplicate entries, but keep space-prefixed commands
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
type shopt &> /dev/null && shopt -s histappend  # append to history, don't overwrite it

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Save multi-line commands as one command
shopt -s cmdhist

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ^ the only downside with this is [up] on the readline will go over all history not just this bash session.

# Ad tab completion for many Bash commands. 
if [ -f /etc/bash_completion ]; then # If no bash-completion set by homebrew found
    source /etc/bash_completion;
elif  [ -x `which brew` ] && [ -f $(brew --prefix)/etc/bash_completion ]; then # Assuming HomeBrew and bash-completion package is installed too 
 . $(brew --prefix)/etc/bash_completion
fi

	
# Add auto-tab completion for SSH hostnames based on ~/.ssh/config
# More info on ssh configs: http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

##
## better `cd`'ing
##

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell;

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Set caps lock key as Ctrl on debian
# This temporarily remaps the CapsLock key to a Control key.
# The keyboard will return to the previous settings after a
# reboot. The Linux console and the X Window system each
# handles keypresses separately, so each must be remapped
# separately. First remap the X keyboard since this does not
# require root access.

# Remap the CapsLock key to a Control key for
# the X Window system.

# TODO: This should be moved to .config/autostart
# See https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html
# for more information
if type setxkbmap >/dev/null 2>&1; then
        setxkbmap -layout us -option ctrl:nocaps 2>/dev/null
fi

# http://www.noah.org/wiki/CapsLock_Remap_Howto