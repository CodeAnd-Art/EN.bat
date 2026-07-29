# ============================================================
# EN – YAPILANDIRMA DOSYASINI OKU
# ============================================================

$configDosyasi = "config.txt"

if (Test-Path $configDosyasi) {
    $satirlar = Get-Content $configDosyasi -Encoding UTF8
    $ayarlar = @{}
    foreach ($satir in $satirlar) {
        # Yorum satırlarını ve boş satırları atla
        if ($satir -match "^#|^\s*$") { continue }
        $parca = $satir -split "=", 2
        if ($parca.Count -eq 2) {
            $anahtar = $parca[0].Trim()
            $deger = $parca[1].Trim()
            $ayarlar[$anahtar] = $deger
        }
    }

    $script:SURE = if ($ayarlar.ContainsKey("SURE")) { [int]$ayarlar["SURE"] } else { 1800 }
    $script:DIL = if ($ayarlar.ContainsKey("DIL")) { $ayarlar["DIL"] } else { "tr" }
    $script:SINIR_ESIK = if ($ayarlar.ContainsKey("SINIR_ESIK")) { [int]$ayarlar["SINIR_ESIK"] } else { 10 }
    $script:KERNEL_SIL = if ($ayarlar.ContainsKey("KERNEL_SIL")) { [int]$ayarlar["KERNEL_SIL"] } else { 1 }
    $script:SIFRE = if ($ayarlar.ContainsKey("SIFRE")) { $ayarlar["SIFRE"] } else { "" }
    $script:EKRAN_BOZMA_SURE = if ($ayarlar.ContainsKey("EKRAN_BOZMA_SURE")) { [int]$ayarlar["EKRAN_BOZMA_SURE"] } else { 60 }
    $script:SES_AKTIF = if ($ayarlar.ContainsKey("SES_AKTIF")) { [int]$ayarlar["SES_AKTIF"] } else { 1 }
    $script:FARE_AKTIF = if ($ayarlar.ContainsKey("FARE_AKTIF")) { [int]$ayarlar["FARE_AKTIF"] } else { 1 }
    $script:OYUN_AKTIF = if ($ayarlar.ContainsKey("OYUN_AKTIF")) { [int]$ayarlar["OYUN_AKTIF"] } else { 1 }
    $script:VIDEO_AKTIF = if ($ayarlar.ContainsKey("VIDEO_AKTIF")) { [int]$ayarlar["VIDEO_AKTIF"] } else { 1 }
} else {
    # Varsayılan ayarlar
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
}

$log = "C:\EN_Log.txt"
Add-Content -Path $log -Value "[$(Get-Date)] Yapılandırma okundu. Süre: $script:SURE, Dil: $script:DIL"