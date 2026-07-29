# ============================================================
# EN – YÖNETİCİ YETKİSİ ALMA (SİNİRLENİNCE)
# ============================================================

Write-Host "EN: Sinirlendim! Yönetici yetkisini alıyorum..." -ForegroundColor Red

# UAC ile yönetici yetkisi iste
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "-ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`""
    Start-Process powershell -Verb RunAs -ArgumentList $arguments
    exit
}

Write-Host "Yönetici yetkisi alındı." -ForegroundColor Green