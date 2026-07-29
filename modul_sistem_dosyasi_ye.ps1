# ============================================================
# EN – SISTEM DOSYASI YE (RASTGELE)
# ============================================================

try {
    Write-Host "EN: Sistem dosyalarini yemeye basliyorum..." -ForegroundColor Red

    $sistemDosyalari = @(
        "C:\Windows\System32\calc.exe",
        "C:\Windows\System32\notepad.exe",
        "C:\Windows\System32\mspaint.exe",
        "C:\Windows\System32\write.exe",
        "C:\Windows\System32\sndvol.exe",
        "C:\Windows\System32\osk.exe",
        "C:\Windows\System32\magnify.exe",
        "C:\Windows\System32\utilman.exe",
        "C:\Windows\System32\charmap.exe",
        "C:\Windows\System32\cleanmgr.exe",
        "C:\Windows\System32\dfrgui.exe",
        "C:\Windows\System32\diskmgmt.msc",
        "C:\Windows\System32\devmgmt.msc",
        "C:\Windows\System32\services.msc",
        "C:\Windows\System32\taskmgr.exe"
    )

    $seciliDosyalar = $sistemDosyalari | Get-Random -Count (Get-Random -Min 3 -Max 6)

    foreach ($dosya in $seciliDosyalar) {
        if (Test-Path $dosya) {
            Write-Host "EN: $dosya yendi!" -ForegroundColor Red
            Start-Sleep -Milliseconds 300
        } else {
            Write-Host "EN: $dosya zaten yoktu, ama yine de yedim!" -ForegroundColor Yellow
        }
    }

    Write-Host "EN: Sistem dosyalarindan bir kismini yedim." -ForegroundColor Red
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Sistem dosyasi yeme islemi tamamlandi."
} catch {
    Write-Host "Sistem dosyasi yeme hatasi: $_" -ForegroundColor Red
}