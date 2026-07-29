# ============================================================
# EN – MİNİ OYUN (RASGELE)
# ============================================================

try {
    $oyunlar = @(
        @{
            ad = "Sayi Tahmin"
            oyna = {
                $hedef = Get-Random -Min 1 -Max 10
                Write-Host "EN: 1-10 arasi bir sayi tahmin et!" -ForegroundColor Yellow
                $tahmin = Read-Host "Tahminin"
                if ($tahmin -eq $hedef) {
                    Write-Host "EN: Dogru bildin! Tebrikler." -ForegroundColor Green
                    return $true
                } else {
                    Write-Host "EN: Yanlis! Dogru sayi: $hedef" -ForegroundColor Red
                    return $false
                }
            }
        },
        @{
            ad = "Harfli Oyun"
            oyna = {
                $harfler = @("A", "B", "C", "D", "E")
                $hedef = $harfler | Get-Random
                Write-Host "EN: Harfler: A B C D E" -ForegroundColor Yellow
                Write-Host "EN: Hangi harfi sectim?" -ForegroundColor Yellow
                $tahmin = Read-Host "Tahminin"
                if ($tahmin -eq $hedef) {
                    Write-Host "EN: Dogru bildin!" -ForegroundColor Green
                    return $true
                } else {
                    Write-Host "EN: Yanlis! Dogru harf: $hedef" -ForegroundColor Red
                    return $false
                }
            }
        },
        @{
            ad = "Cift mi Tek mi"
            oyna = {
                $sayi = Get-Random -Min 1 -Max 10
                Write-Host "EN: $sayi sayisi cift mi tek mi?" -ForegroundColor Yellow
                $tahmin = Read-Host "Cift/Tek"
                $cevap = if ($sayi % 2 -eq 0) { "cift" } else { "tek" }
                if ($tahmin -eq $cevap) {
                    Write-Host "EN: Dogru!" -ForegroundColor Green
                    return $true
                } else {
                    Write-Host "EN: Yanlis! $sayi $cevap" -ForegroundColor Red
                    return $false
                }
            }
        }
    )

    $secili = $oyunlar | Get-Random
    Write-Host "EN: Oyun: $($secili.ad)" -ForegroundColor Cyan
    $sonuc = & $secili.oyna

    if ($sonuc) {
        Write-Host "EN: Oyunu kazandin! Mutluyum." -ForegroundColor Green
        $script:sinir = 0
    } else {
        Write-Host "EN: Oyunu kaybettin! Sinirleniyorum..." -ForegroundColor Red
        $script:sinir += 2
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Mini oyun: $($secili.ad) - $(if($sonuc){'Kazandi'}else{'Kaybetti'})"
} catch {
    Write-Host "Mini oyun hatasi: $_" -ForegroundColor Red
}