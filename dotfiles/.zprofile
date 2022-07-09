## Here goes everything changing environment variables such as PATH or EDITOR

# Homebrew path setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# custom commands
export EDITOR=nano
alias ls="exa -l"

# Homebrew JDK setup
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# cargo setup
export PATH="$HOME/.cargo/bin:$PATH"

# pyenv shims
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path)"
fi

# poetry setup
export PATH="$HOME/.local/bin:$PATH"

# golang setup
if command -v go &>/dev/null; then
  export PATH="$(go env GOPATH)/bin:$PATH"
fi

# flutter setup
export PATH="$HOME/flutter/bin:$PATH"

# NVM setup
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm

# gcloud setup
GOOGLE_CLOUD_SDK_DIR="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [ -d "${GOOGLE_CLOUD_SDK_DIR}" ]; then
  source "${GOOGLE_CLOUD_SDK_DIR}/path.zsh.inc"
  source "${GOOGLE_CLOUD_SDK_DIR}/completion.zsh.inc"
fi

# Source tree setup
if [ -d "/Applications/SourceTree.app" ]; then
  alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
fi

# Visual studio code
if [ -d "/Applications/Visual Studio Code.app" ]; then
  alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
fi
