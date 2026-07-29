# ============================================================
# EN – ORTAM TESPITI (VM / ANA CIHAZ)
# ============================================================

function Test-VM {
    try {
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
        $bios = Get-WmiObject Win32_BIOS -ErrorAction SilentlyContinue
        if ($bios.SerialNumber -match "VMware|Virtual|VBox") { return $true }

        # 4. Sistem modeli
        $cs = Get-WmiObject Win32_ComputerSystem -ErrorAction SilentlyContinue
        if ($cs.Model -match "Virtual|VMware|VBox") { return $true }

        return $false
    } catch {
        return $false
    }
}

if (Test-VM) {
    Write-Host "VM ortami tespit edildi. Baslatiyorum..." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Ana cihaz tespit edildi. Uyari gosteriliyor..." -ForegroundColor Red
    exit 1
}