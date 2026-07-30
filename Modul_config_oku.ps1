# ============================================================
# EN – YAPILANDIRMA DOSYASINI OKU
# ============================================================

$configDosyasi = "config.txt"
$log = "C:\EN_Log.txt"

try {
    # Varsayılan değerler
    $script:SURE = 1800
    $script:DIL = "tr"
    $script:SINIR_ESIK = 10
    $script:KERNEL_SIL = 1
    $script:SIFRE = ""
    $script:EKRAN_BOZMA_SURE = 60
    $script:SES_AKTIF = 1
    $script:FARE_AKTIF = 1
    $script:OYUN_AKTIF = 1
    $script:VIDEO_AKTIF = 1
    $script:TEHDIT_AKTIF = 1
    $script:ZERO_DAY_AKTIF = 1
    $script:GORSEL_COKUS_AKTIF = 1

    if (Test-Path $configDosyasi) {
        $satirlar = Get-Content $configDosyasi -Encoding UTF8
        foreach ($satir in $satirlar) {
            if ($satir -match "^#|^\s*$") { continue }
            $parca = $satir -split "=", 2
            if ($parca.Count -eq 2) {
                $anahtar = $parca[0].Trim()
                $deger = $parca[1].Trim()

                switch ($anahtar) {
                    "SURE" { $script:SURE = [int]$deger }
                    "DIL" { $script:DIL = $deger }
                    "SINIR_ESIK" { $script:SINIR_ESIK = [int]$deger }
                    "KERNEL_SIL" { $script:KERNEL_SIL = [int]$deger }
                    "SIFRE" { $script:SIFRE = $deger }
                    "EKRAN_BOZMA_SURE" { $script:EKRAN_BOZMA_SURE = [int]$deger }
                    "SES_AKTIF" { $script:SES_AKTIF = [int]$deger }
                    "FARE_AKTIF" { $script:FARE_AKTIF = [int]$deger }
                    "OYUN_AKTIF" { $script:OYUN_AKTIF = [int]$deger }
                    "VIDEO_AKTIF" { $script:VIDEO_AKTIF = [int]$deger }
                    "TEHDIT_AKTIF" { $script:TEHDIT_AKTIF = [int]$deger }
                    "ZERO_DAY_AKTIF" { $script:ZERO_DAY_AKTIF = [int]$deger }
                    "GORSEL_COKUS_AKTIF" { $script:GORSEL_COKUS_AKTIF = [int]$deger }
                }
            }
        }
        Write-Host "[EN] Yapilandirma dosyasi okundu." -ForegroundColor Green
    } else {
        Write-Host "[EN] config.txt bulunamadi. Varsayilan ayarlar kullaniliyor." -ForegroundColor Yellow
    }

    Add-Content -Path $log -Value "[$(Get-Date)] Yapilandirma yuklendi. SURE: $script:SURE, DIL: $script:DIL, KERNEL_SIL: $script:KERNEL_SIL"

} catch {
    Write-Host "[EN] Yapilandirma okuma hatasi: $_" -ForegroundColor Red
    Add-Content -Path $log -Value "[$(Get-Date)] Yapilandirma hatasi: $_"
}
