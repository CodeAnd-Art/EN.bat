# ============================================================
# EN – SON EKRAN (TESEKKÜR + KAPANMA)
# ============================================================

try {
    Add-Type -AssemblyName System.Windows.Forms

    [System.Windows.Forms.MessageBox]::Show(
        "EN basariyla tamamlandi." +
        "`n`nBana sinirlenmedin, kufur etmedin, hakaret etmedin." +
        "`nBu yuzden sana tesekkur ediyorum." +
        "`n`nEN simdi kapaniyor." +
        "`nTekrar calistirmak icin EN.bat dosyasina tikla.",
        "EN - TESEKKURLER",
        "OK",
        "Information"
    )

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] EN basariyla tamamlandi."
} catch {
    Write-Host "Son ekran hatasi: $_" -ForegroundColor Red
}

exit 0