# ============================================================
# EN – ANA DÖNGÜ (v3.0 – ULTİMATE)
# ============================================================
# Tüm modülleri yönetir, süreyi kontrol eder, sinir seviyesine
# göre davranışları belirler, son ekranı çağırır.
# ============================================================

. ./modul_ayar_oku.ps1
. ./modul_dil_destek.ps1

$log = "C:\EN_Log.txt"
Add-Content -Path $log -Value "[$(Get-Date)] ANA DONGU BASLATILDI"
Write-Host "[EN] Ana dongu baslatildi." -ForegroundColor Cyan

function Get-ModulListesi {
    $tumModuller = Get-ChildItem -Filter "modul_*.ps1" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }
    $hepsi = @(
        "modul_chat.ps1","modul_element_sorusu.ps1","modul_mini_oyun.ps1",
        "modul_virus_sorusu.ps1","modul_sistem_dosyasi_sorusu.ps1","modul_video_ac.ps1",
        "modul_sacma_olay.ps1","modul_rastgele_olay_seci.ps1","modul_sistem_dosyasi_ye.ps1",
        "modul_sinir_sesi.ps1","modul_tehdit_konusmasi.ps1","modul_sahte_panel.ps1",
        "modul_kod_yukle.ps1","modul_zero_day.ps1","modul_gorsel_cokus.ps1"
    )
    $aktif = @()
    foreach ($modul in $hepsi) {
        if ($tumModuller -contains $modul) { $aktif += $modul }
    }
    return $aktif
}

$modulListesi = Get-ModulListesi
if ($SURE -gt 0) { $baslangic = Get-Date } else { $baslangic = $null }

while ($true) {
    if ($SURE -gt 0 -and $baslangic) {
        $simdi = Get-Date
        $fark = ($simdi - $baslangic).TotalSeconds
        if ($fark -ge $SURE) {
            Write-Host "[EN] Sure doldu. Son ekran baslatiliyor..." -ForegroundColor Yellow
            Add-Content -Path $log -Value "[$(Get-Date)] SURE DOLDU."
            if (Test-Path "modul_son_ekran.ps1") { & ./modul_son_ekran.ps1 }
            Add-Content -Path $log -Value "[$(Get-Date)] ANA DONGU KAPATILIYOR."
            exit 0
        }
    }

    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.KeyChar -eq 'x' -or $key.KeyChar -eq 'X') {
            Write-Host "[EN] Kullanici tarafindan durduruldu." -ForegroundColor Yellow
            Add-Content -Path $log -Value "[$(Get-Date)] KULLANICI DURDURDU."
            exit 0
        }
    }

    try {
        $aktifListe = @()
        foreach ($modul in $modulListesi) {
            if ($modul -match "mini_oyun" -and $OYUN_AKTIF -eq 0) { continue }
            if ($modul -match "video_ac" -and $VIDEO_AKTIF -eq 0) { continue }
            if ($modul -match "tehdit" -and $TEHDIT_AKTIF -eq 0) { continue }
            if ($modul -match "zero_day" -and $ZERO_DAY_AKTIF -eq 0) { continue }
            if ($modul -match "gorsel_cokus" -and $GORSEL_COKUS_AKTIF -eq 0) { continue }
            $aktifListe += $modul
        }

        if ($aktifListe.Count -eq 0) {
            Write-Host "[EN] Aktif modul yok. Bekleniyor..." -ForegroundColor Yellow
            Start-Sleep -Seconds 10
            continue
        }

        $sinir = $script:sinir
        if ($sinir -ge 7) {
            $korkunc = $aktifListe | Where-Object { $_ -match "tehdit|zero_day|gorsel_cokus|sistem_dosyasi_ye|bsod|panel" }
            $secili = if ($korkunc.Count -gt 0) { $korkunc | Get-Random } else { $aktifListe | Get-Random }
        } elseif ($sinir -ge 4) {
            $tehdit = $aktifListe | Where-Object { $_ -match "tehdit|zero_day|gorsel_cokus" }
            $secili = if ($tehdit.Count -gt 0 -and (Get-Random -Min 1 -Max 3) -eq 1) { $tehdit | Get-Random } else { $aktifListe | Get-Random }
        } else {
            $secili = $aktifListe | Get-Random
        }

        Write-Host "[EN] $secili calistiriliyor..." -ForegroundColor Yellow
        Add-Content -Path $log -Value "[$(Get-Date)] CALISTIRILIYOR: $secili"
        try {
            & $secili
        } catch {
            $hata = $_.Exception.Message
            Write-Host "[EN] Hata: $secili -> $hata" -ForegroundColor Red
            Add-Content -Path $log -Value "[$(Get-Date)] HATA: $secili -> $hata"
        }
        Start-Sleep -Seconds 3
    } catch {
        Write-Host "[EN] Ana dongu hatasi: $_" -ForegroundColor Red
        Add-Content -Path $log -Value "[$(Get-Date)] ANA DONGU HATASI: $_"
        Start-Sleep -Seconds 5
    }
}