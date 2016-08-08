#!bash
#
# Command completion

# Only source completion if the shell is interactive.
if [ -n "$INTERACTIVE" ]; then
  bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
  if [ $bmajor -gt 1 ]; then
    # Search for a bash_completion file to source.
    for f in /usr/local/etc/bash_completion \
             /usr/pkg/etc/bash_completion \
             /opt/local/etc/bash_completion \
             /usr/share/bash-completion/bash_completion \
             /etc/bash_completion
    do
      if [ -f $f ]; then
        . $f
        break
      fi
    done
  fi
  unset bash bmajor bminor

  if [ -z "$BASH_COMPLETION" ]; then
    # Source the Homebrew bash_completion if a system-wide version wasn't used.
    [ -n "$(command -v brew)" ] && [ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion
  fi

  if [ -z "$BASH_COMPLETION" ]; then
    # If there's no system-wide bash_completion, source the user one ourselves.
    [ -f ~/.bash_completion ] && . ~/.bash_completion
  fi
fi
