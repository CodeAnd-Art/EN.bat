# ============================================================
# EN – KENDİ KENDİNE TAMİR (SELF-HEALING)
# ============================================================

$gerekliDosyalar = @(
    "EN.bat",
    "modul_ortam_tespit.ps1",
    "modul_sinir_seviyesi.ps1",
    "modul_chat.ps1",
    "modul_kernel_ye.ps1",
    "modul_kaynak_doldur.ps1",
    "modul_kufur_listesi.ps1",
    "modul_uyari_ana_cihaz.ps1",
    "modul_vm_ayar_oyna.ps1",
    "modul_video_ac.ps1",
    "modul_video_kapatma.ps1",
    "modul_element_sorusu.ps1",
    "modul_mini_oyun.ps1",
    "modul_virus_sorusu.ps1",
    "modul_sistem_dosyasi_sorusu.ps1",
    "modul_kustum.ps1",
    "modul_dil_sec.ps1",
    "modul_mesaj.ps1",
    "modul_pislik_cezasi.ps1",
    "modul_log.ps1",
    "modul_ana_dongu.ps1",
    "modul_guvenlik_duvari.ps1",
    "EN.png"
)

$tamirLog = "C:\EN_Tamir_Log.txt"
Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR BASLADI"

foreach ($dosya in $gerekliDosyalar) {
    if (-not (Test-Path $dosya)) {
        Add-Content -Path $tamirLog -Value "[$(Get-Date)] EKSIK: $dosya"
        Write-Host "Eksik dosya tespit edildi: $dosya" -ForegroundColor Yellow

        # Eğer dosya eksikse, boş bir dosya oluştur (yer tutucu)
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