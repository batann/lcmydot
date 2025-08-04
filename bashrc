# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
feh --randomize --bg-fill /usr/share/backgrounds/*.png
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'
ttt=$(wmctrl -l|grep Terminal|tail -n1)

if [ "$UID" = 0 ]; then
    PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
else
    PS1="$PURPLE\u$nc@$CYAN\H$nc:$GREEN\w$nc\\n$GREEN\$$nc "
fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='cd $(list_directories|fzf) && lc-ls'
alias la='ls -A'
alias l='source /usr/bin/lc-menu-search'
alias ld='ls -d */'




# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add sbin directories to PATH.  This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h:$ttt \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Created by `pipx` on 2023-10-08 03:59:30
export PATH="$PATH:/home/batan/.local/bin"
source /home/batan/.bashrc.aliases
source /home/batan/.bashrc.functions
source /home/batan/.bashrc.navigation
source /home/batan/.bashrc.getfold
source /home/batan/.bashrc.dir
source /home/batan/.bashrc.clipboard
#source /home/batan/.bashrc.profile
source .bashrc.log
source .bashrc.test
source .bashrc.install
alias ssb='sudo bash'
ddd=$(date +%j)


#PROMPT_COMMAND='cols=$(tput u7 | cut -d";" -f2)'
#PROMPT_COMMAND='cols=$(tput u7 | cut -d";" -f2); echo "Cursor position: $cols";'

export TERMINAL="xfce4-terminal"
#PROMPT_COMMAND="cd_hook; history|tail -n1|cut -c8-500 >> /home/batan/.config/lists/commands.txt && pwd >> /home/batan/.config/lists/directory.list && COOLS"
PROMPT_COMMAND="cd_hook; history|tail -n1|cut -c8-500 >> /home/batan/.config/lists/commands.txt && pwd >> /home/batan/.config/lists/directory.list"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export FZF_DEFAULT_OPTS=" --ansi --layout=reverse --color=bg+:#2e3c64 --color=bg:#1f2335 --color=border:#29a4bd --color=fg:#c0caf5 --color=gutter:#1f2335 --color=header:#ff9e64 --color=hl+:#2ac3de --color=hl:#2ac3de --color=info:#545c7e --color=marker:#ff007c --color=pointer:#ff007c --color=prompt:#2ac3de --color=query:#c0caf5:regular --color=scrollbar:#29a4bd --color=separator:#ff9e64 --color=spinner:#ff007c --color=preview-label:#00857a,label:#f7b32b,query:#d9d9d9 --border='sharp' --preview-window=right,50%,'wrap' --pointer='─▶' --separator='─' --scrollbar='┃' "

#function _update_ps1() {
#    PS1=$(powerline-shell $?)
#}

#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

shopt -s checkwinsize



#{{{ >>>   cd_hook
cd_hook() {
    if [[ "$PWD" != "$LAST_PWD" ]]; then
        LAST_PWD="$PWD"
        lc-ls
    fi
}
#}}}

# Dynamic Cols
COLS="";AA="─";BB=""; for x in $(seq 1 $(tput cols)); do COLS="${COLS}${AA}" ;done
   #  COOLS() {
  #       BB=""
#         COLS=""
# for x in $(seq 1 $(tput cols)); do 
#	 COLS="${COLS}${AA}" 
#	 done
 #}

alias firefox-dev="/opt/firefox/firefox-bin"


PATH="/home/batan/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/batan/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/batan/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/batan/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/batan/perl5"; export PERL_MM_OPT;
. "$HOME/.cargo/env"
