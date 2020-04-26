export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagaced
export TERM=xterm-256color
export VIRTUAL_ENV_DISABLE_PROMPT=0

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list '' 'r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit

autoload -Uz colors && colors

#git
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%b'
zstyle ':vcs_info:*' formats       \
    '%b'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "${vcs_info_msg_0_}"
  fi
}

function ranger_prompt() {
  if [[ $RANGER_LEVEL -eq 1 ]]; then
    echo "[ranger]"
  elif [[ $RANGER_LEVEL -gt 1 ]]; then
    echo "[ranger $RANGER_LEVEL]"
  fi
}

function zsh_prompt() {
    username="%n"
    hostname="%{$fg[green]%}%2d%{$reset_color%}"
    backgrounded="%(1j.[%j].)"
    nextrow="\n%{$fg[cyan]%}♕%{$reset_color%}  "
    echo "[$username in $hostname] $(ranger_prompt) $backgrounded $nextrow"
}

PS1="$(zsh_prompt)"
RPS1=$'$(git_prompt_string)'

GIT_PROMPT_PREFIX="["
GIT_PROMPT_SUFFIX="]"
GIT_PROMPT_AHEAD="%{$fg[red]%}↑NUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}↓NUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}·%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}·%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}·%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropirate for Git remote states
parse_git_remote_state() {
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi

    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

# If inside a Git repository, print its branch and state
git_prompt_string() {
    local git_where="$(parse_git_branch)"
    [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$(parse_git_remote_state)$GIT_PROMPT_PREFIX${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

school() {
  cd ~/LocalDocs/School/sp2020/cs"$1"
}

res() {
  cd ~/Localdocs/School/sp2020/research
}

mlab() {
  cd ~/LocalDocs/MLAB
}

# git alias
alias gl='git log'
alias gd='git diff'
alias gs='git status'

ga() {
    git add "$1"
}

gc() {
    git commit -m "$1"
}

# ls rebinds
la() {
    ls -Ga
}

ll() {
    ls -Gl
}

l() {
    ls -G
}

# other

alias b='cd ..'
