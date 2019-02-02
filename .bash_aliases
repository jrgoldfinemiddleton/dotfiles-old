# .bash_aliases

### Ansible aliases ###

alias ag="ansible-galaxy"
alias av="ansible-vault"
alias avc="ansible-vault create"
alias ave="ansible-vault edit"
alias ap="cd $ANSIBLE_ROOT; ansible-playbook"
alias cda="cd $ANSIBLE_ROOT"


### Docker aliases ###

# Docker image visualization (usage: `dockviz images -t`).
alias dockviz="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"


### Git aliases ###

alias gs="git status"
alias gc="git commit"
alias gp="git pull --rebase"
alias gcam="git commit -am"
alias gl="git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit"


### Tmux aliases ###

alias tma="tmux attach"
