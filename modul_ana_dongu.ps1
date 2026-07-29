# EN – ANA DONGU
# ============================================================
# Bu dosya tüm modülleri sırayla çağırır ve senaryoyu yönetir.

. ./modul_kufur_listesi.ps1
. ./modul_sinir_seviyesi.ps1
. ./modul_chat.ps1
. ./modul_kernel_ye.ps1
. ./modul_kaynak_doldur.ps1
. ./modul_video_ac.ps1
. ./modul_element_sorusu.ps1
. ./modul_mini_oyun.ps1
. ./modul_virus_sorusu.ps1
. ./modul_sistem_dosyasi_sorusu.ps1
. ./modul_kustum.ps1
. ./modul_kendi_tamir.ps1
. ./modul_dil_sec.ps1
. ./modul_mesaj.ps1
. ./modul_pislik_cezasi.ps1
. ./modul_log.ps1
. ./modul_vm_ayar_oyna.ps1
. ./modul_video_kapatma.ps1

Write-Host "EN: Ana dongu baslatildi. Tüm moduller hazir." -ForegroundColor Cyan

# Ana döngü – sürekli çalışır
while ($true) {
    # Rastgele bir modül seç ve çalıştır
    $modulListesi = @(
        "modul_chat.ps1",
        "modul_element_sorusu.ps1",
        "modul_mini_oyun.ps1",
        "modul_virus_sorusu.ps1",
        "modul_sistem_dosyasi_sorusu.ps1",
        "modul_video_ac.ps1"
    )
    $secili = $modulListesi | Get-Random
    Write-Host "EN: $secili calistiriliyor..." -ForegroundColor Yellow
    & $secili
    Start-Sleep -Seconds 2
}