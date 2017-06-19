# Environment Variables --- {{{

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# cron editor
export EDITOR=vim

# }}}
# Executed Commands --- {{{

# Initialize terminal instance with tmux
# [[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux

# turn off ctrl-s and ctrl-q from freezing / unfreezing terminal
stty -ixon

# run cowsay
shuf -n 1 ~/Documents/system_configs/gre_words.txt | cowsay

# }}}
# Aliases --- {{{

# Easier directory navigation for going up a directory tree
alias 'a'='cd - &> /dev/null'
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

# Tree that ignores annoying directories
alias itree="tree -I '__pycache__|venv'"

# Tmux launch script
alias t='~/tmuxlaunch.sh'

# mdm service
alias rescreen="sudo service mdm restart"

# Redis
alias credis="ps -aux | grep redis" # check running redis
alias nredis="/etc/init.d/redis-server stop"  # stop redis

# pip upgrade all
alias pipall="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

# Show Linux kernal version
alias kernal="uname -r"

# Show cpu type
alias cpumodel="cat /proc/cpuinfo | grep 'model name' | head -1"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Set up useful commands
alias ll="ls -alh --color=auto"
alias ls="ls -lh --color=auto"
alias sz="du -h -d 1"
alias nox="chmod -R -x+X *"

# Set up virtual environment
alias ve36="virtualenv -p python3.6 venv; source venv/bin/activate; pip install bpython; pip freeze"
alias ve3="virtualenv -p python3.5 venv; source venv/bin/activate; pip install bpython; pip freeze"
alias ve2="virtualenv -p python2.7 venv; source venv/bin/activate; pip install bpython; pip freeze"
alias va="source venv/bin/activate"

# Docker
# remove stopped containers
alias drm="docker ps --no-trunc -aq | xargs docker rm"
# remove all untagged images
alias drmi="docker images -q --filter 'dangling=true' | xargs docker rmi"

# Copy and paste using terminal
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Open tmux with proper color schemes enabled
alias tmux='tmux -2'

# View public IP address
alias publicip='wget -qO - http://ipecho.net/plain ; echo'

# Git aliases
alias g="git status"

# }}}
# Functions --- {{{

# OpenVPN
function ovpn {
  cd /home/zach/openvpn
  sudo openvpn --config zach.conf \
    --up /etc/openvpn/update-resolv-conf \
    --script-security 2
}

# open with gnome-open
function gn() {  # arg1: filename
  gnome-open "$1" &> /dev/null
}

# dictionary
function definition() {  # arg1: word
  dict -d gcide $1 | less
}

function synonym() {  # arg1: word
  dict -d moby-thesaurus $1 | less
}

# }}}
# Command line prompt (PS1) --- {{{

# Set command to include git branch in my prompt
COLOR_BRIGHT_GREEN="\033[38;5;10m"
COLOR_BRIGHT_BLUE="\033[38;5;115m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_PURPLE="\033[1;35m"
COLOR_ORANGE="\033[38;5;202m"
COLOR_BLUE="\033[34;5;115m"
COLOR_WHITE="\033[0;37m"
COLOR_GOLD="\033[38;5;142m"
COLOR_SILVER="\033[38;5;248m"
COLOR_RESET="\033[0m"
BOLD="$(tput bold)"

function git_color {
  local git_status="$(git status 2> /dev/null)"
  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  local git_commit="$(git --no-pager diff --stat origin/${branch} 2>/dev/null)"
  if [[ $git_status == "" ]]; then
    echo -e $COLOR_SILVER
  elif [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]] && \
      [[ ! -n $git_commit ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_ORANGE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  else
    echo "(no git)"
  fi
}

# Set Bash PS1
PS1_DIR="\

\[$BOLD\]\[$COLOR_BLUE\]\u@\h \[$BOLD\]\[$COLOR_PURPLE\][\w] "

PS1_GIT="\[\$(git_color)\]\[$BOLD\]\$(git_branch)\[$BOLD\]\[$COLOR_RESET\] "

PS1_END="\

\[$BOLD\]$ \[$COLOR_RESET\]"

PS1="${PS1_DIR}${PS1_GIT}${PS1_END}"

# }}}
# Imports from other files --- {{{

if [ -f ~/.bash/sensitive ]; then
  source ~/.bash/sensitive
fi

# Bash autocomplete
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Autojump
source /usr/share/autojump/autojump.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/zach/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/home/zach/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/zach/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/home/zach/Downloads/google-cloud-sdk/completion.bash.inc'
fi

# }}}
# path appends --- {{{

# Matlab
export PATH="$PATH:/usr/local/MATLAB/R2016b/bin"

#}}}
# Command history --- {{{

# Add timestamp to history
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S "
# ignore duplicates
export HISTCONTROL=ignoreboth
# Number of lines to keep in bash history
export HISTSIZE=50000
# When shell exits, append to history file instead of overwriting
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#}}}
