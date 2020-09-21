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
alias got='git' # jon snow uses git
alias gti='git' # cuz we love sport cars
alias gs='git status'
alias gaa='git add -A'

alias glog='git log'

alias gd='git diff'
alias gds='git diff --staged'

alias gb='git branch'
alias gbr='git branch -r'
alias gbm='git branch -m'
alias gbd='git branch -d'
alias gbD='git branch -D'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcam='git commit --amend -m'
alias gcanm='git commit --amend --no-edit'

alias gac='gaa && gc'
alias gacm='gaa && gcm'
alias gaca='gaa && gca'
alias gacam='gaa && gcam'
alias gacanm='gaa && gcanm'

alias gw='gaa && gcm "WIP"'

alias gpublish='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gp='git push'
alias gpf='git push -f'

alias greplace='gacanm && gpf'

alias gl='git pull origin $(git rev-parse --abbrev-ref HEAD)'

alias gf='git fetch --all'
alias gfp='gf --prune'

alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout --track'

# grestore restores the current branch with its remote. Local changes (untracked, staged or unstaged files) are discarded. Be careful.
alias grestore='f(){ local b=$(git rev-parse --abbrev-ref HEAD); git fetch origin $b; git clean -df && git reset --hard origin/$b; unset -f f; }; f'
# gmad will switch to either develop or master branch if exists, in that order. Then it will remove any other branch except master and develop and run gsync.
alias gmad='git clean -df && gco -f develop 2>/dev/null || gco -f master && gb | egrep -v "(master|develop)" | xargs -n 1 git branch -D && gsync'

# gsq squash current branch with parent
alias gsq='git rebase -i $(git merge-base $(git rev-parse --abbrev-ref HEAD) $(basename $(git symbolic-ref refs/remotes/origin/HEAD)))'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# We always use GNU ls
alias ls="ls --color=auto"

# List dir contents aliases
# ref: http://ss64.com/osx/ls.html
alias l="ls -lFGhp"
alias ll="l"
alias lt="ls -lFGhpt"
alias ltr="ls -lFGhptr"
alias la="ls -alFGhp"

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
export HISTIGNORE="exit:ls:ll:la:bg:fg:history:clear:cd*:pwd"
# Print the timestamp of each command
export HISTTIMEFORMAT='%F %T '
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman";
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# Path
GOPATH="$HOME/go"
GOBIN="$GOPATH/bin"
PATH="/usr/local/go/bin:$GOBIN:$PATH"

if [ $(uname) = "Darwin" ]; then
	# Get list of gnubin directories
	for d in ${BREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done

	# Setting PATH for Python 3.8
	PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin
	PATH=$PATH:/Users/ecampolo/Library/Python/3.8/bin
fi

export GOPATH
export GOBIN
export PATH

### Functions
pr() {
	id=$1
	if [ -z "$id" ]; then
		echo "Please provide PR number as argument"
		return 1
	fi
	
	git fetch origin pull/"${id}"/head:pr-"${id}"
	git checkout pr-"${id}"
}

### Completion

# Loads the system's Bash completion modules. Copied from system.completion.bash file from bash-it repository.
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

### Shopt-Builtin (https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html)

# Execute a command name that is the name of a directory as if it were the argument to the cd command.
shopt -s autocd

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Check the window size after each external (non-builtin) command and, if necessary, updates the values of LINES and COLUMNS.
shopt -s checkwinsize

# Save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist

# Replace directory names with the results of word expansion when performing filename completion.
shopt -s direxpand

# Attempt spelling correction on directory names during word completion if the directory name initially supplied does not exist.
shopt -s dirspell

# Use extended pattern matching features.
shopt -s extglob

# The pattern ** used in a pathname expansion context will match all files and zero or more directories and subdirectories.
# If the pattern is followed by a /, only directories and subdirectories match.
shopt -s globstar

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# No empty completion
shopt -s no_empty_cmd_completion

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Bash prompt
source ~/.bash_prompt

# brew install jump
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"

unset -f BREW_PREFIX	
