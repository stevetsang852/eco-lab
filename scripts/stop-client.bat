@echo off
cd /d "%~dp0.."
docker compose -f docker-compose.client.yml down
