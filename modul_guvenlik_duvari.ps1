# ============================================================
# EN – GÜVENLİK DUVARI (ANA CİHAZ KORUMASI)
# ============================================================

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

if (-not (Test-VM)) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show(
        "BU YAZILIM YALNIZCA SANAL MAKİNE İÇİNDE ÇALIŞIR!" +
        "`n`nAna cihazda çalıştırılmaya çalışıldı." +
        "`nGüvenlik nedeniyle işlem durduruldu.",
        "EN - GÜVENLİK DUVARI",
        "OK",
        "Error"
    )
    $log = "C:\EN_Guvenlik_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] ANA CIHAZDA CALISTIRILMA GIRISIMI ENGELLENDI."
    exit 1
}

Write-Host "Güvenlik duvarı geçildi. VM ortamı tespit edildi." -ForegroundColor Green
exit 0