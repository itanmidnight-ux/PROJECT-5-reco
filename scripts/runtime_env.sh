#!/usr/bin/env bash
# Funciones compartidas por los entrypoints de instalación y ejecución.

load_dotenv_file() {
  local dotenv_file="${1:-.env}"
  [[ -f "${dotenv_file}" ]] || return 0
  set -a
  # shellcheck disable=SC1090
  source "${dotenv_file}"
  set +a
}

upsert_env_var() {
  local env_file="$1" key="$2" value="$3" tmp
  [[ "$key" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] || return 1
  tmp="$(mktemp "${env_file}.XXXXXX")"
  awk -v k="$key" -v v="$value" '
    BEGIN { updated=0 }
    $0 ~ ("^" k "=") { print k "=" v; updated=1; next }
    { print }
    END { if (!updated) print k "=" v }
  ' "$env_file" > "$tmp"
  chmod 600 "$tmp"
  mv -f "$tmp" "$env_file"
}
