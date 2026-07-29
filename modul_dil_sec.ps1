# ============================================================
# EN – DİL SEÇİMİ (SİSTEM DİLİNİ ALGILAR)
# ============================================================

try {
    $dil = (Get-WinSystemLocale).DisplayName
    Write-Host "EN: Sistem diliniz: $dil" -ForegroundColor Cyan
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Sistem dili: $dil"
} catch {
    Write-Host "Dil algilama hatasi: $_" -ForegroundColor Red
}