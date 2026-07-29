# ============================================================
# EN – GELİŞMİŞ LOG SİSTEMİ
# ============================================================

$log = "C:\EN_Log.txt"

try {
    Add-Content -Path $log -Value "========================================="
    Add-Content -Path $log -Value "[$(Get-Date)] EN LOG SISTEMI BASLATILDI"
    Add-Content -Path $log -Value "========================================="

    while ($true) {
        $zaman = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -Path $log -Value "[$zaman] EN aktif."
        Start-Sleep -Seconds 10
    }
} catch {
    Write-Host "Log sistemi hatasi: $_" -ForegroundColor Red
}