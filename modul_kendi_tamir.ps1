# ============================================================
# EN – KENDİ KENDİNE TAMİR (SELF-HEALING)
# ============================================================

$gerekliDosyalar = @(
    "EN.bat",
    "modul_ortam_tespit.ps1",
    "modul_sinir_seviyesi.ps1",
    "modul_chat.ps1",
    "modul_kernel_ye.ps1",
    "modul_kufur_listesi.ps1",
    "modul_ana_dongu.ps1",
    "modul_kaynak_doldur.ps1",
    "modul_uyari_ana_cihaz.ps1",
    "modul_vm_ayar_oyna.ps1",
    "modul_guvenlik_duvari.ps1",
    "modul_ekran_bozma.ps1",
    "modul_sistem_dosyasi_ye.ps1",
    "modul_mesaj_havuzu.ps1",
    "modul_rastgele_olay_seci.ps1",
    "modul_sacma_olay.ps1",
    "modul_yonetici_yetkisi.ps1",
    "modul_son_ekran.ps1",
    "modul_baslangic_ayarlari.ps1"
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