#!/bin/bash

# export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export PULSE_SERVER=tcp:$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}')
export DISTRO_DNS=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
export LIBGL_ALWAYS_INDIRECT=1
export GOPATH=$HOME/go
export PATH=$HOME/.bazel/bin:$PATH:$HOME/bin:$GOPATH/bin:$HOME/.cargo/bin:/opt/android-studio/bin:/usr/roborio/bin:$HOME/.nvim/bin:$HOME/.bazel/bin/:$HOME/.local/bin
export EDITOR=nvim
export GPG_TTY=$(tty)
export JAVA_HOME=/usr/lib/jvm/java-11-oracle/

alias e=$EDITOR
alias kmux="pkill tmux:\ server"
alias tmux="tmux attach"

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOUR="\[\033[0m\]"

function _git_prompt() {
  local git_status="git --git-dir=$(echo -n \$PWD)/.git status -unormal 2>&1"
  echo $git_status
  local test=$(eval $git_status)
  echo $test
  
  # Checks to see if we're in a git repo
  if ! [[ "$git_status" =~ not\ a\ git\ repo ]]; then
    # if we're in a repo thats clean, then color it green
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local ansi=$GREEN
      # if the repos dirty, color it red
      elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=$RED
    else
     #Just to be sure, color it red
     local ansi=$RED
    fi
    
    # Get git branch name
    # checks the output of git status for "On branch " then uses that to set the branch
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      #test "$branch" != master || branch=' '
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
      echo HEAD`)"
    fi
    # prints out " | $branch_name"
    echo -n '| '"$ansi"''"$branch"'\[\e[0m\] [$(_git_changes)]'
  fi
}

function _git_changes {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || return 1
  
  local added_symbol="*"
  local unmerged_symbol="✗"
  local modified_symbol="+"
  local clean_symbol="✔"
  local has_untracked_files_symbol="?"
  
  local ahead_symbol="↑"
  local behind_symbol="↓"
  
  local unmerged_count=0 modified_count=0 has_untracked_files=0 added_count=0 is_clean=""
  
  set -- $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
  local behind_count=$1
  local ahead_count=$2
  
  # Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R), changed (T), Unmerged (U), Unknown (X), Broken (B)
  while read line; do
    case "$line" in
      M*) modified_count=$(( $modified_count + 1 )) ;;
      U*) unmerged_count=$(( $unmerged_count + 1 )) ;;
    esac
  done < <(git diff --name-status)
  
  while read line; do
    case "$line" in
      *) added_count=$(( $added_count + 1 )) ;;
    esac
  done < <(git diff --name-status --cached)
  
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    has_untracked_files=1
  fi
  
  if [ $(( unmerged_count + modified_count + has_untracked_files + added_count )) -eq 0 ]; then
    is_clean=1
  fi
  
  local leading_whitespace=""
  [[ $ahead_count -gt 0 ]]         && { printf "%s" "$leading_whitespace$ahead_symbol$ahead_count"; leading_whitespace=" "; }
  [[ $behind_count -gt 0 ]]        && { printf "%s" "$leading_whitespace$behind_symbol$behind_count"; leading_whitespace=" "; }
  [[ $modified_count -gt 0 ]]      && { printf "%s" "$leading_whitespace$modified_symbol$modified_count"; leading_whitespace=" "; }
  [[ $unmerged_count -gt 0 ]]      && { printf "%s" "$leading_whitespace$unmerged_symbol$unmerged_count"; leading_whitespace=" "; }
  [[ $added_count -gt 0 ]]         && { printf "%s" "$leading_whitespace$added_symbol$added_count"; leading_whitespace=" "; }
  [[ $has_untracked_files -gt 0 ]] && { printf "%s" "$leading_whitespace$has_untracked_files_symbol"; leading_whitespace=" "; }
  [[ $is_clean -gt 0 ]]            && { printf "%s" "$leading_whitespace$clean_symbol"; leading_whitespace=" "; }
}

# Bash History Replacement Script
#    Author: Caesar Kabalan
#    Last Modified: June 6th, 2017
# Description:
#    Modifies the default Bash Shell prompt to be in the format of:
#       [CWD:COUNT:BRANCH:VENV]
#       [USER:HOSTNAME] _
#    Where:
#       CWD - Current working directory (green if last command returned 0, red otherwise)
#       COUNT - Session command count
#       BRANCH - Current git branch if in a git repository, omitted if not in a git repo
#       VENV - Current Python Virtual Environment if set, omitted if not set
#       USER - Current username
#       HOSTNAME - System hostname
#    Example:
#       [~/projects/losteyelid:8:master:losteyelid]
#       [ckabalan:spectralcoding] _
# Installation:
#    Add the following to one of the following files
#       System-wide Prompt Change:
#          /etc/profile.d/bash_prompt_custom.sh (new file)
#          /etc/bashrc
#       Single User Prompt Change:
#          ~/.bashrc
#          ~/.bash_profile

# function set_bash_prompt () {
# 	# Color codes for easy prompt building
# 	COLOR_DIVIDER="\[\e[30;1m\]"
# 	COLOR_CMDCOUNT="\[\e[34;1m\]"
# 	COLOR_USERNAME="\[\e[34;1m\]"
# 	COLOR_USERHOSTAT="\[\e[34;1m\]"
# 	COLOR_HOSTNAME="\[\e[34;1m\]"
# 	COLOR_GITBRANCH="\[\e[33;1m\]"
# 	COLOR_VENV="\[\e[33;1m\]"
# 	COLOR_GREEN="\[\e[32;1m\]"
# 	COLOR_PATH_OK="\[\e[32;1m\]"
# 	COLOR_PATH_ERR="\[\e[31;1m\]"
# 	COLOR_NONE="\[\e[0m\]"
# 	# Change the path color based on return value.
# 	if test $? -eq 0 ; then
# 		PATH_COLOR=${COLOR_PATH_OK}
# 	else
# 		PATH_COLOR=${COLOR_PATH_ERR}
# 	fi
# 	# Set the PS1 to be "[workingdirectory:commandcount"
# 	PS1="${COLOR_DIVIDER}[${PATH_COLOR}\w${COLOR_DIVIDER}:${COLOR_CMDCOUNT}\#${COLOR_DIVIDER}"
# 	# Add git branch portion of the prompt, this adds ":branchname"
# 	if ! git_loc="$(type -p "$git_command_name")" || [ -z "$git_loc" ]; then
# 		# Git is installed
# 		if [ -d .git ] || git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
# 			# Inside of a git repository
# 			GIT_BRANCH=$(git symbolic-ref --short HEAD)
# 			PS1="${PS1}:${COLOR_GITBRANCH}${GIT_BRANCH}${COLOR_DIVIDER}"
# 		fi
# 	fi
# 	# Add Python VirtualEnv portion of the prompt, this adds ":venvname"
# 	if ! test -z "$VIRTUAL_ENV" ; then
# 		PS1="${PS1}:${COLOR_VENV}`basename \"$VIRTUAL_ENV\"`${COLOR_DIVIDER}"
# 	fi
# 	# Close out the prompt, this adds "]\n[username@hostname] "
# 	PS1="${PS1}]\n${COLOR_DIVIDER}[${COLOR_USERNAME}\u${COLOR_USERHOSTAT}@${COLOR_HOSTNAME}\h${COLOR_DIVIDER}]${COLOR_NONE} "
# }

# # Tell Bash to run the above function for every prompt
# export PROMPT_COMMAND=set_bash_prompt
# export PROMPT_COMMAND='export PS1="${_PS1}\n$ ($SHLVL) "'
# if [ $SHLVL -eq 1 ]
# then 
#     export PROMPT_COMMAND='export PS1="${_PS1}\n$ "'
# fi

#aliases and functions
# Some directory listing with colors
alias sl=ls
alias ls='exa'           # Compact view, show colors
alias la='exa -aF'       # Compact view, show hidden
alias ll='exa -al'
alias l='exa -a'
alias l1='exa -1'

function download(){
  curl -O "$1"
}


alias dl=download


# incase i forget how to clear
alias c='clear'
alias k='clear'
alias cls='clear'

# archive file or folder
function compress() {
  dirPriorToExe=`pwd`
  dirName=`dirname $1`
  baseName=`basename $1`
  
  if [ -f $1 ] ; then
    echo "It was a file change directory to $dirName"
    cd $dirName
    case $2 in
      tar.bz2)
        tar cjf $baseName.tar.bz2 $baseName
      ;;
      tar.gz)
        tar czf $baseName.tar.gz $baseName
      ;;
      gz)
        gzip $baseName
      ;;
      tar)
        tar -cvvf $baseName.tar $baseName
      ;;
      zip)
        zip -r $baseName.zip $baseName
      ;;
      *)
        echo "Method not passed compressing using tar.bz2"
        tar cjf $baseName.tar.bz2 $baseName
      ;;
    esac
    echo "Back to Directory $dirPriorToExe"
    cd $dirPriorToExe
  else
    if [ -d $1 ] ; then
      echo "It was a Directory change directory to $dirName"
      cd $dirName
      case $2 in
        tar.bz2)
          tar cjf $baseName.tar.bz2 $baseName
        ;;
        tar.gz)
          tar czf $baseName.tar.gz $baseName
        ;;
        gz)
          gzip -r $baseName
        ;;
        tar)
          tar -cvvf $baseName.tar $baseName
        ;;
        zip)
          zip -r $baseName.zip $baseName
        ;;
        *)
          echo "Method not passed compressing using tar.bz2"
          tar cjf $baseName.tar.bz2 $baseName
        ;;
      esac
      echo "Back to Directory $dirPriorToExe"
      cd $dirPriorToExe
    else
      echo "'$1' is not a valid file/folder"
    fi
  fi
  echo "Done"
  echo "###########################################"
}

[ -s "$HOME/.bash/completions/*" ] && for file in ~/.bash/completions/* ; do
  . $file
done

. /etc/bash_completion

csv() {
  cat $1 | column -s , -t | less -#2 -N -S
}

u () {
  curl -F 'file=@'$1 http://0x0.st
}

ccc() {
  clang++ -fsanitize=leak -g $@ && ./a.out && rm a.out
}

ggg() {
  g32 -fsanitize=leak -g $@ && ./a.out && rm a.out
}

alias x=extract
alias v=csv
alias o=xdg-open
alias open=o
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
export HISTCONTROL=ignoredups
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

. ~/.local/share/nvim/plugged/gruvbox/gruvbox_256palette.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(thefuck --alias)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "$HOME/.cargo/env"
export SPICETIFY_INSTALL="/home/jishnu/spicetify-cli"
export PATH="$SPICETIFY_INSTALL:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jishnu/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jishnu/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jishnu/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jishnu/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# source ~/.local/share/blesh/ble.sh
eval "$(starship init bash)"
