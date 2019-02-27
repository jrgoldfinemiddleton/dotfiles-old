# .bashrc
#  Note: large portions of this file either copied from or inspired by
#        Jeff Geerling's dotfiles repo:
#        https://github.com/geerlingguy/dotfiles

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Custom prompt
export PS1="\[\e[0;32m\] \[\e[1;32m\]\t \[\e[0;2m\]\w \[\e[0m\]\$ "

# Use colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export HISTTIMEFORMAT="%F %T  "

update_history () {
    history -a ${HISTFILE}.$$
    history -c
    history -r
    if ls ${HISTFILE}.[0-9]* >/dev/null 2>&1; then
        for f in `ls ${HISTFILE}.[0-9]* | grep -v "${HISTFILE}.$$\$"`; do
            history -r $f
        done
    fi
    history -r "${HISTFILE}.$$"
}

# merge session history into main history file on bash exit
merge_session_history () {
    cat ${HISTFILE}.$$ >> $HISTFILE
    rm ${HISTFILE}.$$
}

trap merge_session_history EXIT

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Ansible
export ANSIBLE_ROOT=~/Developer/ansible
export ANSIBLE_ROLES=~/Developer/roles

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load Bash command autocompletion (if present)
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

# Git upstream branch syncer.
# Usage: gsync master (checks out master, pull upstream, push origin).
function gsync() {
  if [[ ! "$1" ]] ; then
      echo "You must supply a branch."
      return 0
  fi

  BRANCHES=$(git branch --list $1)
  if [ ! "$BRANCHES" ] ; then
     echo "Branch $1 does not exist."
     return 0
  fi

  git checkout "$1" && \
  git pull upstream "$1" && \
  git push origin "$1"
}

# Tell Homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [centos7|fedora27|debian9|debian8|ubuntu1404|etc.]
dockrun() {
  docker run -it jrgoldfinemiddleton/docker-"${1:-ubuntu1604}"-ansible /bin/bash
}

# Enter a running Docker container.
function denter() {
  if [[ ! "$1" ]] ; then
      echo "You must supply a container ID or name."
      return 0
  fi

  docker exec -it $1 bash
  return 0
}

# Delete a given line number in the known_hosts file.
knownrm() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "error: line number missing" >&2;
  else
    sed -i '' "$1d" ~/.ssh/known_hosts
  fi
}
