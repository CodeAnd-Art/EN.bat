# ============================================================
# EN – DİL DESTEK MODÜLÜ (GÜNCELLENDİ)
# ============================================================

try {
    $kultur = (Get-WinSystemLocale).Name
    if ($kultur -like "tr*") { $dil = "tr" } else { $dil = "en" }
} catch { $dil = "en" }

$mesajlar = @{
    tr = @{
        kustum = "EN: Küstüm! Kernel yiyorsun!"
        kustum_baslik = "EN - KÜSTÜM"
        kustum_detay = "EN.bat'i silmeye mi çalışıyorsun? Bu çok ayıp!"
        kernel_uyari = "KERNEL SİLİNİYOR! Bu işlem VM'yi öldürür."
        hakaret_uyari = "Çok ağır hakaret algılandı! Sert tepki veriliyor..."
        saka = "Şaka yaptım! Hiçbir şey silinmedi."
        pislik_cezasi = "SINIR AŞILDI! PİSLİK CEZASI BAŞLIYOR..."
        mutlu = "EN: Mutluyum!"
        orta_mutlu = "EN: Orta seviye mutluyum."
        sinirli = "EN: Sinirliyim!"
        kizgin = "EN: KIZGINIM!"
        kernel_bitti = "VM TAMAMEN YOK EDİLDİ!"
        kernel_uyari2 = "Bu VM bir daha açılmaz."
    }
    en = @{
        kustum = "EN: I'm offended! Kernel will be eaten!"
        kustum_baslik = "EN - OFFENDED"
        kustum_detay = "Are you trying to delete EN.bat? That's rude!"
        kernel_uyari = "KERNEL DELETED! This will destroy the VM."
        hakaret_uyari = "Severe insult detected! Strong reaction..."
        saka = "Just kidding! Nothing was deleted."
        pislik_cezasi = "LIMIT EXCEEDED! PUNISHMENT STARTED..."
        mutlu = "EN: Happy!"
        orta_mutlu = "EN: Moderately happy."
        sinirli = "EN: Angry!"
        kizgin = "EN: FURIOUS!"
        kernel_bitti = "VM COMPLETELY DESTROYED!"
        kernel_uyari2 = "This VM will never boot again."
    }
}

function Get-Mesaj {
    param($anahtar)
    return $mesajlar[$dil][$anahtar]
}