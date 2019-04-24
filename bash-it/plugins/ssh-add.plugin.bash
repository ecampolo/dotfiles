# Add ssh-key to ssh-agent when key exist
if [ "$SSH_AUTH_SOCK" != "" ] && [ -f ~/.ssh/id_rsa ] && [ -x /usr/bin/ssh-add  ]; then
  ssh-add -l >/dev/null || alias ssh='(ssh-add -l >/dev/null || ssh-add) && unalias ssh; ssh'
fi
