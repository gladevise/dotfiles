pushd $PWD
cd `dirname $0`

EVAL_MISE='eval "$(~/.local/bin/mise activate bash)"'
grep "$EVAL_MISE" ~/.bashrc
if [ $? == 0 ]; then
  echo "mise installed successfully"
else
  echo "add eval mise command to ~/.bashrc"
  echo "$EVAL_MISE" >> ~/.bashrc
fi

EVAL_STARSHIP='eval "$(starship init bash)"'
grep "$EVAL_STARSHIP" ~/.bashrc
if [ $? == 0 ]; then
  echo "starship installed successfully"
else
  echo "add eval starship command to ~/.bashrc"
  echo "$EVAL_STARSHIP" >> ~/.bashrc
fi


popd