@echo off
cd /d "%~dp0"
start /b powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "setup-workspace.ps1"
