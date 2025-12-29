#!/bin/bash

capture_command()
{
  tee /tmp/capture.out
}
get_command()
{
  cat /tmp/capture.out
}

# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_github_latest_release_tag() {
  local repo="$1"
  local tag=""

  # Prefer GitHub API; fall back to latest release redirect if API is unavailable.
  tag=$(
    curl --silent --location --fail \
      -H "Accept: application/vnd.github+json" \
      -H "User-Agent: dotfiles-installer" \
      "https://api.github.com/repos/${repo}/releases/latest" 2>/dev/null |
      sed -n -E 's/.*"tag_name"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/p' |
      head -n 1
  )

  if [[ -n "$tag" ]]; then
    printf '%s\n' "$tag"
    return 0
  fi

  tag=$(
    curl --silent --location --fail \
      -H "User-Agent: dotfiles-installer" \
      -o /dev/null -w '%{url_effective}' \
      "https://github.com/${repo}/releases/latest" 2>/dev/null |
      sed -n -E 's#.*/tag/(v?[0-9A-Za-z._-]+)$#\1#p'
  )

  if [[ -n "$tag" ]]; then
    printf '%s\n' "$tag"
    return 0
  fi

  return 1
}

export -f capture_command
export -f get_command
export -f get_github_latest_release_tag
