@echo off
title Cocos Local Server
color 0A
echo ========================================
echo     Starting Cocos Site Server
echo ========================================
echo.

:: Переходим в папку, где находится этот bat-файл
cd /d "%~dp0"
echo [OK] Текущая папка: %cd%
echo.

:: Проверка наличия Node.js
where node >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Node.js не найден. Установите Node.js с https://nodejs.org/
    pause
    exit /b
)

:: Проверка наличия http-server (если нет – установить)
where http-server >nul 2>nul
if errorlevel 1 (
    echo http-server не найден. Пытаюсь установить...
    call npm install -g http-server
    if errorlevel 1 (
        echo [ERROR] Не удалось установить http-server.
        echo Установите его вручную: npm install -g http-server
        pause
        exit /b
    ) else (
        echo [OK] http-server успешно установлен.
    )
)

:: Получение локального IP-адреса
echo Сервер будет доступен по адресам:
echo   http://localhost:8080
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    for %%b in (%%a) do (
        if not "%%b"=="" echo   http://%%b:8080
    )
)
echo.
echo Для остановки сервера нажмите Ctrl+C
echo.

:: Запуск сервера (с автоматическим открытием браузера)
http-server -o --host 0.0.0.0

:: Если сервер завершился (например, по Ctrl+C)
echo.
echo Сервер остановлен.
pause