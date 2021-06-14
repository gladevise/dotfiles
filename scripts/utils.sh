#!/bin/bash

capture_command()
{
  tee /tmp/capture.out
}
get_command()
{
  cat /tmp/capture.out
}

export -f capture_command
export -f get_command