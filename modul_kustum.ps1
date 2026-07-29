# ============================================================
# EN – KÜSTÜM (EN.bat Silinmeye Çalışılırsa)
# ============================================================

. ./modul_dil_destek.ps1

try {
    Write-Host (Get-Mesaj "kustum") -ForegroundColor Red -BackgroundColor Black
    Write-Host (Get-Mesaj "kustum_detay") -ForegroundColor Yellow
    if (Test-Path "modul_kernel_ye.ps1") {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File modul_kernel_ye.ps1"
    }
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] EN.bat silinmeye calisildi. Kernel yendi."
} catch {
    Write-Host "Kustum modulu hatasi: $_" -ForegroundColor Red
}