# ============================================================
# EN – SİSTEM DOSYASI SORUSU
# ============================================================

try {
    Write-Host "EN: Sistem dosyasi vermek ister misin?" -ForegroundColor Yellow
    $cevap = Read-Host "Evet / Hayir"

    if ($cevap -eq "Evet") {
        Write-Host "EN: Sagol! Sansli oldun." -ForegroundColor Green
        $script:sinir = 0
    } elseif ($cevap -eq "Hayir") {
        Write-Host "EN: Sanssiz oldun! Sinirleniyorum..." -ForegroundColor Red
        $script:sinir += 2
    } else {
        Write-Host "EN: Anlamadim, sadece Evet veya Hayir de." -ForegroundColor Yellow
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Sistem dosyasi sorusu: $cevap"
} catch {
    Write-Host "Sistem dosyasi sorusu hatasi: $_" -ForegroundColor Red
}