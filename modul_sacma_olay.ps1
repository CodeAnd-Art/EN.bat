# ============================================================
# EN – SACMA OLAY
# ============================================================

$sacmaOlaylar = @(
    "EN: Bir kedi pencereyi tirmaliyor!",
    "EN: Bilgisayarinda gizli bir fare var!",
    "EN: Seninle oyun oynamak istiyorum!",
    "EN: Bu bir sabah kazasi!",
    "EN: Tuvalete gidiyorum, 5 dakika sonra gelirim.",
    "EN: Bugun cok mutluyum, neden biliyor musun? Cunku sen varsin!",
    "EN: Bilgisayarin seninle gurur duyuyor.",
    "EN: Eger bu mesaji okuduysan, EN'yi sevindirdin.",
    "EN: Simdi dans etme zamani!",
    "EN: Seninle tanistigima memnun oldum.",
    "EN: Hata? Ne hatasi? Ben hatasizim.",
    "EN: Cok guzel bir gun. Hadi eglenelim!",
    "EN: Bilgisayarini sev, o da seni sevsin."
)

try {
    $seciliSacma = $sacmaOlaylar | Get-Random
    Write-Host "EN: $seciliSacma" -ForegroundColor Green
    $log = "C:\EN_Log.txt"
    Add-Content -Path $log -Value "[$(Get-Date)] Sacma olay: $seciliSacma"
} catch {
    Write-Host "Sacma olay hatasi: $_" -ForegroundColor Red
}