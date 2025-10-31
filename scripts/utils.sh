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
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

export -f capture_command
export -f get_command
export -f get_github_latest_release_tag