#!/bin/bash
# Install xterm-ghostty terminfo on remote machines via SSH.
# Usage: install-ghostty-terminfo-remote.sh user@hostname [user@hostname2 ...]
#
# This exports the local xterm-ghostty terminfo entry and installs it into
# ~/.terminfo on the remote host. No root access required.

set -euo pipefail

if [[ $# -eq 0 ]]; then
  echo "Usage: $(basename "$0") user@hostname [user@hostname2 ...]"
  exit 1
fi

# Find the local xterm-ghostty terminfo
find_terminfo() {
  # Try infocmp first (works if TERM or terminfo path is set up)
  if infocmp -x xterm-ghostty 2>/dev/null; then
    return 0
  fi

  # Try snap path
  local snap_path="/snap/ghostty/current/share/terminfo"
  if [[ -d "$snap_path" ]]; then
    TERMINFO="$snap_path" infocmp -x xterm-ghostty 2>/dev/null && return 0
  fi

  # Try common install paths
  local search_paths=(
    "/usr/share/terminfo"
    "/usr/local/share/terminfo"
    "$HOME/.local/share/terminfo"
    "$HOME/.terminfo"
  )
  for dir in "${search_paths[@]}"; do
    if [[ -d "$dir" ]]; then
      TERMINFO="$dir" infocmp -x xterm-ghostty 2>/dev/null && return 0
    fi
  done

  return 1
}

terminfo_data=$(find_terminfo) || {
  echo "Error: xterm-ghostty terminfo not found locally." >&2
  echo "Make sure Ghostty is installed on this machine." >&2
  exit 1
}

for host in "$@"; do
  echo "Installing xterm-ghostty terminfo on ${host}..."
  if echo "$terminfo_data" | ssh "$host" -- tic -x -o '~/.terminfo' -; then
    echo "  Done: ${host}"
  else
    echo "  Failed: ${host}" >&2
  fi
done
