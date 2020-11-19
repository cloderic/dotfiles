# Automatically run `nvm use` if a .nvmrc is detected.

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# starship prompt setup
eval "$(starship init zsh)"
function set_win_title() {
  echo -ne "\033]0; $(basename $PWD) \007"
}
starship_precmd_user_func="set_win_title"

# setup completion
autoload -U compinit
compinit
