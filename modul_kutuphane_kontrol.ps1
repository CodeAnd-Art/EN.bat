# ============================================================
# EN – GELİŞMİŞ KÜTÜPHANE KONTROLÜ (v3.0)
# ============================================================
# request.txt dosyasındaki ASSEMBLIES listesini okur,
# eksik assembly'leri tespit eder ve çözüm önerileri sunar.
# ============================================================

$requestDosyasi = "request.txt"
$log = "C:\EN_Log.txt"

function Get-AssemblyList {
    $assemblyList = @()
    if (Test-Path $requestDosyasi) {
        try {
            $satirlar = Get-Content $requestDosyasi -Encoding UTF8
            foreach ($satir in $satirlar) {
                if ($satir -match "^ASSEMBLIES=") {
                    $list = ($satir -split "=", 2)[1].Trim()
                    $assemblyList = $list -split ","
                    break
                }
            }
        } catch {
            Write-Host "[EN] request.txt okuma hatasi: $_" -ForegroundColor Red
        }
    }
    return $assemblyList
}

function Test-Assembly {
    param($assemblyName)
    try {
        Add-Type -AssemblyName $assemblyName -ErrorAction Stop
        return @{ Mevcut = $true; Ad = $assemblyName }
    } catch {
        return @{ Mevcut = $false; Ad = $assemblyName; Hata = $_.Exception.Message }
    }
}

function Get-CozumOnerisi {
    param($assemblyName)
    $oneriler = @{
        "System.Windows.Forms" = "PowerShell'i yönetici olarak çalıştır."
        "System.Drawing" = ".NET Framework 4.8 veya üzerini yükleyin."
        "System.Speech" = "Windows Özellikleri > Konuşma API'si'ni etkinleştir."
        "System.Runtime.InteropServices" = "Windows'ta hazırdır."
        "System.IO.Compression" = ".NET Framework 4.5+ gerektirir."
        "System.Net.Http" = ".NET Framework 4.5+ gerektirir."
        "System.Data" = ".NET Framework'ün bir parçasıdır."
        "System.Xml" = ".NET Framework'ün bir parçasıdır."
    }
    if ($oneriler.ContainsKey($assemblyName)) {
        return $oneriler[$assemblyName]
    } else {
        return ".NET Framework'ü güncellemeyi veya Visual Studio Redistributable'ı yüklemeyi deneyin."
    }
}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   EN – KÜTÜPHANE KONTROLÜ" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$assemblies = Get-AssemblyList
if ($assemblies.Count -eq 0) {
    Write-Host "[EN] Assembly listesi bos veya request.txt bulunamadi." -ForegroundColor Yellow
    exit
}

$toplam = $assemblies.Count
$mevcut = 0
$eksik = 0
$eksikListe = @()

foreach ($asm in $assemblies) {
    Write-Host "[EN] Kontrol ediliyor: $asm" -ForegroundColor Yellow
    $sonuc = Test-Assembly $asm
    if ($sonuc.Mevcut) {
        Write-Host "[EN] ✅ $asm mevcut." -ForegroundColor Green
        $mevcut++
    } else {
        Write-Host "[EN] ❌ $asm EKSIK!" -ForegroundColor Red
        $eksik++
        $eksikListe += $asm
        Write-Host "[EN] Öneri: $(Get-CozumOnerisi $asm)" -ForegroundColor Yellow
    }
}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   RAPOR" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Toplam : $toplam" -ForegroundColor Yellow
Write-Host "Mevcut : $mevcut" -ForegroundColor Green
Write-Host "Eksik  : $eksik" -ForegroundColor Red

if ($eksik -gt 0) {
    Write-Host "`n[EN] Eksik assembly'ler:" -ForegroundColor Red
    foreach ($hata in $eksikListe) {
        Write-Host "- $hata" -ForegroundColor Yellow
        Write-Host "  Çözüm: $(Get-CozumOnerisi $hata)" -ForegroundColor White
    }
} else {
    Write-Host "[EN] Tüm assembly'ler mevcut." -ForegroundColor Green
}

try {
    Add-Content -Path $log -Value "[$(Get-Date)] KUTUPHANE KONTROLU: Toplam=$toplam, Mevcut=$mevcut, Eksik=$eksik"
} catch {}