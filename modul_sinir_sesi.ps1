# ============================================================
# EN – SİNİR SESİ PATLAMASI
# ============================================================

try {
    Write-Host "EN: Sinirlendim! Ses patlaması..." -ForegroundColor Red

    # 3 saniye boyunca rahatsız edici sesler
    for ($i=0; $i -lt 30; $i++) {
        $freq = Get-Random -Min 100 -Max 3000
        $dur = Get-Random -Min 50 -Max 200
        [System.Console]::Beep($freq, $dur)
        Start-Sleep -Milliseconds 50
    }

    # Son bir patlama
    [System.Console]::Beep(2000, 500)

    Write-Host "EN: Ses patlaması tamamlandı." -ForegroundColor Yellow
} catch {
    Write-Host "Ses patlaması hatasi: $_" -ForegroundColor Red
}