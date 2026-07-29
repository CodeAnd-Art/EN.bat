# ============================================================
# EN – ANA CIHAZ UYARISI
# ============================================================

Add-Type -AssemblyName System.Windows.Forms

try {
    [System.Windows.Forms.MessageBox]::Show(
        "BU YAZILIM YALNIZCA SANAL MAKİNE İÇİNDE ÇALIŞIR!" +
        "`n`nAna cihazda çalıştırılmaya çalışıldı." +
        "`nGüvenlik nedeniyle işlem durduruldu." +
        "`n`nLog: C:\EN_Guvenlik_Log.txt",
        "EN - GÜVENLİK DUVARI",
        "OK",
        "Error"
    )

    $log = "C:\EN_Guvenlik_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] ANA CIHAZDA CALISTIRILMA GIRISIMI ENGELLENDI."
} catch {
    Write-Host "Uyari gosterilemedi: $_" -ForegroundColor Red
}

exit 1