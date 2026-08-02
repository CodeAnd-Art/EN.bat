# ============================================================
# EN – KENDİ KENDİNE TAMİR (v3.0)
# ============================================================
# request.txt dosyasındaki FILES listesini okur,
# eksik dosyaları tespit eder ve oluşturur.
# ============================================================

$requestDosyasi = "request.txt"
$tamirLog = "C:\EN_Tamir_Log.txt"

function Get-RequiredFiles {
    $dosyaListesi = @()
    if (Test-Path $requestDosyasi) {
        try {
            $satirlar = Get-Content $requestDosyasi -Encoding UTF8
            foreach ($satir in $satirlar) {
                if ($satir -match "^FILES=") {
                    $list = ($satir -split "=", 2)[1].Trim()
                    $dosyaListesi = $list -split ","
                    break
                }
            }
        } catch {
            Write-Host "[EN] request.txt okuma hatasi: $_" -ForegroundColor Red
        }
    }

    if ($dosyaListesi.Count -eq 0) {
        $dosyaListesi = @(
            "EN.bat","config.txt","EN.png","modul_guvenlik_duvari.ps1",
            "modul_ayar_oku.ps1","modul_kernel_ye.ps1","modul_sistem_dosyasi_ye.ps1",
            "modul_kaynak_doldur.ps1","modul_dosya_gizle.ps1","modul_sinir_seviyesi.ps1",
            "modul_sinir_sesi.ps1","modul_ekran_bozma.ps1","modul_ses.ps1",
            "modul_tehdit_eylem.ps1","modul_tehdit_konusmasi.ps1","modul_sahte_panel.ps1",
            "modul_kod_yukle.ps1","modul_gorsel_cokus.ps1","modul_bsod_tetikle.ps1",
            "modul_chat.ps1","modul_kufur_listesi.ps1","modul_ana_dongu.ps1",
            "modul_vm_ayar_oyna.ps1","modul_element_sorusu.ps1","modul_mini_oyun.ps1",
            "modul_virus_sorusu.ps1","modul_sistem_dosyasi_sorusu.ps1","modul_video_ac.ps1",
            "modul_video_kapatma.ps1","modul_kustum.ps1","modul_cok_agir_hakaret.ps1",
            "modul_pislik_cezasi.ps1","modul_son_ekran.ps1","modul_baslangic_ayarlari.ps1",
            "modul_mesaj_havuzu.ps1","modul_rastgele_olay_seci.ps1","modul_sacma_olay.ps1",
            "modul_yonetici_yetkisi.ps1","modul_log.ps1","modul_dil_destek.ps1",
            "modul_kutuphane_kontrol.ps1","modul_muzik.ps1"
        )
    }
    return $dosyaListesi
}

try {
    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR BASLADI"
    $gerekliDosyalar = Get-RequiredFiles
    $eksik = 0
    $tamirEdilen = 0

    foreach ($dosya in $gerekliDosyalar) {
        if (-not (Test-Path $dosya)) {
            $eksik++
            Write-Host "[EN] Eksik dosya: $dosya" -ForegroundColor Yellow
            Add-Content -Path $tamirLog -Value "[$(Get-Date)] EKSIK: $dosya"
            try {
                New-Item -Path $dosya -ItemType File -Force -ErrorAction SilentlyContinue
                Add-Content -Path $dosya -Value "# Yedek dosya - Otomatik olusturuldu" -ErrorAction SilentlyContinue
                $tamirEdilen++
                Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR: $dosya olusturuldu."
            } catch {
                Add-Content -Path $tamirLog -Value "[$(Get-Date)] HATA: $dosya olusturulamadi."
            }
        }
    }

    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR TAMAMLANDI. Eksik: $eksik, Tamir Edilen: $tamirEdilen"
    Write-Host "[EN] Kendi kendini tamir tamamlandi. Eksik: $eksik, Tamir: $tamirEdilen" -ForegroundColor Green
} catch {
    Write-Host "[EN] Tamir hatasi: $_" -ForegroundColor Red
    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR HATASI: $_"
}