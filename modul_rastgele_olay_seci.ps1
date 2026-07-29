# ============================================================
# EN – RASGELE OLAY SEÇİCİ
# ============================================================

$olaylar = @(
    "Ekran patladi!",
    "Ses geldi!",
    "Fare kayboldu!",
    "Klavye kilitlendi!",
    "Görev çubuğu gizlendi!",
    "Pembe ekran geldi!",
    "EN dans ediyor!",
    "Bilgisayar konusuyor!",
    "EN tuvalete gitti!",
    "Disk %100 doldu!",
    "RAM patladi!",
    "EN sizi seviyor!",
    "EN sinirlendi!",
    "EN mutlu!",
    "EN uyuyor!"
)

$seciliOlay = $olaylar | Get-Random
Write-Host "EN: $seciliOlay" -ForegroundColor Magenta

# Log kaydı
$log = "C:\EN_Log.txt"
Add-Content -Path $log -Value "[$(Get-Date)] Olay: $seciliOlay"