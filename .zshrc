export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagaced
export TERM=xterm-256color

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
    username="%m"
    hostname="%n"
    backgrounded="%(1j.[%j].)"
    nextrow="\n%{$fg[magenta]%}%~ $ %{$reset_color%}"
    echo "[%{$fg[green]%}$username%{$reset_color%} in %{$fg[green]%}$hostname%{$reset_color%}] $(ranger_prompt) $backgrounded $nextrow"
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


neuro() {
  cd ~/LocalDocs/NeuroClarity
}

school() {
  cd ~/LocalDocs/School/fa20
}

# git alias
alias gl='git log'
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
alias env="echo $VIRTUAL_ENV"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

alias vim='mvim -v'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended" # use extended regex
export FZF_DEFAULT_COMMAND="fd --type f"  # ignore any files in .gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# mkvirtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_VIRTUALENV=/Library/Frameworks/Python.framework/Versions/3.8/bin/virtualenv
export VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/3.8/bin/python3
source /Library/Frameworks/Python.framework/Versions/3.8/bin/virtualenvwrapper.sh

alias python=python3
