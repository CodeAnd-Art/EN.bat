# ============================================================
# EN – BAĞIMLILIK KONTROLÜ
# ============================================================

$log = "C:\EN_Log.txt"

function Test-Assembly {
    param($assemblyName)
    try {
        Add-Type -AssemblyName $assemblyName -ErrorAction Stop
        Write-Host "✅ $assemblyName mevcut." -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ $assemblyName eksik!" -ForegroundColor Red
        return $false
    }
}

function Test-PowerShellVersion {
    $psVersion = $PSVersionTable.PSVersion
    Write-Host "🔹 PowerShell Sürümü: $psVersion" -ForegroundColor Cyan
    if ($psVersion.Major -ge 5) {
        Write-Host "✅ PowerShell sürümü uygun." -ForegroundColor Green
        return $true
    } else {
        Write-Host "❌ PowerShell sürümü 5.1 veya üzeri olmalı!" -ForegroundColor Red
        return $false
    }
}

function Test-Admin {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    if ($isAdmin) {
        Write-Host "✅ Yönetici yetkisi var." -ForegroundColor Green
    } else {
        Write-Host "⚠️ Yönetici yetkisi yok! Bazı işlemler çalışmayabilir." -ForegroundColor Yellow
    }
    return $isAdmin
}

function Test-VM {
    try {
        $vmProcesses = @("vmtoolsd", "VBoxService", "vmsrvc", "vmwareuser")
        $running = Get-Process | ForEach-Object { $_.ProcessName.ToLower() }
        foreach ($proc in $vmProcesses) {
            if ($running -contains $proc) { return $true }
        }

        $vmPaths = @(
            "C:\Program Files\VMware\",
            "C:\Program Files\Oracle\VirtualBox\",
            "C:\Program Files\Hyper-V\"
        )
        foreach ($path in $vmPaths) {
            if (Test-Path $path) { return $true }
        }

        $bios = Get-WmiObject Win32_BIOS -ErrorAction SilentlyContinue
        if ($bios.SerialNumber -match "VMware|Virtual|VBox") { return $true }

        return $false
    } catch {
        return $false
    }
}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   EN – BAĞIMLILIK KONTROLÜ" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$tumTestler = @()

# PowerShell sürümü
$tumTestler += Test-PowerShellVersion

# .NET derlemeleri
$assemblies = @("System.Windows.Forms", "System.Drawing", "System.Media", "System.Speech")
foreach ($asm in $assemblies) {
    $tumTestler += Test-Assembly $asm
}

# Yönetici yetkisi
$tumTestler += Test-Admin

# VM tespiti
$isVM = Test-VM
if ($isVM) {
    Write-Host "✅ VM ortamı tespit edildi." -ForegroundColor Green
} else {
    Write-Host "⚠️ VM ortamı tespit edilmedi. Ana cihazda çalıştırılıyor olabilir!" -ForegroundColor Yellow
}
$tumTestler += $isVM

# Özet
Write-Host "============================================================" -ForegroundColor Cyan
$basarili = ($tumTestler | Where-Object { $_ -eq $true }).Count
$toplam = $tumTestler.Count
Write-Host "📊 Başarılı testler: $basarili / $toplam" -ForegroundColor Yellow

if ($basarili -eq $toplam) {
    Write-Host "✅ Tüm bağımlılıklar mevcut. EN başlatılabilir." -ForegroundColor Green
} else {
    Write-Host "❌ Bazı bağımlılıklar eksik! Lütfen requirements.txt dosyasını kontrol edin." -ForegroundColor Red
}

Add-Content -Path $log -Value "[$(Get-Date)] Bağımlılık kontrolü tamamlandı. Başarılı: $basarili / $toplam"