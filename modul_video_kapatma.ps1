# ============================================================
# EN – VİDEO KAPATILIRSA TEPKİ
# ============================================================

try {
    Write-Host "EN: Videoyu kapattin mi? Sinirleniyorum..." -ForegroundColor Red
    $script:sinir += 2
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Video kapatildi. Sinir artti."
} catch {
    Write-Host "Video kapatma hatasi: $_" -ForegroundColor Red
}