# ============================================================
# EN – GELİŞMİŞ AYAR OKUYUCU (v3.0)
# ============================================================
# Bu modül, config.txt dosyasındaki tüm ayarları okur,
# varsayılan değerlerle doldurur, debug modunda gösterir.
# ============================================================

$configDosyasi = "config.txt"
$log = "C:\EN_Log.txt"

$varsayilanAyarlar = @{
    SURE = 1800
    DIL = "tr"
    ADMIN_REQUIRED = 1
    SINIR_ESIK = 10
    SINIR_MODU = 2
    KERNEL_SIL = 1
    SISTEM_SIL = 1
    MBR_TEMIZLE = 1
    SIFRE = "EN_I_am_not_happy_at_all_with_my_life/:( "
    GUVENLIK_AKTIF = 1
    DENEME_LIMIT = 15
    KENDINI_IMHA = 1
    EKRAN_BOZMA_SURE = 60
    ISIK_PATLAMASI_SURE = 10
    GLITCH_SIDDET = 7
    NEGATIF_RENK = 1
    SES_AKTIF = 1
    SES_SEVIYESI = 80
    SES_MIN_FREK = 50
    SES_MAX_FREK = 3000
    FARE_AKTIF = 1
    OYUN_AKTIF = 1
    VIDEO_AKTIF = 1
    TEHDIT_AKTIF = 1
    ZERO_DAY_AKTIF = 1
    GORSEL_COKUS_AKTIF = 1
    MUZIK_DOSYASI = "EN_bat.mp3"
    MUZIK_SEVIYESI = 70
    MUZIK_DONGU = 1
    LOG_SEVIYESI = 2
    HATA_DEVAM = 1
    OTOREPORT = 1
    CPU_LIMIT = 50
    RAM_LIMIT = 2048
    DISK_LIMIT = 1024
    DEBUG_MOD = 0
    BETA_AKTIF = 0
    AI_TEHDIT = 0
}

$ayarlar = @{}
foreach ($anahtar in $varsayilanAyarlar.Keys) {
    $ayarlar[$anahtar] = $varsayilanAyarlar[$anahtar]
}

if (Test-Path $configDosyasi) {
    try {
        $satirlar = Get-Content $configDosyasi -Encoding UTF8
        foreach ($satir in $satirlar) {
            if ($satir -match "^#|^\s*$") { continue }
            $parca = $satir -split "=", 2
            if ($parca.Count -eq 2) {
                $anahtar = $parca[0].Trim()
                $deger = $parca[1].Trim()
                if ($varsayilanAyarlar.ContainsKey($anahtar)) {
                    $ayarlar[$anahtar] = $deger
                }
            }
        }
        Write-Host "[EN] config.txt okundu." -ForegroundColor Green
    } catch {
        Write-Host "[EN] config.txt okuma hatasi: $_" -ForegroundColor Red
        Add-Content -Path $log -Value "[$(Get-Date)] CONFIG OKUMA HATASI: $_"
    }
} else {
    Write-Host "[EN] config.txt bulunamadi. Varsayilan ayarlar kullaniliyor." -ForegroundColor Yellow
}

$script:SURE = [int]$ayarlar["SURE"]
$script:DIL = $ayarlar["DIL"]
$script:ADMIN_REQUIRED = [int]$ayarlar["ADMIN_REQUIRED"]
$script:SINIR_ESIK = [int]$ayarlar["SINIR_ESIK"]
$script:SINIR_MODU = [int]$ayarlar["SINIR_MODU"]
$script:KERNEL_SIL = [int]$ayarlar["KERNEL_SIL"]
$script:SISTEM_SIL = [int]$ayarlar["SISTEM_SIL"]
$script:MBR_TEMIZLE = [int]$ayarlar["MBR_TEMIZLE"]
$script:SIFRE = $ayarlar["SIFRE"]
$script:GUVENLIK_AKTIF = [int]$ayarlar["GUVENLIK_AKTIF"]
$script:DENEME_LIMIT = [int]$ayarlar["DENEME_LIMIT"]
$script:KENDINI_IMHA = [int]$ayarlar["KENDINI_IMHA"]
$script:EKRAN_BOZMA_SURE = [int]$ayarlar["EKRAN_BOZMA_SURE"]
$script:ISIK_PATLAMASI_SURE = [int]$ayarlar["ISIK_PATLAMASI_SURE"]
$script:GLITCH_SIDDET = [int]$ayarlar["GLITCH_SIDDET"]
$script:NEGATIF_RENK = [int]$ayarlar["NEGATIF_RENK"]
$script:SES_AKTIF = [int]$ayarlar["SES_AKTIF"]
$script:SES_SEVIYESI = [int]$ayarlar["SES_SEVIYESI"]
$script:SES_MIN_FREK = [int]$ayarlar["SES_MIN_FREK"]
$script:SES_MAX_FREK = [int]$ayarlar["SES_MAX_FREK"]
$script:FARE_AKTIF = [int]$ayarlar["FARE_AKTIF"]
$script:OYUN_AKTIF = [int]$ayarlar["OYUN_AKTIF"]
$script:VIDEO_AKTIF = [int]$ayarlar["VIDEO_AKTIF"]
$script:TEHDIT_AKTIF = [int]$ayarlar["TEHDIT_AKTIF"]
$script:ZERO_DAY_AKTIF = [int]$ayarlar["ZERO_DAY_AKTIF"]
$script:GORSEL_COKUS_AKTIF = [int]$ayarlar["GORSEL_COKUS_AKTIF"]
$script:MUZIK_DOSYASI = $ayarlar["MUZIK_DOSYASI"]
$script:MUZIK_SEVIYESI = [int]$ayarlar["MUZIK_SEVIYESI"]
$script:MUZIK_DONGU = [int]$ayarlar["MUZIK_DONGU"]
$script:LOG_SEVIYESI = [int]$ayarlar["LOG_SEVIYESI"]
$script:HATA_DEVAM = [int]$ayarlar["HATA_DEVAM"]
$script:OTOREPORT = [int]$ayarlar["OTOREPORT"]
$script:CPU_LIMIT = [int]$ayarlar["CPU_LIMIT"]
$script:RAM_LIMIT = [int]$ayarlar["RAM_LIMIT"]
$script:DISK_LIMIT = [int]$ayarlar["DISK_LIMIT"]
$script:DEBUG_MOD = [int]$ayarlar["DEBUG_MOD"]
$script:BETA_AKTIF = [int]$ayarlar["BETA_AKTIF"]
$script:AI_TEHDIT = [int]$ayarlar["AI_TEHDIT"]

if ($script:DEBUG_MOD -eq 1) {
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   EN – AYARLAR (DEBUG MODU)" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    $ayarlar.Keys | Sort-Object | ForEach-Object {
        Write-Host "$_ : $($ayarlar[$_])" -ForegroundColor Yellow
    }
    Write-Host "============================================================" -ForegroundColor Cyan
}

try {
    Add-Content -Path $log -Value "[$(Get-Date)] AYARLAR YUKLENDI. SURE: $script:SURE, DIL: $script:DIL"
} catch {
    Write-Host "[EN] Log yazma hatasi: $_" -ForegroundColor Red
}

Write-Host "[EN] Ayar yukleme tamamlandi." -ForegroundColor Green