@echo off
setlocal
cd /d "%~dp0.."

if exist "scripts\eco-path.local.bat" call "scripts\eco-path.local.bat"
if "%ECO_CLIENT_PATH%"=="" (
  echo Set ECO_CLIENT_PATH in scripts\eco-path.local.bat
  echo Example: set "ECO_CLIENT_PATH=D:\Games\ECO"
  exit /b 1
)
if not exist "%ECO_CLIENT_PATH%\eco.exe" (
  echo eco.exe not found in %ECO_CLIENT_PATH%
  exit /b 1
)

echo Local start: %ECO_CLIENT_PATH%\eco.exe
echo server.lst must use 127.0.0.1 ^(not host.docker.internal^).
echo Ports: Login 17832, World 17831, Map 17833. Start World then Login then Map first.
echo Starting MySQL if Docker is up...
docker compose up -d mysql
cd /d "%ECO_CLIENT_PATH%"
start "" eco.exe
