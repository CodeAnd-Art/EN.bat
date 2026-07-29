# ============================================================
# EN – MESAJ HAVUZU (100+ RASGELE MESAJ)
# ============================================================

$mesajHavuzu = @(
    "EN: Bugun hava cok guzel, degil mi?",
    "EN: Bilgisayarin seni seviyor.",
    "EN: Ben bir virüs degilim, sadece bir oyunum.",
    "EN: Bu mesaji okuyan herkes odasina saklansin.",
    "EN: Seni izliyorum... saka yapiyorum.",
    "EN: Eger bu mesaji okuduysan, EN'yi sevindirdin.",
    "EN: Dis fircalamayı unutma!",
    "EN: Kufur etme, sinirlenirim.",
    "EN: Bu bir test mesajidir. Panik yapma.",
    "EN: Sanal makine harika bir yer!",
    "EN: Bugun ne yapacaksin?",
    "EN: Benimle konusmak ister misin?",
    "EN: Eger sıkıldıysan, EN ile sohbet et.",
    "EN: Bu mesaj 100 milyonuncu kez okunuyor.",
    "EN: Seninle tanistigima memnun oldum.",
    "EN: Hata? Ne hatasi? Ben hatasizim.",
    "EN: Bu bir uyaridir. Ciddiye al.",
    "EN: Cok guzel bir gun. Hadi eglenelim!",
    "EN: Bilgisayarini sev, o da seni sevsin.",
    "EN: EN, her zaman yaninda."
)

function RastgeleMesaj {
    return $mesajHavuzu | Get-Random
}