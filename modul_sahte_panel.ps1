# ============================================================
# EN – SAHTE PANEL (ZERO-CLICK + GELİŞMİŞ EFEKTLER)
# ============================================================
# Bu modül:
# - Zero-click exploit paneli simülasyonu
# - Sahte kod yükleme aşamaları (farklı dosya türleri, hata mesajları)
# - Ekran patlamaları ve terminal animasyonları
# - Pencere sallama efekti
# - Kullanıcı etkileşimi (panel kapatılırsa BSOD + kernel silme)
# - Ses efektleriyle entegrasyon
# - Loglama ve hata yönetimi
# ============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Runtime.InteropServices

# Pencere sallama için API
$MoveWindow = Add-Type -MemberDefinition @'
[DllImport("user32.dll")]
public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
[DllImport("kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
'@ -Name "WinAPI" -Namespace "Console" -PassThru

$hWnd = [Console.WinAPI]::GetConsoleWindow()

try {
    Write-Host "[EN] Zero-click exploit paneli açılıyor..." -ForegroundColor Red -BackgroundColor Black
    Start-Sleep -Seconds 1

    # 1. Sahte kod yükleme aşamaları (10 farklı aşama)
    $asamalar = @(
        "Kernel modülü yükleniyor...",
        "Sürücü enjeksiyonu başlatılıyor...",
        "Ring 0 erişimi sağlanıyor...",
        "Boot sector override ediliyor...",
        "MBR yeniden yazılıyor...",
        "BIOS flaşlanıyor...",
        "Güvenlik açığı istismar ediliyor...",
        "Sistem çağrıları ele geçiriliyor...",
        "Anti-debug bypass uygulanıyor...",
        "Zero-day exploit başlatılıyor..."
    )

    for ($i=0; $i -lt 10; $i++) {
        $rnd = Get-Random -Min 1000 -Max 9999
        $rnd2 = Get-Random -Min 100 -Max 500
        Write-Host "[EN] $($asamalar[$i]) 0x$rnd - %$((($i+1)*10))" -ForegroundColor Yellow
        Start-Sleep -Milliseconds $rnd2

        # Pencere sallama (her aşamada farklı şiddette)
        $siddet = Get-Random -Min 5 -Max 25
        $x = Get-Random -Min -$siddet -Max $siddet
        $y = Get-Random -Min -$siddet -Max $siddet
        [Console.WinAPI]::MoveWindow($hWnd, $x, $y, 800, 600, $true)
    }

    # Pencereyi normale döndür
    [Console.WinAPI]::MoveWindow($hWnd, 0, 0, 800, 600, $true)

    # 2. Hata mesajları (sahte)
    Write-Host "[EN] HATA: Exploit başarısız! Yeniden deneniyor..." -ForegroundColor Red
    Start-Sleep -Milliseconds 500
    Write-Host "[EN] HATA: Güvenlik duvarı müdahale etti!" -ForegroundColor Red
    Start-Sleep -Milliseconds 500
    Write-Host "[EN] BAŞARILI: Zero-day exploit yüklendi." -ForegroundColor Green
    Start-Sleep -Seconds 1

    # 3. Ekran patlaması efekti (kısa)
    $form = New-Object System.Windows.Forms.Form
    $form.WindowState = 'Maximized'
    $form.FormBorderStyle = 'None'
    $form.TopMost = $true
    $form.BackColor = 'White'
    $form.Show()
    Start-Sleep -Milliseconds 200
    $form.BackColor = 'Black'
    Start-Sleep -Milliseconds 200
    $form.BackColor = 'Red'
    Start-Sleep -Milliseconds 200
    $form.BackColor = 'White'
    Start-Sleep -Milliseconds 200
    $form.Close()

    # 4. Ses patlaması (kısa)
    for ($i=0; $i -lt 5; $i++) {
        $freq = Get-Random -Min 200 -Max 2000
        [System.Console]::Beep($freq, 150)
        Start-Sleep -Milliseconds 50
    }

    # 5. Son mesaj
    Write-Host "[EN] Panel açıldı. Sistem çöküşü başlatılıyor..." -ForegroundColor Red -BackgroundColor Black
    Write-Host "[EN] UYARI: Paneli kapatırsanız BSOD ve kernel silme başlayacak!" -ForegroundColor Yellow

    $script:panel_kapandi = $false

    # 6. Log kaydı
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Zero-click paneli açıldı ve exploit yüklendi."

    # 7. Panel kapatılırsa ne olacağını sinir seviyesine bildir
    Write-Host "[EN] Paneli kapatmak için CTRL+C veya pencereyi kapatın." -ForegroundColor Cyan

} catch {
    Write-Host "[EN] Panel hatasi: $_" -ForegroundColor Red
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Panel hatasi: $_"
}