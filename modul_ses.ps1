# ============================================================
# EN – SES KAOSU (RAHATSIZ EDİCİ FREKANSLAR)
# ============================================================

Add-Type -AssemblyName System.Media

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 500
$timer.Add_Tick({
    try {
        # 50-2000 Hz arası rastgele frekans
        $freq = Get-Random -Min 50 -Max 2000
        $dur = Get-Random -Min 50 -Max 400
        [System.Console]::Beep($freq, $dur)

        # Bazen sistem sesi
        if ((Get-Random -Min 1 -Max 5) -eq 1) {
            $sesler = @(
                [System.Media.SystemSounds]::Asterisk,
                [System.Media.SystemSounds]::Exclamation,
                [System.Media.SystemSounds]::Hand,
                [System.Media.SystemSounds]::Question
            )
            $sesler | Get-Random | ForEach-Object { $_.Play() }
        }
    } catch {}
})
$timer.Start()

while ($true) { Start-Sleep -Seconds 1 }