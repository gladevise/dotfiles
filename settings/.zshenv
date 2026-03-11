# ~/.zshenv: sourced by ALL zsh invocations before any other user rc file.
# Keep this minimal — it runs for every zsh process including scripts.

# Deduplicate PATH entries
typeset -U path PATH

# Add mise shims for shells where `mise activate` (in .zshrc) may not
# take effect. In interactive shells, `mise activate` prepends actual
# tool paths which take precedence over shims.
if [[ -d "$HOME/.local/share/mise/shims" ]]; then
  path=("$HOME/.local/share/mise/shims" $path)
fi
