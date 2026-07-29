@echo off
chcp 65001 >nul
title EN - Ultimate VM Simulator
color 0c
cls

:: ============================================================
:: YAPILANDIRMA DOSYASINDAN ŞİFREYİ OKU
:: ============================================================
if exist config.txt (
    for /f "tokens=1,2 delims==" %%a in (config.txt) do (
        if "%%a"=="SIFRE" set sifre=%%b
    )
)

:: ============================================================
:: ŞİFRE KONTROLÜ
:: ============================================================
if defined sifre if not "%sifre%"=="" (
    set /p girilen="🔐 EN.bat'ı çalıştırmak için şifreyi girin: "
    if not "%girilen%"=="%sifre%" (
        echo ❌ Yanlış şifre! Program kapatılıyor...
        timeout /t 2 /nobreak >nul
        exit
    )
    echo ✅ Şifre doğru! Başlatılıyor...
    timeout /t 1 /nobreak >nul
)

:: ============================================================
:: ANA MENÜ
:: ============================================================
echo ============================================================
echo   EN AKTIF
echo ============================================================
echo   Moduler yapi yukleniyor...
echo   Toplam 30+ modul hazirlaniyor.
echo ============================================================
echo.
echo   Devam etmek icin herhangi bir tusa basin...
pause >nul

:: Güvenlik duvarı kontrolü
powershell -ExecutionPolicy Bypass -File modul_guvenlik_duvari.ps1
if %errorlevel% neq 0 exit

:: Kendi kendini tamir
powershell -ExecutionPolicy Bypass -File modul_kendi_tamir.ps1

:: Yapılandırmayı oku
powershell -ExecutionPolicy Bypass -File modul_config_oku.ps1

:: Ana dongu baslat
powershell -ExecutionPolicy Bypass -File modul_ana_dongu.ps1