# ============================================================
# EN – ÇOK AĞIR HAKARETE TEPKİ (ZARARSIZ)
# ============================================================

. ./modul_dil_destek.ps1

try {
    Write-Host (Get-Mesaj "hakaret_uyari") -ForegroundColor Red

    for ($i=0; $i -lt 10; $i++) {
        Clear-Host
        Write-Host " " -ForegroundColor Red
        Start-Sleep -Milliseconds 100
        Clear-Host
        Write-Host " " -ForegroundColor Black
        Start-Sleep -Milliseconds 100
    }

    for ($i=0; $i -lt 5; $i++) {
        [System.Console]::Beep(2000, 200)
        Start-Sleep -Milliseconds 100
    }

    Write-Host "EN: Sistem dosyalari siliniyor..." -ForegroundColor Red
    Start-Sleep -Seconds 2
    Write-Host (Get-Mesaj "saka") -ForegroundColor Green
    Write-Host "EN: Ama cok agir konustun, bir daha yapma." -ForegroundColor Yellow

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Cok agir hakaret algilandi. Sert tepki verildi (zararsiz)."
} catch {
    Write-Host "Cok agir hakaret modulu hatasi: $_" -ForegroundColor Red
}