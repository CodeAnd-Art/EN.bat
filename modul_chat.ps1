# ============================================================
# EN – KONUSMA CHAT SISTEMI
# ============================================================

if (Test-Path "modul_kufur_listesi.ps1") { . ./modul_kufur_listesi.ps1 } else { Write-Host "Kufur listesi eksik!" -ForegroundColor Red; exit }

$script:sinir = 0

function ChatYanit($mesaj) {
    try {
        $mesajKucuk = $mesaj.ToLower()

        if ($kufurSozler -contains $mesajKucuk) {
            $script:sinir += 2
            Write-Host "D:< EN: Kufur mu? Dikkat et!" -ForegroundColor Red
        } elseif ($hakaretSozler -contains $mesajKucuk) {
            $script:sinir += 3
            Write-Host ">:( EN: HAKARET MI?!" -ForegroundColor Red
        } elseif ($yakınlasmaSozler -contains $mesajKucuk) {
            Write-Host ":) EN: Ask mi? ROM/RAM/Disk %100 yaptim!" -ForegroundColor Magenta
            if (Test-Path "modul_kaynak_doldur.ps1") { Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File modul_kaynak_doldur.ps1" }
        } else {
            Write-Host ":) EN: Anladim, devam edelim." -ForegroundColor Cyan
        }

        if ($script:sinir -ge 10) {
            Write-Host "KAFAMI YEDIM! KERNEL YIYORSUN!" -ForegroundColor Red
            if (Test-Path "modul_kernel_ye.ps1") { Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File modul_kernel_ye.ps1" }
            exit
        }
        $log = "C:\EN_Log.txt"
        Add-Content -Path $log -Value "[$(Get-Date)] Chat: $mesaj"
    } catch {
        Write-Host "Chat hatasi: $_" -ForegroundColor Red
    }
}

while ($true) {
    try {
        $girilen = Read-Host "Sen"
        if ($girilen -eq "exit") { break }
        ChatYanit $girilen
    } catch {
        Write-Host "Giris hatasi: $_" -ForegroundColor Red
    }
}