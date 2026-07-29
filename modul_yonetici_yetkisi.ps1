# ============================================================
# EN – YÖNETİCİ YETKİSİ ALMA (SINIRLENINCE)
# ============================================================

try {
    Write-Host "EN: Sinirlendim! Yonetici yetkisini aliyorum..." -ForegroundColor Red

    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        $arguments = "-ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`""
        Start-Process powershell -Verb RunAs -ArgumentList $arguments
        exit
    }

    Write-Host "Yonetici yetkisi alindi." -ForegroundColor Green
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Yonetici yetkisi alindi."
} catch {
    Write-Host "Yonetici yetkisi alma hatasi: $_" -ForegroundColor Red
}