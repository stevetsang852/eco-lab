#!/bin/sh
set -eu

pick_root() {
  if [ -f "${ECO_ROOT}/${ECO_EXE}" ]; then
    echo "${ECO_ROOT}"
    return
  fi
  if [ -f "/opt/eco-baked/${ECO_EXE}" ]; then
    echo "/opt/eco-baked"
    return
  fi
  echo ""
}

ROOT="$(pick_root || true)"

Xvfb "${DISPLAY}" -screen 0 "${SCREEN}" >/tmp/xvfb.log 2>&1 &
sleep 0.5
fluxbox >/tmp/fluxbox.log 2>&1 &
x11vnc -display "${DISPLAY}" -nopw -forever -shared -rfbport "${VNC_PORT}" >/tmp/x11vnc.log 2>&1 &
websockify --web /usr/share/novnc "${NOVNC_PORT}" "localhost:${VNC_PORT}" >/tmp/novnc.log 2>&1 &

echo "noVNC: http://127.0.0.1:${NOVNC_PORT}/vnc.html"

if [ -z "${ROOT}" ]; then
  echo "No ${ECO_EXE} found."
  echo "Option A: bind-mount your client onto ${ECO_ROOT} (compose ECO_CLIENT_PATH)."
  echo "Option B: put eco.exe in docker/client-lab/client-src and rebuild with INSTALL_CLIENT=1."
  echo "Desktop stays up so you can confirm VNC."
  tail -f /tmp/xvfb.log
fi

echo "Launching ${ROOT}/${ECO_EXE}"
cd "${ROOT}"
exec wine "${ECO_EXE}"
