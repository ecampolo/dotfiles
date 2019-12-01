# Add ssh-key to ssh-agent when key exist
if [ "$SSH_AUTH_SOCK" != "" ] && [ -f ~/.ssh/id_rsa ] && [ -x /usr/bin/ssh-add  ]; then
	ssh-add -l >/dev/null || alias ssh='(ssh-add -l >/dev/null || ssh-add) && unalias ssh; ssh'
fi

# Speed up runtime by caching this value
if command -v brew &> /dev/null; then
	BREW_PREFIX=$(brew --prefix)
fi

### Aliases

# Git
alias g='git'
alias get='git'
alias got='git'
alias gs='git status'
alias gaa='git add -A'

alias glog='git log'

alias gd='git diff'
alias gds='git diff --staged'

alias gb='git branch'
alias gba='git branch -a'
alias gbt='git branch --track'
alias gbm='git branch -m'
alias gbd='git branch -d'
alias gbD='git branch -D'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcam='git commit --amend -m'
alias gcanm='git commit --amend --no-edit'
alias gcwip='git commit -am "WIP"'

alias gac='gaa && gc'
alias gacm='gaa && gcm'
alias gaca='gaa && gca'
alias gacam='gaa && gcam'
alias gacanm='gaa && gcanm'
alias gacwip='gaa && gcwip'

alias gpublish='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gp='git push'
alias gpf='git push -f'

alias greplace='gacanm && gpf'

alias gl='git pull'
alias glr='git pull --rebase'

alias gf='git fetch --all'
alias gfp='gf --prune'

alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout --track'

alias grestore='git reset --hard && git clean -df'
alias gclean='git clean -df'
alias gmad='gb | egrep -v "(master|develop)" | xargs -n 1 git branch -D'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# We always use GNU ls 
alias ls="ls --color=auto"

# List dir contents aliases
# ref: http://ss64.com/osx/ls.html
# Long form, mark file types, file size, color
alias l="ls -lFh"
alias ll="l"

# Long form, mark file types, order by last modified, color
alias lt="ls -lFht"

# Long form, list all except . and ..., mark file types, file size, color
alias la="ls -laFh"

# Long form, list all except . and ..., mark file types, order by last modified, file size, color
alias lat="ls -laFht"

# List only directories, mark file types
alias lsd="ls -lhF | grep --color=never '^d'"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
	alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

### Exports

# Make vim the default editor.
export EDITOR='vim';

# Increase Bash history size.
export HISTSIZE='100000';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='erasedups:ignoreboth';
# Don't record some commands
export HISTIGNORE="exit:ls:ll:la:bg:fg:history:clear:cd*:pwd:g*"
# Print the timestamp of each command
export HISTTIMEFORMAT='%F %T '
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman";
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# GO
GOPATH="$HOME/go"
PATH="$PATH:${GOPATH}/bin"
PATH="$PATH:/usr/local/go/bin"

if [ $(uname) = "Darwin" ]; then
	# Get list of gnubin directories
	for d in ${BREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done

	# Setting PATH for Python 3.8
	PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin
	PATH=$PATH:/Users/ecampolo/Library/Python/3.8/bin
fi

export GOPATH
export PATH

### Completion

# Loads the system's Bash completion modules.
# If Homebrew is installed (OS X), its Bash completion modules are loaded.
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Some distribution makes use of a profile.d script to import completion.
if [ -f /etc/profile.d/bash_completion.sh ]; then
  . /etc/profile.d/bash_completion.sh
fi

if [ $(uname) = "Darwin" ] && command -v brew &>/dev/null ; then
  if [ -f "$BREW_PREFIX"/etc/bash_completion ]; then
    . "$BREW_PREFIX"/etc/bash_completion
  fi

 # homebrew/versions/bash-completion2 (required for projects.completion.bash) is installed to this path
  if [ "${BASH_VERSINFO}" -ge 4 ] && [ -f "$BREW_PREFIX"/share/bash-completion/bash_completion ]; then
    export BASH_COMPLETION_COMPAT_DIR="$BREW_PREFIX"/etc/bash_completion.d
    . "$BREW_PREFIX"/share/bash-completion/bash_completion
  fi
fi

# Add tab completion for export variables
complete -o nospace -S = -W '$(printenv | awk -F= "{print \$1}")' export

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist

# Use extended pattern matching features.
shopt -s extglob

# Replaces directory names with the results of word expansion when performing filename completion
shopt -s direxpand

# A command name that is the name of a directory is executed as if it were the argument to the cd command.
shopt -s autocd

# The pattern ** used in a pathname expansion context will match all files and zero or more directories and subdirectories.
# If the pattern is followed by a /, only directories and subdirectories match.
shopt -s globstar

# No empty completion
shopt -s no_empty_cmd_completion

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Bash prompt
source ~/.bash_prompt

# brew install jump
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"
