# ============================================================
# EN – SINIR SEVIYESI (DİL DESTEKLİ)
# ============================================================

. ./modul_dil_destek.ps1

$script:sinir = 0
$maxSinir = 10

function SinirGoster {
    try {
        switch ($script:sinir) {
            0 { Write-Host (Get-Mesaj "mutlu") -ForegroundColor Green }
            1..3 { Write-Host (Get-Mesaj "orta_mutlu") -ForegroundColor Yellow }
            4..6 {
                Write-Host (Get-Mesaj "sinirli") -ForegroundColor Red
                if (Test-Path "modul_ekran_bozma.ps1") { . ./modul_ekran_bozma.ps1 }
                if (Test-Path "modul_sistem_dosyasi_ye.ps1") { . ./modul_sistem_dosyasi_ye.ps1 }
            }
            7..9 {
                Write-Host (Get-Mesaj "kizgin") -ForegroundColor Red -BackgroundColor Black
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