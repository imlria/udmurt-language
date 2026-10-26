@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

set "ADB=%~dp0platform-tools\adb.exe"
if not exist "%ADB%" (
  echo [Ошибка] Не найден platform-tools\adb.exe рядом с этим файлом.
  pause
  exit /b 1
)

set "APK=%~dp0Zech-a-bur-a-udmurt-kyl.apk"
if not exist "%APK%" (
  echo [Ошибка] Не найден файл Zech-a-bur-a-udmurt-kyl.apk
  pause
  exit /b 1
)

echo Проверяю подключённые устройства...
"%ADB%" start-server >nul 2>&1
"%ADB%" devices
echo.

"%ADB%" devices | findstr /r "device$" >nul
if errorlevel 1 (
  echo [Ошибка] Android-устройство не найдено.
  echo Включите «Отладка по USB», подключите кабель и подтвердите запрос на телефоне.
  echo Подробнее — в файле КАК_УСТАНОВИТЬ.txt
  pause
  exit /b 1
)

echo Устанавливаю приложение...
"%ADB%" install -r "%APK%"
if errorlevel 1 (
  echo.
  echo [Ошибка] Установка не удалась.
  pause
  exit /b 1
)

echo.
echo Готово. Можно нажать запустить.bat или открыть приложение на телефоне.
pause
