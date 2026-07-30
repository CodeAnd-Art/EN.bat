Write-Host "[EN] Kamera açılıyor..." -ForegroundColor Red
Start-Sleep -Seconds 1
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Kamera açıldı.", "EN", "OK", "Warning")