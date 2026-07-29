# ============================================================
# EN – KÜSTÜM (EN.bat Silinmeye Çalışılırsa)
# ============================================================

try {
    Write-Host "EN: EN.bat'i silmeye mi calisiyorsun?" -ForegroundColor Red
    Write-Host "EN: Kustum! Kernel yiyorsun!" -ForegroundColor Red -BackgroundColor Black
    if (Test-Path "modul_kernel_ye.ps1") {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File modul_kernel_ye.ps1"
    }
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] EN.bat silinmeye calisildi. Kernel yendi."
} catch {
    Write-Host "Kustum modulu hatasi: $_" -ForegroundColor Red
}