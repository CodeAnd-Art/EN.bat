# ============================================================
# EN – CHAT + TEHDİT SİSTEMİ
# ============================================================

. ./modul_kufur_listesi.ps1
. ./modul_tehdit_konusmasi.ps1

$script:sinir = 0

function ChatYanit($mesaj) {
    $mesajKucuk = $mesaj.ToLower()

    if ($kufurSozler -contains $mesajKucuk) {
        $script:sinir += 2
        Write-Host "[EN] Küfür mü? Tehdit ediyorum!" -ForegroundColor Red
        . ./modul_tehdit_konusmasi.ps1
    } elseif ($hakaretSozler -contains $mesajKucuk) {
        $script:sinir += 3
        Write-Host "[EN] Hakaret mi?!" -ForegroundColor Red
        . ./modul_tehdit_konusmasi.ps1
        . ./modul_ekran_bozma.ps1
    } elseif ($mesaj -eq "korktum") {
        Write-Host "[EN] Korktun mu? İyi." -ForegroundColor Red
        . ./modul_sinir_sesi.ps1
    } else {
        Write-Host "[EN] Anladım, devam ediyorum." -ForegroundColor Cyan
        . ./modul_tehdit_konusmasi.ps1
    }

    if ($script:sinir -ge 10) {
        Write-Host "[EN] Kernel siliniyor!" -ForegroundColor Red -BackgroundColor Black
        . ./modul_kernel_ye.ps1
        exit
    }
}

while ($true) {
    $girilen = Read-Host "Sen"
    if ($girilen -eq "exit") { break }
    ChatYanit $girilen
}