# Bash version check
if ((BASH_VERSINFO[0] < 4))
then
  echo "sensible.bash: Looks like you're running an older version of Bash."
  echo "sensible.bash: You need at least bash-4.0 or some options will not work correctly."
  echo "sensible.bash: Keep your software up-to-date!"
fi

# Bash prompt
source ~/.bash_prompt

# Make vim the default editor.
export EDITOR='vim';

# Increase Bash history size.
export HISTSIZE='100000';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='erasedups:ignoreboth';
# Don't record some commands
export HISTIGNORE="exit:ls:ll:la:bg:fg:history:clear:cd*:pwd:git st:git co:gs:gl"
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

# Set 256 color profile where possible
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman";
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# GO
export GOPATH=$HOME/go
export PATH=$PATH:${GOPATH}/bin
export PATH=$PATH:/usr/local/go/bin

if [ $(uname) = "Darwin" ]; then
	# Get list of gnubin directories
	export GNUBINS="$(find /usr/local/opt -type d -follow -name gnubin -print)"

	for bindir in ${GNUBINS[@]}; do
		export PATH=$bindir:$PATH
	done;

    # Setting PATH for Python 3.8
    export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin
    export PATH=$PATH:/Users/ecampolo/Library/Python/3.8/bin

    # Oracle
    export CGO_CFLAGS=-I/Users/ecampolo/oracle/instantclient_18_1/sdk/include
    export CGO_LDFLAGS=-L/Users/ecampolo/oracle/instantclient_18_1
    export DYLD_LIBRARY_PATH=/Users/ecampolo/oracle/instantclient_18_1:$DYLD_LIBRARY_PATH
fi

# Bash-it !
BASH_IT="$HOME/bash-it"
source $HOME/.reloader.bash aliases
source $HOME/.reloader.bash completion
source $HOME/.reloader.bash plugins
unset BASH_IT

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

# brew install jump
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"
