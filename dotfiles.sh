#!/usr/bin/env bash
CFG_SOURCE_DIR="$(dirname "${BASH_SOURCE[0]}")/dotfiles"
CFG_INSTALL_DIR="$(cd ~ && pwd)"
CFG_BACKUP_DIR=${CFG_SOURCE_DIR}/backup

CFG_FILES=(
  ".config/starship.toml"
  ".ssh/config"
  ".gitconfig"
  ".gitignore_global"
  ".nanorc"
  ".zprofile"
  ".zshrc"
)

SETUP_DIR="$(dirname "${BASH_SOURCE[0]}")/setups"
SETUP_SCRIPTS=(
  "setup-macos.sh"
)

function usage() {
  local usage_str=""
  usage_str+="Manage dotfiles in \`${CFG_INSTALL_DIR}\`\n\n"
  usage_str+="Usage:\n"
  usage_str+="  $(basename "${BASH_SOURCE[0]}") setup\n"
  usage_str+="    Execute setup scripts.\n\n"
  usage_str+="  $(basename "${BASH_SOURCE[0]}") install_configs\n"
  usage_str+="    Install the configuration dotfiles (backuping the previous ones in \`${CFG_BACKUP_DIR}\`).\n\n"
  usage_str+="  $(basename "${BASH_SOURCE[0]}") retrieve_configs\n"
  usage_str+="    Retrieve the currently installed configuration dotfiles.\n\n"
  usage_str+="Options:\n"
  usage_str+="  -h, --help:                             Show this screen.\n"
  printf "%b" "${usage_str}"
}

set -o errexit

while [[ "$1" != "" ]]; do
  case $1 in
    install_configs | setup | retrieve_configs)
      if [[ -z "${command}" ]]; then
        command="$1"
      else
        printf "only one command can be provided.\n\n"
        usage
        exit 1
      fi
      ;;
    --help | -h)
      usage
      exit 0
      ;;
    *)
      printf "%s: unrecognized argument.\n\n" "$1"
      usage
      exit 1
      ;;
  esac
  shift
done

if [[ -z "${command}" ]]; then
  printf "one command must be provided.\n\n"
  usage
  exit 1
fi

case ${command} in
  install_configs)
    for cfg_file in "${CFG_FILES[@]}"; do
      source_file="${CFG_SOURCE_DIR}/${cfg_file}"
      installed_file="${CFG_INSTALL_DIR}/${cfg_file}"
      backuped_file="${CFG_BACKUP_DIR}/${cfg_file}"
      if [[ -f "${installed_file}" ]]; then
        mkdir -p "$(dirname "${backuped_file}")"
        cp "${installed_file}" "${backuped_file}"
      else
        mkdir -p "$(dirname "${backuped_file}")"
        touch "${backuped_file}"
        mkdir -p "$(dirname ${installed_file})"
      fi
      if [[ -f "${source_file}" ]]; then
        cp "${source_file}" "${installed_file}"
        printf "✅ \`%s\` installed from \`%s\`\n" "${installed_file}" "${source_file}"
      else
        printf "⚠️ Skipping installation of \`%s\`: No matching source file at \`%s\`\n" "${cfg_file}" "${source_file}"
      fi
    done
    ;;
  retrieve_configs)
    for cfg_file in "${CFG_FILES[@]}"; do
      source_file="${CFG_SOURCE_DIR}/${cfg_file}"
      installed_file="${CFG_INSTALL_DIR}/${cfg_file}"
      if [[ -f "${installed_file}" ]]; then
        mkdir -p "$(dirname "${source_file}")"
        cp "${installed_file}" "${source_file}"
        printf "✅ \`%s\` retrieved from \`%s\`\n" "${source_file}" "${installed_file}"
      else
        printf "⚠️ Skipping retrieval of \`%s\`: No matching installed file at \`%s\`\n" "${cfg_file}" "${installed_file}"
      fi
    done
    ;;
  setup)
    for setup_script in "${SETUP_SCRIPTS[@]}"; do
      setup_script_path="${SETUP_DIR}/${setup_script}"
      if ${setup_script_path}; then
        printf "✅ \`%s\` successfully ran\n" "${setup_script_path}"
      else
        printf "❌ Error while running \`%s\`\n" "${setup_script_path}"
      fi
    done
    ;;
esac
