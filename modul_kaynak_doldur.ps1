# ============================================================
# EN – KAYNAK DOLDURMA (RAM / ROM / DISK %100)
# ============================================================

try {
    Write-Host "RAM, ROM ve Disk %100 dolduruluyor..." -ForegroundColor Magenta

    $tempFile = "C:\temp_fill.bin"
    $stream = [System.IO.File]::OpenWrite($tempFile)
    $stream.SetLength(1GB)
    $stream.Close()
    Write-Host "Disk: %100 dolu" -ForegroundColor Red
} catch {
    Write-Host "Disk doldurma hatasi: $_" -ForegroundColor Yellow
}

try {
    $ramList = @()
    for ($i=0; $i -lt 100; $i++) {
        $ramList += [string]::new('A', 10 * 1024 * 1024)
    }
    Write-Host "RAM: %100 dolu" -ForegroundColor Red
} catch {
    Write-Host "RAM doldurma hatasi: $_" -ForegroundColor Yellow
}

$log = "C:\EN_Log.txt"
Add-Content -Path $log -Value "[$(Get-Date)] Kaynak doldurma islemi tamamlandi."