## Here goes everything changing environment variables such as PATH or EDITOR

# custom commands
export EDITOR=nano
alias ls="exa -l"

# Homebrew sbin path
export PATH="/usr/local/sbin:$PATH"

# Homebrew JDK setup
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# cargo setup
export PATH="$HOME/.cargo/bin:$PATH"

# poetry setup
source $HOME/.poetry/env

# golang setup
export PATH="$(go env GOPATH)/bin:$PATH"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# gcloud setup
GOOGLE_CLOUD_SDK_DIR="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
source "${GOOGLE_CLOUD_SDK_DIR}/path.zsh.inc"
source "${GOOGLE_CLOUD_SDK_DIR}/completion.zsh.inc"
