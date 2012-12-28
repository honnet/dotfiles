#!/bin/sh

#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# Search path for the cd command
#cdpath=(.. ~/src ~/zsh)

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

# UMASK
umask 077

# ENVIRONMENT

#export FULLNAME=
#export NAME=
#export EMAIL=

case $(uname) in
  (Linux)
    #export LS_COLORS="di=36;4:ln=35;4:ex=33:*.rpm=32:*.gz=32:*.tar=32:*.tgz=32"
  ;;
  (FreeBSD)
    export LSCOLORS="4x5x2x3x1x464301060203"
  ;;
  (SunOS)
    return 0
  ;;
  (Darwin)
    export PATH=/sw/bin/:/opt/local/bin:$PATH;
  ;;
  (*)
    echo "Please see .zshrc : Operating System is" `uname`
  ;;
esac


#if xterm export stuff to titlebar, and set $term to xterm-color for
#color ls

if [ "$TERM" = "xterm" ] && [ `uname` = 'FreeBSD' ]; then
    export TERM=xterm-color
fi

case $TERM in
    (xterm*)
    precmd () {print -Pn "\e]2;%n@%m%#  %~ %l  %w :: %T\a"}
    preexec () {print -Pn "\e]2;%n@%m%#  <$1>  %~ %l  %w :: %T\a"}
    ;;
esac

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }
function cdl() { cd "$1"; ls -l }
function getPWfor() { sudo sed -n "/$1/{n;p;}" ~/.ssh/pw.txt; }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Hosts to use for completion (see later zstyle)
hosts=($(hostname) $(cat /etc/hosts | cut -d \# -f 1 | cut -d \  -f 2))

# Some environment variables
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs
HISTFILE=~/.zsh_histfile
SAVEHIST=10000
HISTSIZE=10000
DIRSTACKSIZE=20

# Set/unset  shell options
#setopt   notify globdots correct pushdtohome cdablevars autolist
#setopt   correctall autocd recexact longlistjobs
setopt   notify globdots pushdtohome cdablevars autolist
setopt   autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash
setopt   NO_hup
setopt interactivecomments      # allow in line comments

# Key bindings
bindkey -e                      # emacs key bindings
#bindkey ' ' magic-space        # also do history expansion on space
bindkey '^I' complete-word      # complete on tab, leave expansion to _expand
bindkey  backward-delete-char # backspace working with Apple MacBook Pro

case $(uname -r) in
  (*ARCH*)
    bindkey "\e[1~" beginning-of-line
    bindkey "\e[4~" end-of-line
    bindkey "\e[5~" beginning-of-history
    bindkey "\e[6~" end-of-history
    bindkey "\e[3~" delete-char
    bindkey "\e[2~" quoted-insert
    bindkey "\e[5C" forward-word
    bindkey "\eOc" emacs-forward-word
    bindkey "\e[5D" backward-word
    bindkey "\eOd" emacs-backward-word
    bindkey "\e\e[C" forward-word
    bindkey "\e\e[D" backward-word
    # for rxvt
    bindkey "\e[8~" end-of-line
    bindkey "\e[7~" beginning-of-line
    # for non RH/Debian xterm, can't hurt for RH/Debian xterm
    bindkey "\eOH" beginning-of-line
    bindkey "\eOF" end-of-line
    # for freebsd console
    bindkey "\e[H" beginning-of-line
    bindkey "\e[F" end-of-line
  ;;
esac

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# launch interactive menu if there is more that 3 possibilities
zstyle ':completion:*' menu select=3

# for cd, don't try the user completions (~machin...)
zstyle ':completion:*:cd:*' tag-order local-directories # path-directories

# and anyway, just look for users in the following list
users=(sifteo)
zstyle ':completion:*' users $users

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# Text Editor
export EDITOR="vim"

# Lines configured by zsh-newuser-install
setopt autocd
unsetopt beep
# End of lines configured by zsh-newuser-install

#source alias.rc, prompt.rc etc...
for file in $HOME/.zsh/rc/*; do
  source $file
done

if [ "$HOST" = "davis" -a "$TTY" = "/dev/tty1" ]; then
  startx
fi


export PATH=$PATH:/opt/arm-cs-tools/bin
export PYTHONSTARTUP=~/.pystartup
export SDK_DIR="$HOME/thundercracker/sdk"
export PATH=$SDK_DIR/bin:$PATH

