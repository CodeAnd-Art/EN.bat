# ============================================================
# EN – SON EKRAN (TEŞEKKÜR + KAPANMA)
# ============================================================

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

# Log kaydı
$log = "C:\EN_Log.txt"
Add-Content -Path $log -Value "[$(Get-Date)] EN basariyla tamamlandi. Kullanici sinirlendirmedi."

exit 0