# ============================================================
# EN – GÜVENLİK DUVARI (ANA CİHAZ KORUMASI)
# ============================================================

function Test-VM {
    # 1. VM işlemleri
    $vmProcesses = @("vmtoolsd", "VBoxService", "vmsrvc", "vmwareuser")
    $running = Get-Process | ForEach-Object { $_.ProcessName.ToLower() }
    foreach ($proc in $vmProcesses) {
        if ($running -contains $proc) { return $true }
    }

    # 2. VM klasörleri
    $vmPaths = @(
        "C:\Program Files\VMware\",
        "C:\Program Files\Oracle\VirtualBox\",
        "C:\Program Files\Hyper-V\"
    )
    foreach ($path in $vmPaths) {
        if (Test-Path $path) { return $true }
    }

    # 3. BIOS bilgisi
    try {
        $bios = Get-WmiObject Win32_BIOS
        if ($bios.SerialNumber -match "VMware|Virtual|VBox") { return $true }
    } catch {}

    # 4. Sistem bilgisi (ekstra kontrol)
    try {
        $cs = Get-WmiObject Win32_ComputerSystem
        if ($cs.Model -match "Virtual|VMware|VBox") { return $true }
    } catch {}

    return $false
}

if (-not (Test-VM)) {
    # Ana cihaz uyarısı
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show(
        "BU YAZILIM YALNIZCA SANAL MAKİNE İÇİNDE ÇALIŞIR!" +
        "`n`nAna cihazda çalıştırılmaya çalışıldı." +
        "`nGüvenlik nedeniyle işlem durduruldu." +
        "`n`nLog: C:\EN_Guvenlik_Log.txt",
        "EN - GÜVENLİK DUVARI",
        "OK",
        "Error"
    )

    # Log kaydı
    $log = "C:\EN_Guvenlik_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] ANA CIHAZDA CALISTIRILMA GIRISIMI ENGELLENDI."

    exit 1
}

Write-Host "Güvenlik duvarı geçildi. VM ortamı tespit edildi." -ForegroundColor Green
exit 0