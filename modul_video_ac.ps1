# ============================================================
# EN – VİDEO AÇ (YouTube)
# ============================================================

try {
    $url = "https://youtu.be/SUMAJZwN86k?si=M9rb1LsL0lHFvzc1"
    Write-Host "EN: Video aciliyor: $url" -ForegroundColor Cyan
    Start-Process $url
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Video acildi: $url"
} catch {
    Write-Host "Video acma hatasi: $_" -ForegroundColor Red
}