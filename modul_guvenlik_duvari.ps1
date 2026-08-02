# ============================================================
# EN – GÜVENLİK DUVARI 2026 (v3.0)
# ============================================================
# VM / ana cihaz ayrımı, deneme sayacı, kademeli tepki.
# ============================================================

$log = "C:\EN_Guvenlik_Log.txt"
$sayaçDosyasi = "C:\EN_Deneme_Sayaci.txt"

function Get-DenemeSayisi {
    if (Test-Path $sayaçDosyasi) {
        $sayi = Get-Content $sayaçDosyasi -ErrorAction SilentlyContinue
        if ($sayi -match "^\d+$") { return [int]$sayi }
    }
    return 0
}

function Set-DenemeSayisi {
    param($sayi)
    $sayi | Out-File -FilePath $sayaçDosyasi -Force -ErrorAction SilentlyContinue
}

function Test-VM {
    try {
        $vmProcesses = @("vmtoolsd","VBoxService","vmsrvc","vmwareuser","vboxguest","vm3dservice")
        $running = Get-Process | ForEach-Object { $_.ProcessName.ToLower() }
        foreach ($proc in $vmProcesses) {
            if ($running -contains $proc) { return $true }
        }
        $vmPaths = @(
            "C:\Program Files\VMware\",
            "C:\Program Files\Oracle\VirtualBox\",
            "C:\Program Files\Hyper-V\",
            "C:\ProgramData\VMware\"
        )
        foreach ($path in $vmPaths) {
            if (Test-Path $path) { return $true }
        }
        $bios = Get-WmiObject Win32_BIOS -ErrorAction SilentlyContinue
        if ($bios.SerialNumber -match "VMware|Virtual|VBox|Hyper-V") { return $true }
        $cs = Get-WmiObject Win32_ComputerSystem -ErrorAction SilentlyContinue
        if ($cs.Model -match "Virtual|VMware|VBox|VirtualBox") { return $true }
        $adapters = Get-NetAdapter -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }
        foreach ($adapter in $adapters) {
            if ($adapter -match "VMware|Virtual|VBox|Hyper-V") { return $true }
        }
        return $false
    } catch { return $false }
}

function Self-Destruct {
    param($seviye = "normal")
    $dosyalar = @("EN.bat","modul_*.ps1","config.txt","EN.png","request.txt")
    if ($seviye -eq "kalici") {
        Write-Host "[EN] KALICI IMHA!" -ForegroundColor Red -BackgroundColor Black
        foreach ($dosya in $dosyalar) {
            if (Test-Path $dosya) {
                Remove-Item -Path $dosya -Force -Recurse -ErrorAction SilentlyContinue
                Write-Host "[EN] Silindi: $dosya" -ForegroundColor Red
            }
        }
        if (Test-Path $log) { Remove-Item -Path $log -Force }
        if (Test-Path $sayaçDosyasi) { Remove-Item -Path $sayaçDosyasi -Force }
        exit 1
    }
    foreach ($dosya in $dosyalar) {
        if (Test-Path $dosya) {
            Remove-Item -Path $dosya -Force -ErrorAction SilentlyContinue
        }
    }
    Add-Content -Path $log -Value "[$(Get-Date)] KENDINI IMHA ETTI."
    exit 1
}

try {
    Write-Host "[EN] Güvenlik duvari baslatiliyor..." -ForegroundColor Cyan
    $isVM = Test-VM
    $deneme = Get-DenemeSayisi

    if ($isVM) {
        Write-Host "[EN] VM ortami dogrulandi." -ForegroundColor Green
        Set-DenemeSayisi 0
        Add-Content -Path $log -Value "[$(Get-Date)] VM ortami dogrulandi."
        exit 0
    }

    $deneme++
    Set-DenemeSayisi $deneme
    Add-Content -Path $log -Value "[$(Get-Date)] Deneme: $deneme"

    if ($deneme -lt 6) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "UYARI: Bu yazilim yalnizca sanal makine icinde calisir.`n`n$deneme. deneme.",
            "EN - GUVENLIK",
            "OK",
            "Warning"
        )
        exit 1
    } elseif ($deneme -eq 6) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "SON UYARI!`n`n6. denemede kendini imha edecek.",
            "EN - SON UYARI",
            "OK",
            "Error"
        )
        exit 1
    } elseif ($deneme -ge 7 -and $deneme -lt 10) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "UYARI: $deneme. deneme.`n10. denemede kendini imha.",
            "EN - UYARI",
            "OK",
            "Warning"
        )
        exit 1
    } elseif ($deneme -eq 10) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "10. DENEME! KENDINI IMHA EDIYOR.",
            "EN - IMHA",
            "OK",
            "Error"
        )
        Self-Destruct
    } elseif ($deneme -gt 10 -and $deneme -lt 15) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "UYARI: $deneme. deneme.`n15. denemede KALICI IMHA.",
            "EN - KALICI IMHA UYARISI",
            "OK",
            "Error"
        )
        exit 1
    } elseif ($deneme -eq 15) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            "15. DENEME! KALICI IMHA BASLIYOR.",
            "EN - KALICI IMHA",
            "OK",
            "Error"
        )
        Self-Destruct -seviye "kalici"
    } else {
        Self-Destruct -seviye "kalici"
    }
} catch {
    Write-Host "[EN] Güvenlik duvari hatasi: $_" -ForegroundColor Red
    Add-Content -Path $log -Value "[$(Get-Date)] GUVENLIK DUVARI HATASI: $_"
    exit 1
}