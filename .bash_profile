# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles:
for file in ~/.{exports,functions,bash_prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

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

# The pattern ** used in a pathname expansion context will match all files and zero or more directories and subdirectories. If the pattern is followed by a /, only directories and subdirectories match.
shopt -s globstar

# No empty completion
shopt -s no_empty_cmd_completion

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Load enabled aliases, completion, plugins
BASH_IT="$HOME/bash-it"

for file in "aliases" "completion" "plugins"
do
  source "$HOME/.reloader.bash" "$file"
done

# brew install jump
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# Vi mode
set -o vi
