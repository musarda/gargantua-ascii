@echo off
rem Opens the Gargantua animation in a small app window (settings: launch.ps1)
rem -ExecutionPolicy Bypass applies to this single script run only; it does not change system settings.
if not exist "%~dp0launch.ps1" (
  echo launch.ps1 not found.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0launch.ps1"
