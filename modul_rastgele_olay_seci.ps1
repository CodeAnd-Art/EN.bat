# ============================================================
# EN – RASGELE OLAY SECICI
# ============================================================

$olaylar = @(
    "Ekran patladi!",
    "Ses geldi!",
    "Fare kayboldu!",
    "Klavye kilitlendi!",
    "Gorev cubugu gizlendi!",
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

try {
    $seciliOlay = $olaylar | Get-Random
    Write-Host "EN: $seciliOlay" -ForegroundColor Magenta
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Rasgele olay: $seciliOlay"
} catch {
    Write-Host "Rasgele olay hatasi: $_" -ForegroundColor Red
}