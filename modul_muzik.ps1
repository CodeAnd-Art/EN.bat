# ============================================================
# EN – MÜZİK ÇALAR (v3.0 – OPSİYONEL)
# ============================================================
# config.txt'den MUZIK_DOSYASI okur, dosya varsa çalar, yoksa sessiz.
# ============================================================

$config = Get-Content "config.txt" -Encoding UTF8
$muzikDosyasi = ""
$muzikSeviyesi = 70
$muzikDongu = 1

foreach ($satir in $config) {
    if ($satir -match "^MUZIK_DOSYASI=") {
        $muzikDosyasi = ($satir -split "=", 2)[1].Trim()
    }
    if ($satir -match "^MUZIK_SEVIYESI=") {
        $muzikSeviyesi = [int](($satir -split "=", 2)[1].Trim())
    }
    if ($satir -match "^MUZIK_DONGU=") {
        $muzikDongu = [int](($satir -split "=", 2)[1].Trim())
    }
}

$log = "C:\EN_Log.txt"

try {
    if ($muzikDosyasi -ne "" -and (Test-Path $muzikDosyasi)) {
        Add-Type -AssemblyName System.Windows.Forms
        $player = New-Object -ComObject WMPlayer.OCX
        $player.settings.volume = $muzikSeviyesi
        if ($muzikDongu -eq 1) {
            $player.settings.setMode("loop", $true)
        }
        $player.URL = ".\$muzikDosyasi"
        $player.controls.play()

        Write-Host "[EN] Muzik baslatildi: $muzikDosyasi (Seviye: $muzikSeviyesi)" -ForegroundColor Green
        Add-Content -Path $log -Value "[$(Get-Date)] MUZIK BASLATILDI: $muzikDosyasi"
        while ($true) { Start-Sleep -Seconds 10 }
    } else {
        Write-Host "[EN] Muzik dosyasi bulunamadi: $muzikDosyasi - Sessiz mod." -ForegroundColor Yellow
        Add-Content -Path $log -Value "[$(Get-Date)] MUZIK DOSYASI BULUNAMADI: $muzikDosyasi"
        while ($true) { Start-Sleep -Seconds 10 }
    }
} catch {
    Write-Host "[EN] Muzik hatasi: $_" -ForegroundColor Red
    Add-Content -Path $log -Value "[$(Get-Date)] MUZIK HATASI: $_"
    while ($true) { Start-Sleep -Seconds 10 }
}