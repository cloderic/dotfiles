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
