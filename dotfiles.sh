#!/usr/bin/env bash
SOURCE_DIR=$(dirname "${BASH_SOURCE[0]}")
INSTALL_DIR="~"
BACKUP_DIR=${SOURCE_DIR}/backup

CFG_FILES=(
  ".zprofile"
  ".zshrc"
  ".config/starship.toml"
  ".gitconfig"
  ".nanorc"
)

function usage() {
  local usage_str=""
  usage_str+="Manage dotfiles in \`${INSTALL_DIR}\`\n\n"
  usage_str+="Usage:\n"
  usage_str+="  $(basename "${BASH_SOURCE[0]}") install\n"
  usage_str+="    Install the configuration files (backuping the previous ones in \`${BACKUP_DIR}\`).\n\n"
  usage_str+="  $(basename "${BASH_SOURCE[0]}") retrieve\n"
  usage_str+="    Retrieve the current configuration.\n\n"
  usage_str+="Options:\n"
  usage_str+="  -h, --help:                             Show this screen.\n"
  printf "%b" "${usage_str}"
}

set -o errexit

while [[ "$1" != "" ]]; do
  case $1 in
    install)
      if [[ -z "${do_retrieve}" ]]; then
        do_install=1
      else
        printf "only one command amongst 'retrieve' and 'install' can be provided.\n\n"
        usage
        exit 1
      fi
      ;;
    retrieve)
      if [[ -z "${do_install}" ]]; then
        do_retrieve=1
      else
        printf "only one command amongst 'retrieve' and 'install' can be provided.\n\n"
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

if [[ -z "${do_retrieve}" && -z "${do_install}" ]]; then
  printf "one command amongst 'retrieve' and 'install' must be provided.\n\n"
  usage
  exit 1
fi

for cfg_file in "${CFG_FILES[@]}"; do
  source_file="${SOURCE_DIR}/${cfg_file}"
  installed_file="${INSTALL_DIR}/${cfg_file}"
  if [[ "${do_install}" == 1 ]]; then
    # Installing the source file
    backuped_file="${BACKUP_DIR}/${cfg_file}"
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
  else
    # Retrieving the config file
    if [[ -f "${installed_file}" ]]; then
      mkdir -p "$(dirname "${installed_file}")"
      cp "${installed_file}" "${source_file}"
      printf "✅ \`%s\` retrieved from \`%s\`\n" "${source_file}" "${installed_file}"
    else
      printf "⚠️ Skipping retrieval of \`%s\`: No matching installed file at \`%s\`\n" "${cfg_file}" "${installed_file}"
    fi
  fi
done
