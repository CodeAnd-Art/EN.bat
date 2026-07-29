# ============================================================
# EN – VİRÜS SORUSU (GUI Trojan C Seviyesi)
# ============================================================

try {
    Write-Host "EN: GUI Trojan C seviyesindeki virüsün adi nedir?" -ForegroundColor Yellow
    Write-Host "EN: Ipuclari: 2. Dunya Savasi'ndaki bir gaz, oksijen baglari, grafik arayuz." -ForegroundColor Cyan
    $cevap = Read-Host "Cevabiniz"

    if ($cevap -eq "Monoxide") {
        Write-Host "EN: Dogru! Monoxide.exe" -ForegroundColor Green
        $script:sinir = 0
    } else {
        Write-Host "EN: Yanlis! Dogru cevap: Monoxide" -ForegroundColor Red
        $script:sinir += 2
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Virus sorusu: $cevap"
} catch {
    Write-Host "Virus sorusu hatasi: $_" -ForegroundColor Red
}