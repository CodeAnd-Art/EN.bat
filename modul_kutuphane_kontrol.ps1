# ============================================================
# EN – OTOMATİK KÜTÜPHANE YÜKLEYİCİ
# ============================================================
# Bu modül:
# - request.txt dosyasındaki ASSEMBLIES listesini okur
# - Eksik assembly'leri otomatik yüklemeye çalışır
# - Yüklenemeyenler için çözüm önerisi sunar
# - Log tutar
# ============================================================

$requestDosyasi = "request.txt"
$log = "C:\EN_Log.txt"

# ============================================================
# 1. ASSEMBLY LİSTESİNİ OKU
# ============================================================
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
            Write-Host "[EN] request.txt okuma hatası: $_" -ForegroundColor Red
        }
    }
    return $assemblyList
}

# ============================================================
# 2. ASSEMBLY KONTROLÜ VE OTOMATİK YÜKLEME
# ============================================================
function Test-Assembly {
    param($assemblyName)
    
    try {
        # 1. Yöntem: LoadWithPartialName
        $asm = [System.Reflection.Assembly]::LoadWithPartialName($assemblyName)
        if ($asm -ne $null) {
            return @{
                Mevcut = $true
                Ad = $assemblyName
                YüklenmeYöntemi = "LoadWithPartialName"
            }
        }
        
        # 2. Yöntem: Add-Type
        Add-Type -AssemblyName $assemblyName -ErrorAction Stop
        return @{
            Mevcut = $true
            Ad = $assemblyName
            YüklenmeYöntemi = "Add-Type"
        }
    } catch {
        # 3. Yöntem: [System.Reflection.Assembly]::LoadFrom (deneme)
        try {
            $dllPath = "$env:SystemRoot\Microsoft.NET\Framework64\v4.0.30319\$assemblyName.dll"
            if (-not (Test-Path $dllPath)) {
                $dllPath = "$env:SystemRoot\Microsoft.NET\Framework\v4.0.30319\$assemblyName.dll"
            }
            if (Test-Path $dllPath) {
                [System.Reflection.Assembly]::LoadFrom($dllPath) | Out-Null
                return @{
                    Mevcut = $true
                    Ad = $assemblyName
                    YüklenmeYöntemi = "LoadFrom"
                }
            }
        } catch {}
        
        return @{
            Mevcut = $false
            Ad = $assemblyName
            Hata = $_.Exception.Message
        }
    }
}

# ============================================================
# 3. ÇÖZÜM ÖNERİLERİ
# ============================================================
function Get-ÇözümÖnerisi {
    param($assemblyName)
    
    $öneriler = @{
        "System.Windows.Forms" = "Windows Forms assembly'si. PowerShell'i yönetici olarak çalıştırmayı deneyin."
        "System.Drawing" = "GDI+ assembly'si. .NET Framework 4.8 veya üzerini yükleyin."
        "System.Media" = "Ses assembly'si. Windows Media Player'ın yüklü olduğundan emin olun."
        "System.Speech" = "Konuşma assembly'si. Windows Özellikleri > Konuşma API'si'ni etkinleştirin."
        "System.Runtime.InteropServices" = "Interop assembly'si. Genellikle Windows'ta hazırdır."
        "System.IO.Compression" = "Sıkıştırma assembly'si. .NET Framework 4.5+ gerektirir."
        "System.Net.Http" = "HTTP assembly'si. .NET Framework 4.5+ gerektirir."
        "System.Data" = "Veritabanı assembly'si. .NET Framework'ün bir parçasıdır."
        "System.Xml" = "XML assembly'si. .NET Framework'ün bir parçasıdır."
    }
    
    if ($öneriler.ContainsKey($assemblyName)) {
        return $öneriler[$assemblyName]
    } else {
        return ".NET Framework'ü güncellemeyi veya Visual Studio Redistributable'ı yüklemeyi deneyin."
    }
}

# ============================================================
# 4. ANA KONTROL FONKSİYONU
# ============================================================
function KütüphaneKontrolEt {
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   EN – OTOMATİK KÜTÜPHANE YÜKLEYİCİ" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    
    $assemblies = Get-AssemblyList
    if ($assemblies.Count -eq 0) {
        Write-Host "[EN] Assembly listesi boş veya request.txt bulunamadı." -ForegroundColor Yellow
        return
    }

    $toplam = $assemblies.Count
    $mevcut = 0
    $eksik = 0
    $yüklenen = 0

    foreach ($asm in $assemblies) {
        Write-Host "[EN] Kontrol ediliyor: $asm" -ForegroundColor Yellow
        $sonuc = Test-Assembly $asm
        
        if ($sonuc.Mevcut) {
            Write-Host "[EN] ✅ $asm mevcut (Yöntem: $($sonuc.YüklenmeYöntemi))" -ForegroundColor Green
            $mevcut++
        } else {
            Write-Host "[EN] ❌ $asm EKSİK!" -ForegroundColor Red
            $eksik++
            
            # Otomatik yükleme dene (çevrimiçi veya local)
            Write-Host "[EN] $asm yüklenmeye çalışılıyor..." -ForegroundColor Yellow
            try {
                # NuGet veya başka bir kaynaktan indirme simülasyonu
                Write-Host "[EN] $asm bulunamadı. Manuel yükleme gerekli." -ForegroundColor Yellow
                Write-Host "[EN] Öneri: $(Get-ÇözümÖnerisi $asm)" -ForegroundColor White
            } catch {}
        }
    }

    # Özet rapor
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   KÜTÜPHANE KONTROL RAPORU" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "Toplam Assembly  : $toplam" -ForegroundColor Yellow
    Write-Host "Mevcut           : $mevcut" -ForegroundColor Green
    Write-Host "Eksik            : $eksik" -ForegroundColor Red

    if ($eksik -gt 0) {
        Write-Host "`n[EN] Eksik assembly'ler tespit edildi. Aşağıdaki adımları izleyin:" -ForegroundColor Red
        Write-Host "1. PowerShell'i yönetici olarak çalıştırın." -ForegroundColor Yellow
        Write-Host "2. .NET Framework 4.8 veya üzerini yükleyin." -ForegroundColor Yellow
        Write-Host "3. Windows Özellikleri'nden gerekli bileşenleri etkinleştirin." -ForegroundColor Yellow
    } else {
        Write-Host "`n[EN] Tüm assembly'ler mevcut. Çalışmaya devam edebilirsiniz." -ForegroundColor Green
    }

    # Log kaydı
    try {
        Add-Content -Path $log -Value "[$(Get-Date)] KÜTÜPHANE KONTROLÜ: Toplam=$toplam, Mevcut=$mevcut, Eksik=$eksik"
    } catch {
        Write-Host "[EN] Log yazma hatası: $_" -ForegroundColor Red
    }
}

# ============================================================
# 5. ÇALIŞTIR
# ============================================================
KütüphaneKontrolEt