@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

set "ADB=%~dp0platform-tools\adb.exe"
if not exist "%ADB%" (
  echo [Ошибка] Не найден platform-tools\adb.exe
  pause
  exit /b 1
)

"%ADB%" start-server >nul 2>&1
"%ADB%" devices | findstr /r "device$" >nul
if errorlevel 1 (
  echo [Ошибка] Устройство не найдено. Подключите телефон с отладкой USB.
  pause
  exit /b 1
)

echo Запускаю «Зеч-а бур-а удмурт кыл?»...
"%ADB%" shell am start -n com.example.app/.MainActivity
if errorlevel 1 (
  echo [Ошибка] Не удалось запустить. Сначала выполните установить.bat
  pause
  exit /b 1
)

echo Готово.
pause
