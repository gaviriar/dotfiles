# .bashrc file
# By Balaji S. Srinivasan (balajis@stanford.edu)
#
# Concepts:
#
#    1) .bashrc is the *non-login* config for bash, run in scripts and after
#        first connection.
#    2) .bash_profile is the *login* config for bash, launched upon first connection.
#    3) .bash_profile imports .bashrc, but not vice versa.
#    4) .bashrc imports .bashrc_custom, which can be used to override
#        variables specified here.
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



# # -----------------------------------
# # -- 1.1) Set up umask permissions --
# # -----------------------------------
# #  The following incantation allows easy group modification of files.
# #  See here: http://en.wikipedia.org/wiki/Umask
# #
# #     umask 002 allows only you to write (but the group to read) any new
# #     files that you create.
# #
# #     umask 022 allows both you and the group to write to any new files
# #     which you make.
# #
# #  In general we want umask 022 on the server and umask 002 on local
# #  machines.
# #
# #  The command 'id' gives the info we need to distinguish these cases.
# #
# #     $ id -gn  #gives group name
# #     $ id -un  #gives user name
# #     $ id -u   #gives user ID
# #
# #  So: if the group name is the same as the username OR the user id is not
# #  greater than 99 (i.e. not root or a privileged user), then we are on a
# #  local machine (check for yourself), so we set umask 002.
# #
# #  Conversely, if the default group name is *different* from the username
# #  AND the user id is greater than 99, we're on the server, and set umask
# #  022 for easy collaborative editing.
# if [ "`id -gn`" == "`id -un`" -a `id -u` -gt 99 ]; then
# 	umask 002
# else
# 	umask 022
# fi


# # ---------------------------------------------------------
# # -- 1.2) Set up bash prompt and ~/.bash_eternal_history --
# # ---------------------------------------------------------
# #  Set various bash parameters based on whether the shell is 'interactive'
# #  or not.  An interactive shell is one you type commands into, a
# #  non-interactive one is the bash environment used in scripts.
# if [ "$PS1" ]; then

#     if [ -x /usr/bin/tput ]; then
#       if [ "x`tput kbs`" != "x" ]; then # We can't do this with "dumb" terminal
#         stty erase `tput kbs`
#       elif [ -x /usr/bin/wc ]; then
#         if [ "`tput kbs|wc -c `" -gt 0 ]; then # We can't do this with "dumb" terminal
#           stty erase `tput kbs`
#         fi
#       fi
#     fi
#     case $TERM in
# 	xterm*)
# 		if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
# 			PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
# 		else
# 	    	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
# 		fi
# 		;;
# 	screen)
# 		if [ -e /etc/sysconfig/bash-prompt-screen ]; then
# 			PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
# 		else
# 		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
# 		fi
# 		;;
# 	*)
# 		[ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default

# 	    ;;
#     esac


# # Set the PS1 prompt (with colors).
# # Based on http://www-128.ibm.com/developerworks/linux/library/l-tip-prompt/
# # And http://networking.ringofsaturn.com/Unix/Bash-prompts.php .
# PS1="\[\e[36;1m\]\h:\[\e[32;1m\]\w$ \[\e[0m\]"

#     # Bash eternal history
#     # --------------------
#     # This snippet allows infinite recording of every command you've ever
#     # entered on the machine, without using a large HISTFILESIZE variable,
#     # and keeps track if you have multiple screens and ssh sessions into the
#     # same machine. It is adapted from:
#     # http://www.debian-administration.org/articles/543.
#     #
#     # The way it works is that after each command is executed and
#     # before a prompt is displayed, a line with the last command (and
#     # some metadata) is appended to ~/.bash_eternal_history.
#     #
#     # This file is a tab-delimited, timestamped file, with the following
#     # columns:
#     #
#     # 1) user
#     # 2) hostname
#     # 3) screen window (in case you are using GNU screen)
#     # 4) date/time
#     # 5) current working directory (to see where a command was executed)
#     # 6) the last command you executed
#     #
#     # The only minor bug: if you include a literal newline or tab (e.g. with
#     # awk -F"\t"), then that will be included verbatime. It is possible to
#     # define a bash function which escapes the string before writing it; if you
#     # have a fix for that which doesn't slow the command down, please submit
#     # a patch or pull request.
#     PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo -e $$\\t$USER\\t$HOSTNAME\\tscreen $WINDOW\\t`date +%D%t%T%t%Y%t%s`\\t$PWD"$(history 1)" >> ~/.bash_eternal_history'

#     # Turn on checkwinsize
#     shopt -s checkwinsize

#     #Prompt edited from default
#     [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u \w]\\$ "

#     if [ "x$SHLVL" != "x1" ]; then # We're not a login shell
#         for i in /etc/profile.d/*.sh; do
# 	    if [ -r "$i" ]; then
# 	        . $i
# 	    fi
# 	done
#     fi
# fi

# # Append to history
# # See: http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# shopt -s histappend

# # Case-insensitive globbing (used in pathname expansion)
# shopt -s nocaseglob

# # Append commands to the history every time a prompt is shown,
# # instead of after closing the session.
# # http://stefaanlippens.net/my_bashrc_aliases_profile_and_other_stuff
# PROMPT_COMMAND='history -a'



# Make prompt informative
# See:  http://www.ukuug.org/events/linux2003/papers/bash_tips/
#PS1="\[\033[0;34m\][\u@\h:\w]$\[\033[0m\]"

## ------------------------------
## -- 3) User-customized code  --
## ------------------------------


# #source z for fast directory searching
# source ~/code/z/z.sh

# ## Define any user-specific variables you want here.
# source ~/.bashrc_custom

# Load Bash profile
[ -n "$PS1" ] && source ~/.bash_profile


