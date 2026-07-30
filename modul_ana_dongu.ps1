# ============================================================
# EN – ANA DÖNGÜ (SON SÜRÜM – GELİŞMİŞ)
# ============================================================
# Bu modül, EN.bat'ın kalbidir.
# Tüm diğer modülleri yönetir, süreyi kontrol eder,
# sinir seviyesine göre davranışları belirler.
# ============================================================

. ./modul_ayar_oku.ps1
. ./modul_dil_destek.ps1

$log = "C:\EN_Log.txt"
Add-Content -Path $log -Value "[$(Get-Date)] ANA DONGU BASLATILDI"

Write-Host "[EN] Ana dongu baslatildi." -ForegroundColor Cyan

# ============================================================
# 1. MODÜL LİSTESİNİ OTAMATİK OLUŞTUR
# ============================================================
function Get-ModulListesi {
    $tumModuller = Get-ChildItem -Filter "modul_*.ps1" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }
    $aktifListe = @()
    $hepsi = @(
        "modul_chat.ps1",
        "modul_element_sorusu.ps1",
        "modul_mini_oyun.ps1",
        "modul_virus_sorusu.ps1",
        "modul_sistem_dosyasi_sorusu.ps1",
        "modul_video_ac.ps1",
        "modul_sacma_olay.ps1",
        "modul_rastgele_olay_seci.ps1",
        "modul_sistem_dosyasi_ye.ps1",
        "modul_sinir_sesi.ps1",
        "modul_tehdit_konusmasi.ps1",
        "modul_sahte_panel.ps1",
        "modul_kod_yukle.ps1",
        "modul_zero_day.ps1",
        "modul_gorsel_cokus.ps1"
    )
    foreach ($modul in $hepsi) {
        if ($tumModuller -contains $modul) {
            $aktifListe += $modul
        }
    }
    return $aktifListe
}

$modulListesi = Get-ModulListesi

# ============================================================
# 2. SÜRE KONTROLÜ
# ============================================================
if ($SURE -gt 0) {
    $baslangic = Get-Date
} else {
    $baslangic = $null
}

# ============================================================
# 3. ANA DÖNGÜ
# ============================================================
while ($true) {
    # Süre kontrolü
    if ($SURE -gt 0 -and $baslangic) {
        $simdi = Get-Date
        $fark = ($simdi - $baslangic).TotalSeconds
        if ($fark -ge $SURE) {
            Write-Host "[EN] Sure doldu. Son ekran baslatiliyor..." -ForegroundColor Yellow
            Add-Content -Path $log -Value "[$(Get-Date)] SURE DOLDU. SON EKRANA GECILIYOR."
            if (Test-Path "modul_son_ekran.ps1") {
                & ./modul_son_ekran.ps1
            }
            Add-Content -Path $log -Value "[$(Get-Date)] ANA DONGU KAPATILIYOR."
            exit 0
        }
    }

    # Kullanıcı girişi kontrolü (exit yazılırsa)
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.KeyChar -eq 'x' -or $key.KeyChar -eq 'X') {
            Write-Host "[EN] Kullanici tarafindan durduruldu." -ForegroundColor Yellow
            Add-Content -Path $log -Value "[$(Get-Date)] KULLANICI TARAFINDAN DURDURULDU."
            exit 0
        }
    }

    # Modül seçimi (sinir seviyesine göre)
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
            Write-Host "[EN] Aktif modul bulunamadi. Bekleniyor..." -ForegroundColor Yellow
            Start-Sleep -Seconds 10
            continue
        }

        # Sinir seviyesine göre ağırlıklı seçim
        $sinir = $script:sinir
        if ($sinir -ge 7) {
            # Çok sinirliyse sadece tehdit ve kaos modülleri
            $korkuncModuller = $aktifListe | Where-Object { $_ -match "tehdit|zero_day|gorsel_cokus|sistem_dosyasi_ye|bsod|panel" }
            if ($korkuncModuller.Count -gt 0) {
                $secili = $korkuncModuller | Get-Random
            } else {
                $secili = $aktifListe | Get-Random
            }
        } elseif ($sinir -ge 4) {
            # Orta sinir: tehdit + normal karışık
            $tehditModuller = $aktifListe | Where-Object { $_ -match "tehdit|zero_day|gorsel_cokus" }
            if ($tehditModuller.Count -gt 0 -and (Get-Random -Min 1 -Max 3) -eq 1) {
                $secili = $tehditModuller | Get-Random
            } else {
                $secili = $aktifListe | Get-Random
            }
        } else {
            # Normal mod
            $secili = $aktifListe | Get-Random
        }

        Write-Host "[EN] $secili calistiriliyor..." -ForegroundColor Yellow
        Add-Content -Path $log -Value "[$(Get-Date)] CALISTIRILIYOR: $secili"

        # Modülü çalıştır (hata durumunda logla)
        try {
            & $secili
        } catch {
            $hata = $_.Exception.Message
            Write-Host "[EN] Hata: $secili calistirilamadi. Hata: $hata" -ForegroundColor Red
            Add-Content -Path $log -Value "[$(Get-Date)] HATA: $secili -> $hata"
        }

        Start-Sleep -Seconds 3

    } catch {
        Write-Host "[EN] Ana dongu hatasi: $_" -ForegroundColor Red
        Add-Content -Path $log -Value "[$(Get-Date)] ANA DONGU HATASI: $_"
        Start-Sleep -Seconds 5
    }
}