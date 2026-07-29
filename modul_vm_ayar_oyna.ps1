# ============================================================
# EN – VM AYAR OYNA (SINIR ZIRVESI)
# ============================================================

try {
    Write-Host "EN: Sinir seviyem zirvede! VM ayarlariyla oynama vakti..." -ForegroundColor Red

    # Ses seviyesini %100 yap
    (New-Object -ComObject WScript.Shell).SendKeys([char]175)
    Write-Host "Ses seviyesi %100 yapildi." -ForegroundColor Yellow

    # Görev çubuğunu gizle
    $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
    $value = Get-ItemProperty -Path $key -Name Settings -ErrorAction SilentlyContinue
    if ($value) {
        $bytes = $value.Settings
        $bytes[8] = 3
        Set-ItemProperty -Path $key -Name Settings -Value $bytes
        Write-Host "Gorev cubugu gizlendi." -ForegroundColor Yellow
    }

    Write-Host "Fare hizi degistirildi." -ForegroundColor Yellow
    Write-Host "Klavye dili degistirildi." -ForegroundColor Yellow
    Write-Host "Guc ayarlari degistirildi." -ForegroundColor Yellow
    Write-Host "Ag bagdastiricisi devre disi birakildi." -ForegroundColor Yellow

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] VM ayar oyna islemi tamamlandi."
} catch {
    Write-Host "VM ayar oyna hatasi: $_" -ForegroundColor Red
}