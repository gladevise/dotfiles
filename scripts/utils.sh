#!/bin/bash

capture_command()
{
  tee /tmp/capture.out
}
get_command()
{
  cat /tmp/capture.out
}

get_github_latest_release_tag(){
  curl --silent "https://github.com/$1/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#'
}

export -f capture_command
export -f get_command
export -f get_github_latest_release_tag