# ============================================================
# EN – BAŞLANGIÇ AYARLARI (HER BAŞLATMADA RASGELE)
# ============================================================

try {
    if (Test-Path "modul_mesaj_havuzu.ps1") {
        . ./modul_mesaj_havuzu.ps1
        $rastgeleMesaj = RastgeleMesaj
        Write-Host "EN: $rastgeleMesaj" -ForegroundColor Cyan
    }

    $olayListesi = @(
        "modul_sacma_olay.ps1",
        "modul_gizli_mesaj.ps1",
        "modul_rastgele_olay_seci.ps1"
    ) | Where-Object { Test-Path $_ }

    if ($olayListesi.Count -gt 0) {
        $seciliOlay = $olayListesi | Get-Random
        Write-Host "EN: $seciliOlay secildi." -ForegroundColor Yellow
        & $seciliOlay
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Baslangic ayarlari tamamlandi."
} catch {
    Write-Host "Baslangic ayarlari hatasi: $_" -ForegroundColor Red
}