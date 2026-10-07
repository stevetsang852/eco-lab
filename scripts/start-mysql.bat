@echo off
cd /d "%~dp0.."
echo MySQL only. Import Emulator sql/eco.sql yourself. No game client in this container.
docker compose up -d mysql
