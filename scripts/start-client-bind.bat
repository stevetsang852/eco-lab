@echo off
setlocal
cd /d "%~dp0.."

if exist "scripts\eco-path.local.bat" (
  call "scripts\eco-path.local.bat"
)
if "%ECO_CLIENT_PATH%"=="" (
  echo Set ECO_CLIENT_PATH in scripts\eco-path.local.bat
  echo Example: set "ECO_CLIENT_PATH=D:\Games\ECO"
  exit /b 1
)
if not exist "%ECO_CLIENT_PATH%\eco.exe" (
  echo eco.exe not found in %ECO_CLIENT_PATH%
  exit /b 1
)

echo Bind mount: %ECO_CLIENT_PATH%
echo noVNC: http://127.0.0.1:6080/vnc.html
echo server.lst must use host.docker.internal, not 127.0.0.1
docker compose -f docker-compose.client.yml up --build
