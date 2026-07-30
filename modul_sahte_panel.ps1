# ============================================================
# EN – ZERO-CLICK PANELİ + KOD YÜKLEME
# ============================================================

try {
    Write-Host "[EN] Zero-click exploit paneli açılıyor..." -ForegroundColor Red
    Start-Sleep -Seconds 1

    # Sahte kod yükleme animasyonu
    for ($i=0; $i -lt 20; $i++) {
        $rnd = Get-Random -Min 1000 -Max 9999
        Write-Host "[EN] Kod yükleniyor: 0x$rnd - %$((($i+1)*5))" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 150
    }

    Write-Host "[EN] Zero-day exploit başarıyla yüklendi." -ForegroundColor Red
    Write-Host "[EN] Sistem çöküşü başlatılıyor..." -ForegroundColor Red

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Zero-click paneli açıldı."

    # Panel kapatılırsa ne olacağını sinir seviyesine bildir
    $script:panel_kapandi = $false
} catch {
    Write-Host "[EN] Panel hatası: $_" -ForegroundColor Red
}