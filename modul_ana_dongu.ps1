# ============================================================
# EN – ANA DONGU (GÜNCELLENDİ)
# ============================================================

. ./modul_dil_destek.ps1

Write-Host "EN: Ana dongu baslatildi." -ForegroundColor Cyan

$modulListesi = @()

while ($true) {
    try {
        $modulListesi = @(
            "modul_chat.ps1",
            "modul_element_sorusu.ps1",
            "modul_mini_oyun.ps1",
            "modul_virus_sorusu.ps1",
            "modul_sistem_dosyasi_sorusu.ps1",
            "modul_video_ac.ps1",
            "modul_sacma_olay.ps1",
            "modul_rastgele_olay_seci.ps1",
            "modul_sistem_dosyasi_ye.ps1"
        ) | Where-Object { Test-Path $_ }

        if ($modulListesi.Count -eq 0) {
            Write-Host "EN: Modul bulunamadi. Bekleniyor..." -ForegroundColor Yellow
            Start-Sleep -Seconds 10
            continue
        }

        $secili = $modulListesi | Get-Random
        Write-Host "EN: $secili calistiriliyor..." -ForegroundColor Yellow
        & $secili
        Start-Sleep -Seconds 3
    } catch {
        Write-Host "Ana dongu hatasi: $_" -ForegroundColor Red
        Start-Sleep -Seconds 5
    }
}