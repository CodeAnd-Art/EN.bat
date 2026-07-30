# ============================================================
# EN – KOD YÜKLE (GERÇEK KÜÇÜK / SAHTE BÜYÜK)
# ============================================================

try {
    # Küçük gerçek kodlar (zararsız)
    $kucuk_gercek = @(
        { New-Item -Path "C:\EN_test.txt" -ItemType File -Force | Out-Null },
        { Write-Host "[EN] Test dosyası oluşturuldu." -ForegroundColor Green },
        { $env:COMPUTERNAME | Out-File "C:\EN_system.txt" }
    )

    # Büyük sahte kodlar (sadece mesaj)
    $buyuk_sahte = @(
        "Kernel modülü yükleniyor...",
        "Sürücü enjeksiyonu başlatılıyor...",
        "Ring 0 erişimi sağlanıyor...",
        "Boot sector override ediliyor...",
        "MBR yeniden yazılıyor...",
        "BIOS flaşlanıyor...",
        "Güvenlik açığı istismar ediliyor..."
    )

    # Küçük gerçek kodlardan birini çalıştır
    $secili_gercek = $kucuk_gercek | Get-Random
    & $secili_gercek

    # Büyük sahte kod mesajı göster
    $secili_sahte = $buyuk_sahte | Get-Random
    Write-Host "[EN] $secili_sahte" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 500

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Kod yükleme çalıştırıldı."
} catch {
    Write-Host "[EN] Kod yükleme hatası: $_" -ForegroundColor Red
}