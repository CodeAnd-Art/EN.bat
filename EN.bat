@echo off
chcp 65001 >nul
title EN - Ultimate VM Simulator
color 0c
cls

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

:: Dil desteğini yükle
powershell -ExecutionPolicy Bypass -File modul_dil_destek.ps1

:: Ana dongu baslat
powershell -ExecutionPolicy Bypass -File modul_ana_dongu.ps1