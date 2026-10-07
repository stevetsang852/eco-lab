@echo off
setlocal
cd /d "%~dp0.."

if exist "scripts\eco-path.local.bat" (
  call "scripts\eco-path.local.bat"
)
if "%ECO_CLIENT_PATH%"=="" (
  echo Set ECO_CLIENT_PATH in scripts\eco-path.local.bat
  exit /b 1
)
if not exist "%ECO_CLIENT_PATH%\eco.exe" (
  echo eco.exe not found in %ECO_CLIENT_PATH%
  exit /b 1
)

echo Copying client into docker\client-lab\client-src ...
robocopy "%ECO_CLIENT_PATH%" "docker\client-lab\client-src" /E /NFL /NDL /NJH /NJS /nc /ns /np
if errorlevel 8 exit /b 1

set INSTALL_CLIENT=1
echo Building image with client copied in. Do not commit client-src.
docker compose -f docker-compose.client.yml build
if errorlevel 1 exit /b 1
echo noVNC: http://127.0.0.1:6080/vnc.html
docker compose -f docker-compose.client.yml up
