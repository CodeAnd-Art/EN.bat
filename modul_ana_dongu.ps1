# ============================================================
# EN – ANA DONGU (GÜNCELLENDİ)
# ============================================================

. ./modul_config_oku.ps1
. ./modul_dil_destek.ps1

Write-Host "EN: Ana dongu baslatildi." -ForegroundColor Cyan

$modulListesi = @()

if ($script:SURE -gt 0) {
    $baslangic = Get-Date
}

while ($true) {
    if ($script:SURE -gt 0) {
        $simdi = Get-Date
        $fark = ($simdi - $baslangic).TotalSeconds
        if ($fark -ge $script:SURE) {
            Write-Host "EN: Sure doldu. Simdi kapaniyorum..." -ForegroundColor Yellow
            exit
        }
    }

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
            "modul_sistem_dosyasi_ye.ps1",
            "modul_sinir_sesi.ps1"
        ) | Where-Object { Test-Path $_ }

        $aktifListe = @()
        foreach ($modul in $modulListesi) {
            if ($modul -match "mini_oyun" -and $script:OYUN_AKTIF -eq 0) { continue }
            if ($modul -match "video_ac" -and $script:VIDEO_AKTIF -eq 0) { continue }
            $aktifListe += $modul
        }

        if ($aktifListe.Count -eq 0) {
            Write-Host "EN: Aktif modul bulunamadi. Bekleniyor..." -ForegroundColor Yellow
            Start-Sleep -Seconds 10
            continue
        }

        $secili = $aktifListe | Get-Random
        Write-Host "EN: $secili calistiriliyor..." -ForegroundColor Yellow
        & $secili
        Start-Sleep -Seconds 3
    } catch {
        Write-Host "Ana dongu hatasi: $_" -ForegroundColor Red
        Start-Sleep -Seconds 5
    }
}