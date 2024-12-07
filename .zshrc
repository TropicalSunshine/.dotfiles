function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}

#options
setopt prompt_subst

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# cursor
export PROMPT='%F{197}%~%f %F{yellow}($(parse_git_branch))%f$'
export LSCOLORS="cxfxcxdxbxegedabagacad"

#alias
#alias load='source ~/.bashrc && source ~/.bash_profile && source ~/.profile'

alias bc="bazel configure"
alias ga="git add -A"
alias gc="git commit -m"
alias gp='git push origin $(parse_git_branch)'
alias gpo='git pull origin $(parse_git_branch)'
alias gacp='ga && gc "update" && gp'
alias bgacp='bazel configure && gacp'
alias ssh-nh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentitiesOnly=yes -o LogLevel=ERROR'

alias vim='nvim'
alias ls='ls -ca'

