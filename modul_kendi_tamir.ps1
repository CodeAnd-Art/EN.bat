# ============================================================
# EN – KENDİ KENDİNE TAMİR (GÜNCELLENDİ)
# ============================================================

$gerekliDosyalar = @(
    "EN.bat",
    "config.txt",
    "EN.png",
    "modul_ortam_tespit.ps1",
    "modul_guvenlik_duvari.ps1",
    "modul_sinir_seviyesi.ps1",
    "modul_sinir_sesi.ps1",
    "modul_chat.ps1",
    "modul_kernel_ye.ps1",
    "modul_kufur_listesi.ps1",
    "modul_ana_dongu.ps1",
    "modul_kaynak_doldur.ps1",
    "modul_uyari_ana_cihaz.ps1",
    "modul_vm_ayar_oyna.ps1",
    "modul_ekran_bozma.ps1",
    "modul_sistem_dosyasi_ye.ps1",
    "modul_mesaj_havuzu.ps1",
    "modul_rastgele_olay_seci.ps1",
    "modul_sacma_olay.ps1",
    "modul_yonetici_yetkisi.ps1",
    "modul_son_ekran.ps1",
    "modul_baslangic_ayarlari.ps1",
    "modul_element_sorusu.ps1",
    "modul_mini_oyun.ps1",
    "modul_virus_sorusu.ps1",
    "modul_sistem_dosyasi_sorusu.ps1",
    "modul_video_ac.ps1",
    "modul_video_kapatma.ps1",
    "modul_kustum.ps1",
    "modul_cok_agir_hakaret.ps1",
    "modul_dil_destek.ps1",
    "modul_log.ps1",
    "modul_pislik_cezasi.ps1",
    "modul_config_oku.ps1",
    "modul_ses.ps1"
)

$tamirLog = "C:\EN_Tamir_Log.txt"

try {
    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR BASLADI"

    foreach ($dosya in $gerekliDosyalar) {
        if (-not (Test-Path $dosya)) {
            Add-Content -Path $tamirLog -Value "[$(Get-Date)] EKSIK: $dosya"
            Write-Host "Eksik dosya tespit edildi: $dosya" -ForegroundColor Yellow
            try {
                New-Item -Path $dosya -ItemType File -Force -ErrorAction SilentlyContinue
                Add-Content -Path $dosya -Value "# Yedek dosya - Eksik olduğu için oluşturuldu" -ErrorAction SilentlyContinue
                Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR: $dosya olusturuldu."
            } catch {
                Add-Content -Path $tamirLog -Value "[$(Get-Date)] HATA: $dosya olusturulamadi."
            }
        } else {
            Write-Host "Dosya mevcut: $dosya" -ForegroundColor Green
        }
    }

    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR TAMAMLANDI"
    Write-Host "Kendi kendini tamir tamamlandi." -ForegroundColor Green
} catch {
    Write-Host "Tamir hatasi: $_" -ForegroundColor Red
}