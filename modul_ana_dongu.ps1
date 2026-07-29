# ============================================================
# EN – ANA DONGU (TUM MODULLERI YONETIR)
# ============================================================

Write-Host "EN: Ana dongu baslatildi. Tüm moduller hazir." -ForegroundColor Cyan

$modulListesi = @()

while ($true) {
    try {
        # Modül listesini tazele
        $modulListesi = @(
            "modul_chat.ps1",
            "modul_element_sorusu.ps1",
            "modul_mini_oyun.ps1",
            "modul_virus_sorusu.ps1",
            "modul_sistem_dosyasi_sorusu.ps1",
            "modul_video_ac.ps1"
        ) | Where-Object { Test-Path $_ }

        if ($modulListesi.Count -eq 0) {
            Write-Host "EN: Modul bulunamadi. Bekleniyor..." -ForegroundColor Yellow
            Start-Sleep -Seconds 10
            continue
        }

        $secili = $modulListesi | Get-Random
        Write-Host "EN: $secili calistiriliyor..." -ForegroundColor Yellow
        & $secili
        Start-Sleep -Seconds 2
    } catch {
        Write-Host "Ana dongu hatasi: $_" -ForegroundColor Red
        Start-Sleep -Seconds 5
    }
}