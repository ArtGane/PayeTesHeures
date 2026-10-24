@echo off
setlocal
cd /d "%~dp0"
echo ==============================================
echo   PayeTesheures - Preparer Gradle 8.9
 echo ==============================================
where powershell.exe >nul 2>&1
if errorlevel 1 (
  echo ERREUR : PowerShell est introuvable.
  pause
  exit /b 1
)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0PREPARER-WINDOWS.ps1"
if errorlevel 1 (
  echo.
  echo Preparation en echec. Veuillez noter le message ci-dessus.
  pause
  exit /b 1
)
echo.
echo Ouvrez maintenant ce dossier dans Android Studio.
pause
