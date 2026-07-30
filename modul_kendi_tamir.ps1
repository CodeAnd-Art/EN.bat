# ============================================================
# EN – GELİŞMİŞ KENDİ KENDİNE TAMİR
# ============================================================

$requestDosyasi = "request.txt"
$tamirLog = "C:\EN_Tamir_Log.txt"

function Get-RequestValue {
    param($anahtar)
    if (Test-Path $requestDosyasi) {
        try {
            $satirlar = Get-Content $requestDosyasi -Encoding UTF8
            foreach ($satir in $satirlar) {
                if ($satir -match "^$anahtar=") {
                    return ($satir -split "=", 2)[1].Trim()
                }
            }
        } catch {}
    }
    return $null
}

try {
    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR BASLADI"

    # Dosya kontrolü
    $dosyaListesiRaw = Get-RequestValue "FILES"
    $gerekliDosyalar = @()
    if ($dosyaListesiRaw) {
        $gerekliDosyalar = $dosyaListesiRaw -split ","
    } else {
        $gerekliDosyalar = @("EN.bat","config.txt","EN.png","modul_guvenlik_duvari.ps1","modul_ayar_oku.ps1","modul_kernel_ye.ps1")
    }

    $eksik = 0
    $tamirEdilen = 0

    foreach ($dosya in $gerekliDosyalar) {
        if (-not (Test-Path $dosya)) {
            $eksik++
            Write-Host "[EN] Eksik dosya: $dosya" -ForegroundColor Yellow
            Add-Content -Path $tamirLog -Value "[$(Get-Date)] EKSIK: $dosya"
            try {
                New-Item -Path $dosya -ItemType File -Force -ErrorAction SilentlyContinue
                Add-Content -Path $dosya -Value "# Yedek dosya - Otomatik olusturuldu" -ErrorAction SilentlyContinue
                $tamirEdilen++
                Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR: $dosya olusturuldu."
            } catch {
                Add-Content -Path $tamirLog -Value "[$(Get-Date)] HATA: $dosya olusturulamadi."
            }
        }
    }

    # Kütüphane kontrolü
    if (Test-Path "modul_kutuphane_kontrol.ps1") {
        Write-Host "[EN] Kütüphane kontrolü başlatılıyor..." -ForegroundColor Cyan
        . ./modul_kutuphane_kontrol.ps1
    } else {
        Write-Host "[EN] modul_kutuphane_kontrol.ps1 bulunamadı!" -ForegroundColor Red
        Add-Content -Path $tamirLog -Value "[$(Get-Date)] KÜTÜPHANE KONTROL MODULU EKSIK!"
    }

    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR TAMAMLANDI. Eksik: $eksik, Tamir Edilen: $tamirEdilen"
    Write-Host "[EN] Kendi kendini tamir tamamlandi. Eksik: $eksik, Tamir: $tamirEdilen" -ForegroundColor Green

} catch {
    Write-Host "[EN] Tamir hatasi: $_" -ForegroundColor Red
    Add-Content -Path $tamirLog -Value "[$(Get-Date)] TAMIR HATASI: $_"
}