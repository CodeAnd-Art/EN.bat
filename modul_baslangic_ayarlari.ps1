# ============================================================
# EN – BAŞLANGIÇ AYARLARI (HER BAŞLATMADA RASGELE)
# ============================================================

. ./modul_mesaj_havuzu.ps1

$rastgeleMesaj = RastgeleMesaj
Write-Host "EN: $rastgeleMesaj" -ForegroundColor Cyan

# Rastgele bir olay seç
$olayListesi = @(
    "modul_sacma_olay.ps1",
    "modul_gizli_mesaj.ps1",
    "modul_rastgele_olay_seci.ps1"
)
$seciliOlay = $olayListesi | Get-Random
Write-Host "EN: $seciliOlay secildi." -ForegroundColor Yellow

# Log kaydı
$log = "C:\EN_Log.txt"
Add-Content -Path $log -Value "[$(Get-Date)] Baslangic mesaji: $rastgeleMesaj"