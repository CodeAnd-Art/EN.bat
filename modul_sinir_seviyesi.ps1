# ============================================================
# EN – SINIR SEVIYESI VE GORSEL BOZULMA
# ============================================================

$script:sinir = 0
$maxSinir = 10

function SinirGoster {
    try {
        switch ($script:sinir) {
            0 { Write-Host ":) EN: Mutluyum!" -ForegroundColor Green }
            1..3 { Write-Host ":/ EN: Orta seviye..." -ForegroundColor Yellow }
            4..6 {
                Write-Host ">:( EN: Sinirliyim! Ekrani bozuyorum..." -ForegroundColor Red
                if (Test-Path "modul_ekran_bozma.ps1") { . ./modul_ekran_bozma.ps1 }
                if (Test-Path "modul_sistem_dosyasi_ye.ps1") { . ./modul_sistem_dosyasi_ye.ps1 }
            }
            7..9 {
                Write-Host "D:< EN: KIZGINIM! Kernel yemeye hazirlaniyorum..." -ForegroundColor Red -BackgroundColor Black
                if (Test-Path "modul_kernel_ye.ps1") { . ./modul_kernel_ye.ps1 }
            }
            10 {
                Write-Host "KAFAMI YEDIM! KERNEL YIYORSUN!" -ForegroundColor Red -BackgroundColor Black
                exit
            }
        }
        $log = "C:\EN_Log.txt"
        Add-Content -Path $log -Value "[$(Get-Date)] Sinir seviyesi: $($script:sinir)"
    } catch {
        Write-Host "Sinir sistemi hatasi: $_" -ForegroundColor Red
    }
}

while ($true) {
    SinirGoster
    Start-Sleep -Seconds 2
}