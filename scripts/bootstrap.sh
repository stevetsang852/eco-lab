#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="${ROOT}/upstream"
mkdir -p "${DEST}"

clone_or_update() {
  local url="$1"
  local dir="$2"
  if [[ -d "${dir}/.git" ]]; then
    git -C "${dir}" fetch --depth 1 origin
    git -C "${dir}" pull --ff-only || true
  else
    git clone --depth 1 "${url}" "${dir}"
  fi
}

clone_or_update https://github.com/cm-MMK-2/EcoServerEmulator.git "${DEST}/core"
clone_or_update https://github.com/karorogunso/SagaECO.git "${DEST}/ref-saga"
clone_or_update https://github.com/tarathep/SagaECO.git "${DEST}/ref-docker"

echo "Cloned into ${DEST}"
echo "Remember: develop only in a fork of core. ref-* are libraries."
