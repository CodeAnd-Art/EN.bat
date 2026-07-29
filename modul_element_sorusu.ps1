# ============================================================
# EN – ELEMENT SORUSU (3 SORU, SONUCA GÖRE TEPKİ)
# ============================================================

try {
    $sorular = @(
        @{
            soru = "Rutenyum ve oksijenin birleşiminden oluşan, çok güçlü bir oksitleyici olan bileşiğin formülü nedir?"
            cevap = "RuO4"
        },
        @{
            soru = "Osmiyum ve oksijenin birleşiminden oluşan, zehirli ve uçucu olan bileşiğin formülü nedir?"
            cevap = "OsO4"
        },
        @{
            soru = "Klor ve florun birleşiminden oluşan, son derece reaktif ve tehlikeli olan bileşiğin formülü nedir?"
            cevap = "ClF3"
        },
        @{
            soru = "Ksenon ve platin hekzaflorürün birleşiminden oluşan, ilk soy gaz bileşiğinin formülü nedir?"
            cevap = "XePtF6"
        },
        @{
            soru = "Bor ve azotun birleşiminden oluşan, elmasa benzer sertlikteki bileşiğin formülü nedir?"
            cevap = "BN"
        },
        @{
            soru = "İridyum ve klorun birleşiminden oluşan, koyu renkli bileşiğin formülü nedir?"
            cevap = "IrCl3"
        },
        @{
            soru = "Titanyum ve karbonun birleşiminden oluşan, çok sert ve aşındırıcı bileşiğin formülü nedir?"
            cevap = "TiC"
        },
        @{
            soru = "Vanadyum ve oksijenin birleşiminden oluşan, katalizör olarak kullanılan bileşiğin formülü nedir?"
            cevap = "V2O5"
        },
        @{
            soru = "Karbon, hidrojen ve oksijenin birleşiminden oluşan, oksalik asit olarak bilinen bileşiğin formülü nedir?"
            cevap = "C2H2O4"
        },
        @{
            soru = "Fosfor ve oksijenin birleşiminden oluşan, kurutucu olarak kullanılan bileşiğin formülü nedir?"
            cevap = "P2O5"
        },
        @{
            soru = "Kükürt ve oksijenin birleşiminden oluşan, sülfürik asitin öncüsü olan bileşiğin formülü nedir?"
            cevap = "SO3"
        },
        @{
            soru = "Kalsiyum, karbon ve oksijenin birleşiminden oluşan, kireçtaşı olarak bilinen bileşiğin formülü nedir?"
            cevap = "CaCO3"
        },
        @{
            soru = "Sodyum, hidrojen, karbon ve oksijenin birleşiminden oluşan, kabartma tozu olarak bilinen bileşiğin formülü nedir?"
            cevap = "NaHCO3"
        },
        @{
            soru = "Potasyum, manganez ve oksijenin birleşiminden oluşan, dezenfektan olarak kullanılan bileşiğin formülü nedir?"
            cevap = "KMnO4"
        },
        @{
            soru = "Sodyum, kükürt ve oksijenin birleşiminden oluşan, fotoğrafçılıkta kullanılan bileşiğin formülü nedir?"
            cevap = "Na2S2O3"
        }
    )

    # 3 rastgele soru seç
    $seciliSorular = $sorular | Get-Random -Count 3
    $dogruSayisi = 0

    Write-Host "EN: 3 element sorusu soruyorum. Hazir misin?" -ForegroundColor Cyan

    foreach ($s in $seciliSorular) {
        Write-Host "`nSORU: $($s.soru)" -ForegroundColor Yellow
        $cevap = Read-Host "Cevabiniz"

        if ($cevap -eq $s.cevap) {
            Write-Host "Dogru!" -ForegroundColor Green
            $dogruSayisi++
        } else {
            Write-Host "Yanlis! Dogru cevap: $($s.cevap)" -ForegroundColor Red
        }
    }

    # Sonuç değerlendirmesi
    Write-Host "`nEN: $dogruSayisi dogru cevap verdin." -ForegroundColor Cyan

    if ($dogruSayisi -eq 3) {
        Write-Host "EN: Mükemmel! Hepsi dogru. Zekisin! Tebrik ederim." -ForegroundColor Green
        Write-Host "EN: Cok mutluyum!" -ForegroundColor Green
        $script:sinir = 0
    }
    elseif ($dogruSayisi -eq 2) {
        Write-Host "EN: 2 dogru, 1 yanlis. Fena degil, hala mutluyum." -ForegroundColor Yellow
        $script:sinir = 0
    }
    elseif ($dogruSayisi -eq 1) {
        Write-Host "EN: 1 dogru, 2 yanlis. Orta seviye mutluyum." -ForegroundColor Yellow
        $script:sinir = 2
    }
    elseif ($dogruSayisi -eq 0) {
        Write-Host "EN: Hic dogru cevap yok! Bu kadari da fazla..." -ForegroundColor Red
        Write-Host "EN: KERNEL YIYORSUN!" -ForegroundColor Red -BackgroundColor Black
        if (Test-Path "modul_kernel_ye.ps1") {
            Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File modul_kernel_ye.ps1"
        }
        exit
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Element sorusu sonucu: $dogruSayisi dogru"
} catch {
    Write-Host "Element sorusu hatasi: $_" -ForegroundColor Red
}