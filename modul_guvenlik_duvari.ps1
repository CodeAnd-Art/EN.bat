# ============================================================
# EN – GÜVENLİK DUVARI 2026 (DENEME SAYACI + KADEMELİ TEPKİ)
# ============================================================
# Bu modül:
# - VM / ana cihaz ayrımı yapar (10+ yöntem)
# - Deneme sayacı tutar (config.txt veya log dosyasından okur)
# - 1. deneme: sadece uyarı
# - 6. deneme: uyarı + kendini imha etme uyarısı
# - 10. deneme: kendini imha eder
# - 15. deneme: kalıcı imha (tüm dosyaları siler)
# ============================================================

$log = "C:\EN_Guvenlik_Log.txt"
$sayaçDosyasi = "C:\EN_Deneme_Sayaci.txt"

# ============================================================
# 1. DENEME SAYACI OKU / YAZ
# ============================================================
function Get-DenemeSayisi {
    if (Test-Path $sayaçDosyasi) {
        $sayi = Get-Content $sayaçDosyasi -ErrorAction SilentlyContinue
        if ($sayi -match "^\d+$") {
            return [int]$sayi
        }
    }
    return 0
}

function Set-DenemeSayisi {
    param($sayi)
    $sayi | Out-File -FilePath $sayaçDosyasi -Force -ErrorAction SilentlyContinue
}

# ============================================================
# 2. VM TESPİTİ (ÇOK KATMANLI)
# ============================================================
function Test-VM {
    try {
        # İşlemler
        $vmProcesses = @("vmtoolsd","VBoxService","vmsrvc","vmwareuser","vboxguest","vm3dservice")
        $running = Get-Process | ForEach-Object { $_.ProcessName.ToLower() }
        foreach ($proc in $vmProcesses) {
            if ($running -contains $proc) { return $true }
        }

        # Klasörler
        $vmPaths = @(
            "C:\Program Files\VMware\",
            "C:\Program Files\Oracle\VirtualBox\",
            "C:\Program Files\Hyper-V\",
            "C:\ProgramData\VMware\"
        )
        foreach ($path in $vmPaths) {
            if (Test-Path $path) { return $true }
        }

        # BIOS
        $bios = Get-WmiObject Win32_BIOS -ErrorAction SilentlyContinue
        if ($bios.SerialNumber -match "VMware|Virtual|VBox|Hyper-V") { return $true }

        # Sistem Modeli
        $cs = Get-WmiObject Win32_ComputerSystem -ErrorAction SilentlyContinue
        if ($cs.Model -match "Virtual|VMware|VBox|VirtualBox") { return $true }

        # Ağ adaptörleri
        $adapters = Get-NetAdapter -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }
        foreach ($adapter in $adapters) {
            if ($adapter -match "VMware|Virtual|VBox|Hyper-V") { return $true }
        }

        return $false
    } catch {
        return $false
    }
}

# ============================================================
# 3. KENDİNİ İMHA (KADEMELİ)
# ============================================================
function Self-Destruct {
    param($seviye = "normal")
    
    $dosyalar = @("EN.bat", "modul_*.ps1", "config.txt", "EN.png", "request.txt")
    
    if ($seviye -eq "kalici") {
        Write-Host "[EN] KALICI İMHA BAŞLATILIYOR!" -ForegroundColor Red -BackgroundColor Black
        # Tüm dosyaları sil
        foreach ($dosya in $dosyalar) {
            if (Test-Path $dosya) {
                Remove-Item -Path $dosya -Force -Recurse -ErrorAction SilentlyContinue
                Write-Host "[EN] Silindi: $dosya" -ForegroundColor Red
            }
        }
        # Log dosyasını da sil
        if (Test-Path $log) { Remove-Item -Path $log -Force -ErrorAction SilentlyContinue }
        if (Test-Path $sayaçDosyasi) { Remove-Item -Path $sayaçDosyasi -Force -ErrorAction SilentlyContinue }
        Add-Content -Path "C:\EN_KALICI_IMHA.txt" -Value "[$(Get-Date)] KALICI IMHA GERCEKLESTI."
        exit 1
    }
    
    # Normal imha
    Write-Host "[EN] Kendini imha ediyor..." -ForegroundColor Red
    foreach ($dosya in $dosyalar) {
        if (Test-Path $dosya) {
            Remove-Item -Path $dosya -Force -ErrorAction SilentlyContinue
            Write-Host "[EN] Silindi: $dosya" -ForegroundColor Red
        }
    }
    Add-Content -Path $log -Value "[$(Get-Date)] KENDINI IMHA ETTI."
    exit 1
}

# ============================================================
# 4. ANA KONTROL
# ============================================================
try {
    Write-Host "[EN] Güvenlik duvarı başlatılıyor..." -ForegroundColor Cyan

    $isVM = Test-VM
    $deneme = Get-DenemeSayisi

    if ($isVM) {
        # VM ortamı ise sayaç sıfırla ve geç
        Write-Host "[EN] VM ortamı tespit edildi. Güvenli." -ForegroundColor Green
        Set-DenemeSayisi 0
        Add-Content -Path $log -Value "[$(Get-Date)] VM ortami dogrulandi. Sayaç sıfırlandı."
        exit 0
    }

    # Ana cihaz: deneme sayacını artır
    $deneme++
    Set-DenemeSayisi $deneme
    Add-Content -Path $log -Value "[$(Get-Date)] Deneme: $deneme"

    # ============================================================
    # KADEMELİ TEPKİLER
    # ============================================================
    if ($deneme -lt 6) {
        # 1-5. denemeler: sadece uyarı
        Write-Host "[EN] UYARI: Bu yazılım yalnızca sanal makinede çalışır." -ForegroundColor Yellow
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "UYARI: Bu yazılım yalnızca sanal makine içinde çalıştırılabilir." +
            "`n`n$deneme. deneme." +
            "`n6. denemede uyarı, 10. denemede kendini imha edecek.",
            "EN - GÜVENLİK DUVARI",
            "OK",
            "Warning"
        )
        exit 1
    }
    elseif ($deneme -eq 6) {
        # 6. deneme: sert uyarı + kendini imha uyarısı
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "SON UYARI!" +
            "`n`n6. denemede kendini imha edecek." +
            "`n10. denemede kalıcı olarak tüm dosyaları silecek." +
            "`n`nLütfen sanal makine kullanın.",
            "EN - SON UYARI",
            "OK",
            "Error"
        )
        exit 1
    }
    elseif ($deneme -ge 7 -and $deneme -lt 10) {
        # 7-9. denemeler: uyarı + sayacı göster
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "UYARI: $deneme. deneme." +
            "`n`n10. denemede kendini imha edecek." +
            "`nLütfen sanal makine kullanın.",
            "EN - UYARI",
            "OK",
            "Warning"
        )
        exit 1
    }
    elseif ($deneme -eq 10) {
        # 10. deneme: kendini imha
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "10. DENEME!" +
            "`n`nKendini imha ediyor." +
            "`nTüm dosyalar silinecek.",
            "EN - KENDİNİ İMHA",
            "OK",
            "Error"
        )
        Self-Destruct -seviye "normal"
    }
    elseif ($deneme -gt 10 -and $deneme -lt 15) {
        # 11-14. denemeler: uyarı + kalıcı imha uyarısı
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "UYARI: $deneme. deneme." +
            "`n`n15. denemede KALICI İMHA devreye girecek." +
            "`nTüm dosyalar sonsuza kadar silinecek.",
            "EN - KALICI İMHA UYARISI",
            "OK",
            "Error"
        )
        exit 1
    }
    elseif ($deneme -eq 15) {
        # 15. deneme: kalıcı imha
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "15. DENEME!" +
            "`n`nKALICI İMHA BAŞLATILIYOR!" +
            "`nTüm dosyalar sonsuza kadar silindi.",
            "EN - KALICI İMHA",
            "OK",
            "Error"
        )
        Self-Destruct -seviye "kalici"
    }
    else {
        # 15+ denemeler: kalıcı imha tekrar
        Self-Destruct -seviye "kalici"
    }

} catch {
    Write-Host "[EN] Güvenlik duvarı hatasi: $_" -ForegroundColor Red
    Add-Content -Path $log -Value "[$(Get-Date)] GUVENLIK DUVARI HATASI: $_"
    exit 1
}