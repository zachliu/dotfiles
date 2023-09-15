#!/bin/zsh
# shellcheck shell=sh disable=all
# If we are using gnome-terminal, hide the headerbar {{{

# if [ "$TERM" = "xterm-256color" ]; then
#   old_wid=$(xdotool getactivewindow)
#   wname=$(xdotool getwindowname $old_wid)
#   if [ "$wname" != "Terminal" ]; then
#     xdotool windowminimize $old_wid
#   fi
#   wid=$(xdotool getactivewindow)
#   wmctrl -ir $wid -b add,maximized_vert,maximized_horz
#   xprop \
#     -id $wid \
#     -f _MOTIF_WM_HINTS 32c \
#     -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"
# fi

# }}}
# Powerlevel10k: Configure instant prompt {{{
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# }}}
# Profiler Header {{{

 # zmodload zsh/zprof

 # zmodload zsh/datetime
 # setopt PROMPT_SUBST
 # PS4='+$EPOCHREALTIME %N:%i> '

 # logfile=$(mktemp zsh_profile.XXXXXXXX)
 # echo "Logging to $logfile"
 # exec 3>&2 2>$logfile

 # setopt XTRACE

# }}}
# Functions {{{

path_ladd() {
  # Takes 1 argument and adds it to the beginning of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

path_radd() {
  # Takes 1 argument and adds it to the end of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

# }}}
# Exported variable: LS_COLORS {{{

# Colors when using the LS command
# NOTE:
# Color codes:
#   0   Default Colour
#   1   Bold
#   4   Underlined
#   5   Flashing Text
#   7   Reverse Field
#   31  Red
#   32  Green
#   33  Orange
#   34  Blue
#   35  Purple
#   36  Cyan
#   37  Grey
#   40  Black Background
#   41  Red Background
#   42  Green Background
#   43  Orange Background
#   44  Blue Background
#   45  Purple Background
#   46  Cyan Background
#   47  Grey Background
#   90  Dark Grey
#   91  Light Red
#   92  Light Green
#   93  Yellow
#   94  Light Blue
#   95  Light Purple
#   96  Turquoise
#   100 Dark Grey Background
#   101 Light Red Background
#   102 Light Green Background
#   103 Yellow Background
#   104 Light Blue Background
#   105 Light Purple Background
#   106 Turquoise Background
# Parameters
#   di 	Directory
LS_COLORS="di=1;34:"
#   fi 	File
LS_COLORS+="fi=0:"
#   ln 	Symbolic Link
LS_COLORS+="ln=1;36:"
#   pi 	Fifo file
LS_COLORS+="pi=5:"
#   so 	Socket file
LS_COLORS+="so=5:"
#   bd 	Block (buffered) special file
LS_COLORS+="bd=5:"
#   cd 	Character (unbuffered) special file
LS_COLORS+="cd=5:"
#   or 	Symbolic Link pointing to a non-existent file (orphan)
LS_COLORS+="or=31:"
#   mi 	Non-existent file pointed to by a symbolic link (visible with ls -l)
LS_COLORS+="mi=0:"
#   ex 	File which is executable (ie. has 'x' set in permissions).
# LS_COLORS+="ex=1;92:"
# additional file types as-defined by their extension
LS_COLORS+="*.rpm=90"

# Finally, export LS_COLORS
export LS_COLORS

# }}}
# Exported variables: General {{{

# React
export REACT_EDITOR='less'

# colored GCC warnings and errors
# colored GCC warnings and errors
GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01"
GCC_COLORS="$GCC_COLORS;32:locus=01:quote=01"
export GCC_COLORS

# Configure less (de-initialization clears the screen)
# Gives nicely-colored man pages
LESS="--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS"
LESS="$LESS --HILITE-UNREAD --tabs=4 --quit-if-one-screen"
export LESS
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export PAGER=less

export YELLOW=`echo -e '\033[1;33m'`
export LIGHT_CYAN=`echo -e '\033[1;36m'`
export GREEN=`echo -e '\033[0;32m'`
export NOCOLOR=`echo -e '\033[0m'`

# export PAGER="sed \"s/^\(([0-9]\+ [rows]\+)\)/$GREEN\1$NOCOLOR/;s/^\(-\[\ RECORD\ [0-9]\+\ \][-+]\+\)/$GREEN\1$NOCOLOR/;s/|/$GREEN|$NOCOLOR/g;s/^\([-+]\+\)/$GREEN\1$NOCOLOR/\" 2>/dev/null | less"
# export PAGER="sed \"s/\([[:space:]]\+[0-9.\-]\+\)$/${LIGHT_CYAN}\1$NOCOLOR/;s/\([[:space:]]\+[0-9.\-]\+[[:space:]]\)/${LIGHT_CYAN}\1$NOCOLOR/g;s/|/$YELLOW|$NOCOLOR/g;s/^\([-+]\+\)/$YELLOW\1$NOCOLOR/\" 2>/dev/null | less"
# export PAGER='vim -R -u ~/.vimrc -'
# export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --clear-screen'

# Configure Man Pager
export MANWIDTH=79
export MANPAGER=less

# Git (already set in .gitconfig)
# export GIT_PAGER=less

# Configure man pager (legacy)
#

# tmuxinator
export EDITOR=/usr/bin/nvim
export SHELL=/usr/bin/zsh

# environment variable controlling difference between HI-DPI / Non HI_DPI
# turn off because it messes up my pdf tooling
export GDK_SCALE=0

# Neovim does not change cursor shape if I set the below
# It seems to rely on underlying terminal being xterm-256
# and tmux being screen-256color.
# Weird bug, I'm making this note so I'm aware of it going forward
# export TERM="screen-256color"

# History: How many lines of history to keep in memory
export HISTSIZE=40000

# History: ignore leading space, where to save history to disk
export HISTCONTROL=ignorespace
export HISTFILE=~/histories/.zsh_history

# History: Number of history entries to save to disk
export SAVEHIST=30000

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# pipenv
export PIPENV_VENV_IN_PROJECT='doit'

# Default browser for some programs (eg, urlview)
export BROWSER='/usr/bin/google-chrome'

# Enable editor to scale with monitor's DPI
export WINIT_HIDPI_FACTOR=1.0

# Bat
export BAT_PAGER=less

# }}}
# Path appends + Misc env setup {{{

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

HOME_LOCAL_BIN="$HOME/.local/bin"
if [ ! -d "$HOME_LOCAL_BIN" ]; then
  mkdir -p "$HOME_LOCAL_BIN"
fi
path_ladd "$HOME_LOCAL_BIN"

RUST_CARGO="$HOME/.cargo/bin"
if [ -d "$RUST_CARGO" ]; then
  path_ladd "$RUST_CARGO"
fi

HOME_BIN_HIDDEN="$HOME/.bin"
if [ ! -d "$HOME_BIN_HIDDEN" ]; then
  mkdir "$HOME_BIN_HIDDEN"
fi
path_ladd "$HOME_BIN_HIDDEN"

POETRY_LOC="$HOME/.poetry/bin"
if [ -d "$POETRY_LOC" ]; then
  path_ladd "$POETRY_LOC"
  source $HOME/.poetry/env
fi

SERVERLESS_BIN="$HOME/.serverless/bin"
if [ -d "$SERVERLESS_BIN" ]; then
  path_ladd "$SERVERLESS_BIN"
fi

# EXPORT THE FINAL, MODIFIED PATH
export PATH

# Remove duplicates in $PATH
# https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
typeset -aU path

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/zach/google-cloud-sdk/path.zsh.inc' ]; then
  . '/home/zach/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/zach/google-cloud-sdk/completion.zsh.inc' ]; then
  . '/home/zach/google-cloud-sdk/completion.zsh.inc';
fi

# }}}
# Import from other Bash Files {{{

include () {
  [[ -f "$1" ]] && source "$1"
}

include ~/.bash/sensitive

# }}}
# Z-shell: plugins {{{

if [ -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]; then
  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

  zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
  zinit light zdharma/fast-syntax-highlighting

  # zinit ice wait lucid  # this generates a weird behavior
  zinit light paulirish/git-open

  zinit ice wait lucid
  zinit light felixr/docker-zsh-completion

  # zinit light zachliu/spaceship-prompt
  # zinit light /home/zach/Documents/spaceship-prompt/
  # zinit light spaceship-prompt/spaceship-prompt

  zinit ice depth=1; zinit light romkatv/powerlevel10k

  zinit snippet OMZP::history

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# }}}
# Z-shell: options {{{

#######################################################################
# Set options
#######################################################################

# enable functions to operate in PS1
setopt PROMPT_SUBST

# list available directories automatically
setopt AUTO_LIST
setopt LIST_AMBIGUOUS
setopt LIST_BEEP

# completions
setopt COMPLETE_ALIASES

# automatically CD without typing cd
setopt AUTOCD

# Dealing with history
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

#######################################################################
# Unset options
#######################################################################

# do not automatically complete
unsetopt MENU_COMPLETE

# do not automatically remove the slash
unsetopt AUTO_REMOVE_SLASH

#######################################################################
# Expected parameters
#######################################################################
export PERIOD=1
export LISTMAX=0

# }}}
# Z-shell: misc autoloads {{{

# Enables zshell calculator: type with zcalc
autoload -Uz zcalc

# }}}
# Z-shell: hook functions {{{

# NOTE: precmd is defined within the prompt section

# Executed whenever the current working directory is changed
function chpwd() {
  # ls --color=auto

  # Magically find Python's virtual environment based on name
  # this works under powerlevel10k
  va &> /dev/null

  # activate direnv if there is a .envrc
  # activate_direnv
}

# Executed every $PERIOD seconds, just before a prompt.
# NOTE: if multiple functions are defined using the array periodic_functions,
# only  one  period  is applied to the complete set of functions, and the
# scheduled time is not reset if the list of functions is altered.
# Hence the set of functions is always called together.
function periodic() {
  # Magically find Python's virtual environment based on name
  # NOTE: neither of these works under powerlevel10k
  # va
  # va &> /dev/null
}

# Executed just after a command has been read and is about to be executed
#   arg1: the string that the user typed OR an empty string
#   arg2: a single-line, size-limited version of the command
#     (with things like function bodies elided)
#   arg3: full text that is being executed
function preexec() {
  # local user_string="$1"
  # local cmd_single_line="$2"
  # local cmd_full="$3"
}


# Executed when a history line is read interactively, but before it is executed
#   arg1: the complete history line (terminating newlines are present
function zshaddhistory() {
  # local history_complete="$1"
}

# Executed at the point where the main shell is about to exit normally.
function zshexit() {
}

# }}}
# Z-shell: auto completion {{{

autoload -Uz compinit
setopt EXTENDEDGLOB
if (( $(date '+%s' --date="1 day ago") > $(stat -c "%Z" ${HOME}/.zcompdump) )); then
# if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
# the string "#qN.mh+24" (to be specific, the "#") messes up the zsh syntax highlighting
  # echo "re-load .zcompdump"
  compinit
  compdump  # update the timestamp on compdump file
else
  # echo "within 24"
  compinit -C
fi
unsetopt EXTENDEDGLOB
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

# CURRENT STATE: does not select any sort of searching
# searching was too annoying and I didn't really use it
# If you want it back, use "search-backward" as an option
zstyle ':completion:*' menu select search-backward
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Fuzzy completion
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-A-Z}={A-Z\_a-z}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-A-Z}={A-Z\_a-z}' \
  'r:|?=** m:{a-z\-A-Z}={A-Z\_a-z}'
fpath=(/home/zach/Downloads/zsh-completions $fpath)
zmodload -i zsh/complist

# Add autocompletion path
fpath+=~/.zfunc

# }}}
# Z-shell: key-bindings {{{

# emacs
bindkey -e

# NOTE: about menu-complete
# '^d' - list options without selecting any of them
# '^i' - synonym to TAB; tap twice to get into menu complete
# '^o' - choose selection and execute
# '^m' - choose selection but do NOT execute AND leave all modes in menu-select
#         useful to get out of both select and search-backward
# '^z' - stop interactive tab-complete mode and go back to regular selection

# make vi keys do menu-expansion (eg, ^j does expansion, navigate with hjkl)
bindkey '^j' menu-expand-or-complete
bindkey -M menuselect '^j' menu-complete
bindkey -M menuselect '^k' reverse-menu-complete
bindkey -M menuselect '^h' backward-char
bindkey -M menuselect '^l' forward-char

# since <ctrl>+l is arrow right now, we need another clear-screen
bindkey -M main '^u' clear-screen

# delete function characters to include
# Omitted: /=
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# }}}
# ASDF: needs to run after ZSH setup {{{

source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

# }}}
# General: post-asdf env setup {{{

# # MANPATH: add asdf man pages to my man path
# MANPATH="$HOME/man"
# if [ -x "$(command -v fd)" ]; then
#   for value in $(fd man1 ~/.asdf/installs --type directory | sort -hr); do
#     MANPATH="$MANPATH:$(dirname $value)"
#   done
#   # colon at end. See "man manpath"
#   export MANPATH="$MANPATH:"
# fi

# include ~/.asdf/plugins/java/set-java-home.sh

# }}}
# Aliases {{{

# Easier directory navigation for going up a directory tree
alias 'cd..'='cd_up'  # can not name function 'cd..'; references cd_up below
alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias ,,,,,,='cd ../../../../../..'
alias ,,,,,,,='cd ../../../../../../..'
alias ,,,,,,,,='cd ../../../../../../../..'
alias ,,,,,,,,,='cd ../../../../../../../../..'
alias ,,,,,,,,,,='cd ../../../../../../../../../..'

# restore wallpapers
alias wallpaper='nitrogen --restore'

# Open the current directory
alias open='xdg-open . &>/dev/null'

# Vim and Vi
alias f='vim'
alias vi='vim'
alias vim='nvim'

# Tree that ignores annoying directories
alias itree="tree -I '__pycache__|venv|node_modules'"

# Grep, but ignore annoying directories
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias igrep="grep --perl-regexp -Ir \
--exclude='*~' \
--exclude='*.pyc' \
--exclude='*.csv' \
--exclude='*.tsv' \
--exclude='*.md' \
--exclude-dir='.bzr' \
--exclude-dir='.git' \
--exclude-dir='.svn' \
--exclude-dir='node_modules' \
--exclude-dir='venv'"

# enable color support of ls and also add handy aliases
alias ls='exa --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias sl='ls'
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

# diff
# r: recursively; u: shows line number; p: shows difference in C function
# P: if multiple files then showing complete path
alias diff="diff -rupP --color"

# Docker
# the more powerful drm/drmi have been created under "Functions"
# remove stopped containers
# alias drm="docker ps --no-trunc -aq | xargs docker rm"
# remove all untagged images
# alias drmi="docker images -q --filter 'dangling=true' | xargs docker rmi"

# Set copy/paste helper functions
# the perl step removes the final newline from the output
alias pbcopy="perl -pe 'chomp if eof' | xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

# Octave
alias octave="octave --no-gui"

# Public IP
alias publicip='wget -qO - http://ipecho.net/plain ; echo'

# Git
# check https://git-scm.com/download/linux regularly
# For Ubuntu, this PPA provides the latest stable upstream Git version:
# add-apt-repository ppa:git-core/ppa # apt update; apt install git
alias g="git status"
alias gl='git branch --verbose --all'
alias gm='git commit --verbose'
alias gma='git add --all && git commit --verbose'
alias gpl='git pull origin'
alias gph='git push origin'
alias ga='git add'
alias gd='git diff'
alias gdw='git diff --word-diff=color'
alias gru='git remote -v update'

# battery
alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|time\ to\ full|percentage"'
alias battc='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "capacity"'

# dynamodb
alias docker-dynamodb="docker run -v /data:$HOME/data -p 8000:8000 dwmkerr/dynamodb -dbPath $HOME/data"

# alias for say
alias say='spd-say'
compdef _dict_words say

# reload zshrc
alias so='source ~/.zshrc'

# slack-term aliases
alias slack-kepler='SLACK_TOKEN=$SLACK_TOKEN_KEPLER slack-term'

# my preferred top program
alias top='gotop'

# list all symbolic links
alias lssl='ls -la | grep "\->"'

# measure zsh startup time
alias tzsh='time zsh -i -c echo'

# customize psql
alias psql='LESS="-iMSx4 -FXR" PAGER="sed \"s/\([[:space:]]\+[0-9.\-]\+\)$/${LIGHT_CYAN}\1$NOCOLOR/; s/\([[:space:]]\+[0-9.\-]\+[[:space:]]\)/${LIGHT_CYAN}\1$NOCOLOR/g; s/|/$YELLOW|$NOCOLOR/g;s/^\([-+]\+\)/$YELLOW\1$NOCOLOR/\" 2>/dev/null | less" psql'

# Python
# Enable things like "pip install 'requests[security]'"
alias pip='noglob pip'
alias pipr='pip install -r'
alias pipi='pip install'

# git repo cleaner
alias bfg='java -jar /usr/local/bin/bfg.jar'

# AWS
alias emr='aws emr list-clusters --active | jq ".Clusters[]"'

# Copy file contents
alias cpf='xclip -sel clip'

# }}}
# Functions {{{

# Tmux Launch
# NOTE: I use the option "-2" to force Tmux to accept 256 colors. This is
# necessary for proper Vim support in the Linux Console. My Vim colorscheme,
# PaperColor, does a lot of smart translation for Color values between 256 and
# terminal 16 color support, and this translation is lost otherwise.
# Steps (assuming index of 1, which requires tmux config):
# 1. Create session in detached mode
# 2. Select first window
# 3. Rename first window to 'edit'
# 4. Attach to session newly-created session
function t() {
  if [ -n "$TMUX" ]; then
    # echo 'Cannot run t() in tmux session'
    return 1
  elif [[ $# > 0 ]]; then
    SESSION=$1
  else
    SESSION=Main
  fi
  HAS_SESSION=$(tmux has-session -t $SESSION 2>/dev/null)
  if [ $HAS_SESSION ]; then
    tmux attach -t $SESSION
  else
    tmux -2 new-session -d -s $SESSION
    tmux -2 select-window -t $SESSION:1
    tmux -2 rename-window edit
    tmux -2 attach -t $SESSION
  fi
}

# upgrade relevant local systems
function upgrade() {
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  asdf update
  asdf plugin-update --all
  pushd .
  cd ~/Downloads/alacritty
  git pull
  asdf local rust nightly
  alacritty-install
  popd
  asdf uninstall neovim nightly
  asdf install neovim nightly
  asdf global neovim nightly
  nvim -c 'PU'
  nvim -c 'CocUpdate'
}

function alacritty-install() {
  cargo build --release

  # Install
  sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database

  # terminfo
  tic -xe alacritty,alacritty-direct extra/alacritty.info

  # man page
  sudo mkdir -p /usr/local/share/man/man1
  gzip -c extra/alacritty.man | \
    sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
}

# Fix window dimensions: tty mode
# Set consolefonts to appropriate size based on monitor resolution
# For each new monitor, you'll need to do this manually
# Console fonts found here: /usr/share/consolefonts
# Finally, suppress all messages from the kernel (and its drivers) except panic
# messages from appearing on the console.
function fix-console-window() {
  echo "Getting window dimensions, waiting 5 seconds..."
  MONITOR_RESOLUTIONS=$(sleep 5 && xrandr -d :0 | grep '*')
  if $(echo $MONITOR_RESOLUTIONS | grep -q "3840x2160"); then
    setfont Uni3-Terminus32x16.psf.gz
  elif $(echo $MONITOR_RESOLUTIONS | grep -q "2560x1440"); then
    setfont Uni3-Terminus24x12.psf.gz
  fi
  echo "Enter sudo password to disable kernel from sending console messages..."
  sudo dmesg -n 1
}

function gitzip() {  # arg1: the git repository
  if [ $# -eq 0 ]; then
    local git_dir='.'
  else
    local git_dir="$1"
  fi
  pushd $git_dir > /dev/null
  local git_root=$(git rev-parse --show-toplevel)
  local git_name=$(basename $git_root)
  local outfile="$git_root/../$git_name.zip"
  git archive --format=zip --prefix="$git_name-from-zip/" HEAD -o "$outfile"
  popd > /dev/null
}

# Pipe man stuff to neovim
function m() {
  man --location "$@" &> /dev/null
  if [ $? -eq 0 ]; then
    nvim -c "Man $@" -c "only"
  else
    man "$@"
  fi
}
compdef _man m

# dictionary lookups
function def() {  # arg1: word
  dict -d gcide $1 | less -XF
}
compdef _dict_words def

function syn() {  # arg1: word
  dict -d moby-thesaurus $1 | less -XF
}
compdef _dict_words syn

# install
function install() {  # arg1: word
  apt-cache show $1 && sudo apt install $1
}

# Move up n directories using:  cd.. dir
function cd_up() {  # arg1: number|word
  pushd . >/dev/null
  cd $( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" ) # cd up into path (if found)
}

# Get the weather
function weather() {  # arg1: Optional<location>
  if [ $# -eq 0 ]; then
    curl "wttr.in/nyc?m"
  else
    curl "wttr.in/$1?m"
  fi
}

# Open files with gnome-open
function gn() {  # arg1: filename
  gio open $1
}

function global-install() {
  rustglobal-install
  nodeglobal-install
  pyglobal-install
  awscliglobal-install
  goglobal-install
}

function rustglobal-install() {
  rustup component add rls
  rustup component add rust-src
  cargo install bat
  cargo install cargo-deb
  cargo install cargo-edit
  cargo install cargo-update
  cargo install fd-find
  cargo install git-delta
  cargo install ripgrep
  asdf reshim rust
  cargo install-update -a
}

function nodeglobal-install() {
  local env=(
    @angular/cli
    bash-language-server
    devspace
    dockerfile-language-server-nodejs
    git+https://github.com/Perlence/tstags.git
    jsctags
    neovim
    nginx-linter
    nginxbeautifier
    npm
    prettier
    tree-sitter-cli
    write-good
  )
  npm install --no-save -g $env
  asdf reshim nodejs
}

function pydev-install() {  ## Install default python dependencies
  local for_pip=(
    bpython
    # ipython
    # pyright
    # mypy
    neovim-remote
    # pip
    # pylint
    pynvim
    wheel
  )
  pip install -U $for_pip
  asdf reshim python
}

function pipx-upgrade() {
  pipx uninstall $1
  pipx install $1
}

function pyglobal-install() {  ## Install global Python applications
  pip install -U pipx pynvim neovim-remote
  pydev-install
  asdf reshim python
  local for_pipx=(
    alacritty-colorscheme
    aws-sam-cli
    black
    cookiecutter
    docformatter
    docker-compose
    isort
    jupyterlab
    jupytext
    nginx-language-server
    mypy
    pre-commit
    restview
    toml-sort
    ueberzug
  )
  if command -v pipx > /dev/null; then
    for arg in $for_pipx; do
      pipx uninstall "$arg" && pipx install "$arg"
    done
  else
    echo 'pipx not installed. Install with "pip install pipx"'
  fi
}

function goglobal-install() {  ## Install default golang dependencies
  go get github.com/mattn/efm-langserver
  asdf reshim golang
}

function asdfl() {  ## Install and set the latest version of asdf
  asdf install $1 latest && asdf global $1 latest
}
compdef _asdf_complete_plugins asdfl

# activate virtual environment from any directory from current and up
# Name of virtualenv
VIRTUAL_ENV_DEFAULT=.venv
function va() {  # No arguments
  local venv_name="$VIRTUAL_ENV_DEFAULT"
  local old_venv=$VIRTUAL_ENV
  local slashes=${PWD//[^\/]/}
  local current_directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    if [ -d "$current_directory/$venv_name" ]; then
      source "$current_directory/$venv_name/bin/activate"
      if [[ "$old_venv" != "$VIRTUAL_ENV" ]]; then
        # echo "Activated $(python --version) virtualenv in $VIRTUAL_ENV"
        :
      fi
      return
    fi
    local current_directory="$current_directory/.."
  done
  # If reached this step, no virtual environment found from here to root
  if [[ -z $VIRTUAL_ENV ]]; then
  else
    deactivate
    # echo "Disabled existing virtualenv $old_venv"
  fi
}

# See https://stackoverflow.com/questions/50735140/why-does-python-version-not-print-string
# for doing string manipulation on python --version output
function shell_python_version() {
  echo $(python --version 2>&1) | awk '{print $2}'
}

# Create and activate a virtual environment with all Python dependencies
# installed. Optionally change Python interpreter.
function ve() {  # Optional arg: python interpreter name
  local venv_name="$VIRTUAL_ENV_DEFAULT"
  local python_version=$(shell_python_version)
  # if [ -z "$1" ]; then
  #   local python_name='python'
  # else
  #   local python_name="$1"
  # fi
  local python_name='python'
  if [ ! -d "$venv_name" ]; then
    if [[ $python_version == "2.7.15+" ]]; then
      # echo "You're using system python. Please use asdf!"
      return
    elif [[ $python_version =~ ^"2.7."* ]]; then
      pip install virtualenv
      virtualenv -p python "$venv_name"
    elif [[ $python_version =~ ^"3."* ]]; then
      $python_name -m venv "$venv_name"
      if [ $? -ne 0 ]; then
        local error_code=$?
        # echo "Virtualenv creation failed, aborting"
        return error_code
      fi
    fi
    source "$venv_name/bin/activate"
    if [ -z "$1" ]; then
      pip install -U pip
    else
      pip install pip==$1
    fi
    pydev-install  # install dependencies for editing
    deactivate
  else
    # echo "$venv_name already exists, activating"
    :
  fi
  source $venv_name/bin/activate
}
compdef _command ve

# Print out the Github-recommended gitignore
export GITIGNORE_DIR=$HOME/src/lib/gitignore
function gitignore() {
  if [ ! -d "$GITIGNORE_DIR" ]; then
    mkdir -p $HOME/src/lib
    git clone https://github.com/github/gitignore $GITIGNORE_DIR
    return 1
  elif [ $# -eq 0 ]; then
    echo "Usage: gitignore <file1> <file2> <file3> <file...n>"
    return 1
  else
    # print all the files
    local count=0
    for filevalue in $@; do
      echo "#################################################################"
      echo "# $filevalue"
      echo "#################################################################"
      cat $GITIGNORE_DIR/$filevalue
      if [ $count -ne $# ]; then
        echo
      fi
      (( count++ ))
    done
  fi
}
compdef "_files -W $GITIGNORE_DIR/" gitignore

# Initialize Python Repo
function poetry-init() {
  if [ -f pyproject.toml ]; then
    echo "pyproject.toml exists, aborting"
    return 1
  fi
  poetry init --no-interaction &> /dev/null
  cat-pyproject >> pyproject.toml
  toml-sort --in-place pyproject.toml
  touch README.md
}

# Create New Python Repo
function pynew() {
  if [ $# -ne 1 ]; then
    echo "pynew <directory>"
    return 1
  fi
  local dir_name="$1"
  if [ -d "$dir_name" ]; then
    echo "$dir_name already exists"
    return 1
  fi
  mkdir "$dir_name"
  cd "$dir_name"
  poetry-init
  gitignore Python.gitignore | grep -v instance/ > .gitignore
  mkinstance
  ve
  cat > main.py <<EOL
"""The main module"""

EOL
  git init
  git add .
  git commit -m "Initial commit"
}

# Profiling neovim
function nvim-profiler() {
  nvim --startuptime nvim_startup.txt \
    --cmd 'profile start nvim_init_profile.txt' \
    --cmd 'profile! file ~/.config/nvim/init.vim' \
    "$@"
}

function clubhouse() {
  _md_template "## Objective\n## Value\n## Acceptance Criteria"
}

function standup() {
  _md_template "*Yesterday?*\n*Today?*\n*Blockers?*"
}

# GIT: git-clone keplergrp repos to src/ directory
function klone() {
  git clone git@github.com:KeplerGroup/$1
}

# GIT: push current branch from origin to current branch
function push() {
  local current_branch="$(git rev-parse --abbrev-ref HEAD)"
  git push -u origin "$current_branch"
}

# GIT: pull current branch from origin to current branch
function pull() {
  local current_branch="$(git rev-parse --abbrev-ref HEAD)"
  git pull origin "$current_branch"
}

# GIT: prune/cleanup the local references to remote branch
# and delete merged local branches
function gc() {
  local refs="$(git remote prune origin --dry-run)"
  if [ -z "$refs" ]
  then
    echo "No prunable references found"
  else
    echo $refs
    while true; do
     read yn\?"Do you wish to prune these local references to remote branches?"
     case $yn in
       [Yy]* ) break;;
       [Nn]* ) return;;
       * ) echo "Please answer yes or no.";;
     esac
    done
    git remote prune origin
    echo "Pruned!"
  fi

  local branches="$(git branch --merged master | grep -v '^[ *]*master$')"
  if [ -z "$branches" ]
  then
    echo "No merged branches found"
  else
    echo $branches
    while true; do
     read yn\?"Do you wish to delete these merged local branches?"
     case $yn in
       [Yy]* ) break;;
       [Nn]* ) return;;
       * ) echo "Please answer yes or no.";;
     esac
    done
    echo $branches | xargs git branch -d
    echo "Deleted!"
  fi
}

# GIT: cd to the current git root
function groot() {
  if [ $(git rev-parse --is-inside-work-tree 2>/dev/null ) ]; then
    cd $(git root)
  else
    echo "'$PWD' is not inside a git repository"
    return 1
  fi
}

# open browser at current location:
# open current dir: $ gop .
# open relative dir: $ gop ../../
function gop() {
  # unset GITHUB_TOKEN
  # gh auth login
  if [ ! $(git rev-parse --is-inside-work-tree 2>/dev/null ) ]; then
    echo "'$PWD' is not inside a git repository"
    return 1
  fi
  local branch_current=$(git branch --show-current)
  gh browse $1 --branch "$branch_current"
}

function approve() {
  # 1st arg is the PR number
  # 2nd arg is the comment if any, otherwise use the 🚀 and 🤞
  if [ -z "$2" ]; then
    local message=""":rocket: :crossed_fingers: :rocket: :crossed_fingers: :rocket: :crossed_fingers:
:rocket: :crossed_fingers: :rocket: :crossed_fingers:
:rocket: :crossed_fingers:"""
  else
    local message="$2"
  fi
  gh pr review $1 --approve -b $message
  # echo $1 $message
}

# Timer
function countdown-seconds(){
  local date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do
    ## Is this more than 24h away?
    local days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
    echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
  echo ""
  spd-say "Beep, beep, beeeeeeeep. Countdown is finished"
}

function countdown-minutes() {
  countdown-seconds $(($1 * 60))
}

function stopwatch(){
  local date1=`date +%s`;
  while true; do
    local days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

function quote() {
  local cowsay_quote=$(echo "Daily fortune: "; \
    fortune; \
    echo; \
    echo "Daily word: "; \
    shuf -n 1 ~/.gre_words.txt;)
  echo -e "$cowsay_quote" | cowsay -n | cowsay -n -f gnu | lolcat;
  echo;
}

function drm() {
  local stopped_containers=$(docker ps --no-trunc -aq)
  if [ -z "$stopped_containers" ]
  then
    echo "No stopped containers found"
  else
    echo $stopped_containers | xargs docker rm
  fi
}

function drmi() {
  if [ $# -eq 0 ]
  then
    local dangling=$(docker images -q --filter 'dangling=true')
    if [ -z "$dangling" ]
    then
      echo "No dangling images found"
    else
      echo $dangling | xargs docker rmi
    fi
  else
    for img in "$@"
    do
      docker image rm \
        $(docker images --format "{{.Repository}}:{{.Tag}}" | grep $img)
    done
  fi
}

function drmi_old() {
  while true; do
   read yn\?"Do you wish to remove docker images older than $(date +'%Y-%m-%dT%H:%M:%S' --date='-'$1' days')?"
   case $yn in
     [Yy]* ) break;;
     [Nn]* ) return;;
     * ) echo "Please answer yes or no.";;
   esac
  done
  docker image prune -a --filter "until=$(date +'%Y-%m-%dT%H:%M:%S' --date='-'$1' days')"
}

function deshake-video() {
  # see below link for documentation
  # https://github.com/georgmartius/vid.stab
  if [ $# -ne 2 ]; then
    echo "deshake-video <infile> <outfile>"
    exit 1
  fi
  local infile="$1"
  local outfile="$2"
  local transfile="$infile.trf"
  if [ ! -f "$transfile" ]; then
    echo "Generating $transfile ..."
    ffmpeg2 -i "$infile" -vf vidstabdetect=result="$transfile" -f null -
  fi
  ffmpeg2 -i "$infile" -vf \
    vidstabtransform=smoothing=10:input="$transfile" \
    "$outfile"
}

function activate_direnv() {
  local is_direnv_here="$PWD/.envrc"
  if [ -f "$is_direnv_here" ]; then
    eval "$(direnv hook zsh)"
  fi
}

function senv() {
  # Switch only the environment in the CWD
  # Requires environment as an argument
  # Example: senv master
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  ENV=$(echo ${DIR} | sed "s/^.*\/kepler-terraform\///" | cut -d / -f 1)
  DIR_PREFIX=$(echo $DIR | awk -F "${ENV}" '{print $1}')
  DIR_SUFFIX=$(echo $DIR | awk -F "${ENV}" '{print $2}')
  if [[ $ENV == 'master' ]]; then
    NEW_ENV='integration'
  elif [[ $ENV == 'integration' ]]; then
    NEW_ENV='master'
  else
    NEW_ENV=$1
  fi
  cd "$DIR_PREFIX/$NEW_ENV/$DIR_SUFFIX"
}

function s3size() {
  # USAGE: returns s3 bucket size in GB
  # s3size kepler-devops (returns todays storage)
  # s3size kepler-devops 7 (returns storage from 7 days ago)
  if [[ -z $1 ]]; then
    echo "pass in S3 Bucket name! e.g. s3size kepler-devops"
    return 1
  fi
  S3_BUCKET=$1
  REGION=${REGION:-us-east-1}
  DATE_NOW=$(date +"%Y-%m-%d")
  if [[ ! -z $2 ]]; then
    DATE=$(date --date="$2 days ago" +"%Y-%m-%d")
  else
    DATE=$DATE_NOW
  fi
  echo $DATE
  aws cloudwatch get-metric-statistics \
    --namespace AWS/S3 \
    --start-time "${DATE}T00:00:00" \
    --end-time "${DATE}T01:00:00" \
    --statistics Average \
    --region $REGION \
    --period 86400 \
    --metric-name BucketSizeBytes \
    --dimensions Name=BucketName,Value=$S3_BUCKET Name=StorageType,Value=StandardStorage \
    | jq '.Datapoints[].Average' -r \
    | awk '{print $1/1024/1024/1024 " GB "}'
}

function shrug() {
  echo "¯\_(ツ)_/¯"
  echo -n "¯\_(ツ)_/¯" | xsel --clipboard --input
}

function ftt() {
  echo "(╯°□°)╯︵ ┻━┻"
  echo -n "(╯°□°)╯︵ ┻━┻" | xsel --clipboard --input
}

function poop() {
  echo "💩"
  echo -n "💩" | xsel --clipboard --input
}

function update_program() {
  case $1 in
    kitty)
      curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
      ;;
    zoom)
      curl -Lsf https://zoom.us/client/latest/zoom_amd64.deb -o /tmp/zoom_amd64.deb
      dpkg-sig --verify /tmp/zoom_amd64.deb
      sudo dpkg -i /tmp/zoom_amd64.deb
      ;;
    vault)
      if [ -z $2 ]; then
        echo "Missing Vault Version!"
      else
        curl -Lsf https://releases.hashicorp.com/vault/${2}/vault_${2}_linux_amd64.zip -o /tmp/vault.zip
        unzip -o -d $HOME/.local/bin/ /tmp/vault.zip
        echo "Updated Vault to $2"
      fi
      ;;
    chrome)
      curl -Lsf https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/googlechrome.deb
      sudo dpkg -i /tmp/googlechrome.deb
      ;;
  esac
}

# Get private IPs of out ECS instances
function get_ips() {
  if [ -z "$1" ]; then
    echo "Must Define an Instance Name! eg mgmt-ecs"
  else
    aws ec2 describe-instances \
      --filters \
      "Name=tag:Name,Values=${1}-asg" \
      "Name=instance-state-name,Values=running" \
      --query \
      "Reservations[*].Instances[*].{Instance:InstanceId,PrivateIP:PrivateIpAddress}" \
      --output \
      table
  fi
}

# Get the nth row from a given file on s3
function nth_row() {
  # 1st arg: s3 path
  # 2nd arg: row # that triggered the stl load error
  # example: nth_row s3://testingcopy/zliu/test.csv 32
  # to extract and display the 32nd row of this file
  local filename=$(basename -- "$1")
  local extension="${filename##*.}"
  # fiq: file in question
  local local_filename="fiq.${filename}"

  # copy the s3 file to local box
  aws s3 cp $1 $local_filename

  # deal with compressed file
  local proceed=true
  local comp_type=$(file $local_filename)
  if [[ "$comp_type" == *"bzip2"* ]]; then
    bzip2 -d $local_filename
    # trim the extension because it's decompressed
    local local_filename=${local_filename%.*}
  elif [[ "$comp_type" == *"gzip"* ]]; then
    gunzip $local_filename
    # trim the extension because it's decompressed
    local local_filename=${local_filename%.*}
  else
    if [[ $extension != "csv" && $extension != "tsv" && $extension != "json" ]]; then
      tput setaf 1;
      echo -e "Attention: this file is of $extension extension!"
      echo -e "Can't deal with '$comp_type' this type of file yet!"
      proceed=false
    fi
  fi

  if [[ $proceed = "true" ]]; then
    # extract the row that caused the issue
    local txt_type=$(file $local_filename)
    local total_lines=$(wc -l < $local_filename)
    if (( $2 > $total_lines )); then
      tput setaf 1;
      echo -e "The line you want to see exceed total lines $total_lines"
      proceed=false
    else
      echo "========== See data below =========="
      if [[ "$txt_type" == *"JSON"* ]]; then
        sed "${2}q;d" $local_filename | jq
      else
        sed "${2}q;d" $local_filename
      fi
    fi
  fi

  # clean-up: remove the downloaded files immediately in case it has PII info
  if [ -f $local_filename ]; then
    rm $local_filename
  fi
  if [[ $proceed = "false" ]]; then
    false
  fi
}

# }}}
# Spaceship configs {{{

# # https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md

# # SPACESHIP_PROMPT_ASYNC=false
# SPACESHIP_PROMPT_ORDER=(
#   user          # Username section
#   host          # Hostname section
#   dir           # Current directory section
#   git           # Git section (git_branch + git_status)
#   # package       # Package version
#   # node          # Node.js section
#   # ruby          # Ruby section
#   # xcode         # Xcode section
#   # golang        # Go section
#   # php           # PHP section
#   # rust          # Rust section
#   # haskell       # Haskell Stack section
#   # docker        # Docker section
#   # aws           # Amazon Web Services section
#   venv          # virtualenv section
#   pyenv         # Pyenv section
#   # kubecontext   # Kubectl context section
#   terraform     # Terraform workspace section
#   # exec_time     # Execution time
#   line_sep      # Line break
#   # battery       # Battery level and status
#   # vi_mode       # Vi-mode indicator
#   # jobs          # Background jobs indicator
#   # exit_code     # Exit code section
#   vpn           # on vpn or not
#   char          # Prompt character
# )

# SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_CHAR_SYMBOL='$ '
# SPACESHIP_DIR_PREFIX='['
# SPACESHIP_DIR_SUFFIX=']'
# SPACESHIP_DIR_TRUNC=0
# SPACESHIP_DIR_TRUNC_REPO=false
# SPACESHIP_HOST_COLOR=yellow
# SPACESHIP_HOST_PREFIX=@
# SPACESHIP_HOST_SHOW=always
# SPACESHIP_USER_COLOR=yellow
# SPACESHIP_USER_SHOW=always
# SPACESHIP_USER_SUFFIX=
# SPACESHIP_VENV_PREFIX=' ('
# SPACESHIP_VENV_SUFFIX=')'
# SPACESHIP_VENV_GENERIC_NAMES=()
# SPACESHIP_GIT_BRANCH_PREFIX='🌵 ['
# SPACESHIP_GIT_BRANCH_SUFFIX=']'
# SPACESHIP_GIT_STATUS_PREFIX=''
# SPACESHIP_GIT_STATUS_SUFFIX=''

# SPACESHIP_GIT_STATUS_UNTRACKED='新'
# SPACESHIP_GIT_STATUS_MODIFIED='外'
# SPACESHIP_GIT_STATUS_UNMERGED='爭'
# SPACESHIP_GIT_STATUS_DELETED='删'
# SPACESHIP_GIT_STATUS_STASHED='藏'
# SPACESHIP_GIT_STATUS_ADDED='裡'
# SPACESHIP_GIT_STATUS_DIVERGED='歧'
# SPACESHIP_GIT_STATUS_AHEAD='前'
# SPACESHIP_GIT_STATUS_BEHIND='後'
# SPACESHIP_GIT_STATUS_PUSH='推'
# SPACESHIP_GIT_STATUS_PULL='拉'
# SPACESHIP_GIT_STATUS_RENAMED='改'

# SPACESHIP_TERRAFORM_SHOW=true
# SPACESHIP_PYENV_SHOW=true

# }}}
# FZF {{{

# Load zsh script
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use fd to generate the list for file and directory completion
_fzf_compgen_path() {
  fd -c always --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd -c always --hidden --type d --follow --exclude ".git" . "$1"
}

# <C-t> does fzf; <C-i> does normal stuff; <C-o> does the same thing as enter
export FZF_COMPLETION_TRIGGER=''
export FZF_DEFAULT_OPTS="--bind=ctrl-o:accept --ansi"
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# }}}
# Executed Commands {{{

# if you want to see less of "quote"
if [[ -o interactive ]]; then
  if [[ "$TMUX_PANE" == "%0" ]]; then
    # if you're in the first tmux pane within all of tmux
    quote
  fi

  # doesn't work with powerlevel10k
  # # turn off ctrl-s and ctrl-q from freezing / unfreezing terminal
  # stty -ixon

  # Try activate virtual environment, don't worry about console output
  va &> /dev/null

fi

# }}}
# Profiler Footer {{{

 # zprof

 # unsetopt XTRACE
 # exec 2>&3 3>&-

# }}}
# Airflow breeze {{{

# START: Added by Updated Airflow Breeze autocomplete setup
source /home/zach/Documents/airflow/dev/breeze/autocomplete/breeze-complete-zsh.sh
# END: Added by Updated Airflow Breeze autocomplete setup

# }}}
