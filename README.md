# EN.bat – Ultimate System Destroyer (Simülasyon)

![EN](EN.png)

---

## 🇹🇷 TÜRKÇE

### Açıklama
EN.bat, sanal makine (VM) içinde çalıştırılmak üzere tasarlanmış **interaktif bir kaos simülasyonudur**.  
Kullanıcıyla konuşur, sinirlenir, küfürlere tepki verir, sorular sorar, oyun oynatır ve en ufak hatada VM’nin kernelini siler.  
**Bu bir simülasyondur, gerçek sistemde çalıştırmayın!**

### Özellikler
- **VM / Ana Cihaz Ayrımı** – Ana cihazda çalışmaz, sadece VM içinde test edilebilir.
- **Sinir Seviyesi Sistemi** – `:)` → `D:<` → Kernel silme.
- **Konuşma Chat** – Küfür, hakaret, yakınlaşma tespiti ve anında tepki.
- **Görsel Bozulma** – Ekran patlamaları, glitch, negatif renk, pixsellesme.
- **Ses Efektleri** – Rahatsız edici frekanslar, sistem sesleri, Vİİİİİ patlaması.
- **Tehdit Sistemi** – 30+ farklı tehdit konuşması ve eylemleri (simülasyon).
- **Zero-Day Paneli** – Sahte exploit yükleme efekti.
- **Kendi Kendini Tamir** – Eksik dosyaları otomatik oluşturur.
- **Kütüphane Kontrolü** – Gerekli .NET assembly’lerini kontrol eder ve öneriler sunar.
- **Çok Dilli Destek** – Türkçe ve İngilizce.
- **Log Sistemi** – Tüm olaylar `C:\EN_Log.txt` dosyasına kaydedilir.

### Gereksinimler
- Windows 10 / 11 (VM içinde)
- PowerShell 5.1 veya üzeri
- Yönetici Yetkisi (VM içinde)
- .NET Framework 4.8 veya üzeri

### Kurulum
1. Bu repoyu ZIP olarak indirin veya klasörü kopyalayın.
2. Tüm dosyaları aynı klasöre yerleştirin.
3. `EN.bat` dosyasına çift tıklayın veya yönetici olarak çalıştırın.

### Çalıştırma
1. `EN.bat` çalıştırıldığında şifre sorar (varsayılan: `EN_I_am_not_happy_at_all_with_my_life/:(`).
2. Şifre doğruysa program başlar.
3. Tüm modüller arka planda çalışmaya başlar.
4. Program 8-10 dakika sonra kendiliğinden kapanır (süre `config.txt` dosyasından ayarlanabilir).

### Modül Yapısı
Proje, her biri ayrı bir işlevi yerine getiren 60+ modülden oluşur:

| Modül | Görevi |
|-------|--------|
| `modul_guvenlik_duvari.ps1` | VM / ana cihaz ayrımı, deneme sayacı, kendini imha |
| `modul_ayar_oku.ps1` | `config.txt` dosyasından tüm ayarları okur |
| `modul_kernel_ye.ps1` | Gerçek kernel silme (sadece VM içinde) |
| `modul_sistem_dosyasi_ye.ps1` | Sistem dosyalarını silme (simülasyon) |
| `modul_sinir_seviyesi.ps1` | Sinir sistemi ve diğer modülleri çağırır |
| `modul_chat.ps1` | Kullanıcıyla sohbet ve küfür/hakaret tespiti |
| `modul_tehdit_konusmasi.ps1` | 30+ tehdit mesajı ve eylemleri |
| `modul_kutuphane_kontrol.ps1` | Gerekli .NET assembly’lerini kontrol eder |
| `modul_kendi_tamir.ps1` | Eksik dosyaları otomatik oluşturur |

### Uyarı
⚠️ **Bu yazılım yalnızca sanal makine içinde test edilmelidir.**  
Ana cihazda çalıştırılırsa kendini durdurur ve uyarı verir.  
Kötü niyetli kullanımdan **geliştirici sorumlu değildir.**

### Sorumluluk Reddi
Bu proje **eğitim ve eğlence amaçlıdır**.  
Sistem dosyalarını silme, kernel yeme gibi işlemler **yalnızca sanal makine içinde** gerçekleşir.  
Gerçek bir sistemde çalıştırılması **kesinlikle önerilmez** ve oluşabilecek her türlü hasardan **geliştirici sorumlu tutulamaz.**

### Geri Bildirim ve Sorun Bildirimi
Herhangi bir sorun, hata veya öneriniz varsa lütfen aşağıdaki e-posta adresine yazın:

📧 **E-posta:** [E-POSTA ADRESİNİZİ BURAYA YAZIN]

---

## 🇬🇧 ENGLISH

### Description
EN.bat is an **interactive chaos simulation** designed to run inside a virtual machine (VM).  
It talks to the user, gets angry, reacts to swearing, asks questions, plays mini-games, and deletes the VM's kernel at the slightest mistake.  
**This is a simulation. Do not run on a real system!**

### Features
- **VM / Host Detection** – Does not run on host, only inside VM.
- **Anger Level System** – `:)` → `D:<` → Kernel delete.
- **Chat System** – Detects swearing, insults, affection and reacts.
- **Visual Distortion** – Screen explosions, glitch, negative color, pixelation.
- **Sound Effects** – Annoying frequencies, system sounds, Vİİİİİ explosion.
- **Threat System** – 30+ threat messages and actions (simulated).
- **Zero-Day Panel** – Fake exploit loading effect.
- **Self-Healing** – Automatically recreates missing files.
- **Library Check** – Checks required .NET assemblies and offers solutions.
- **Multi-Language** – Turkish and English.
- **Log System** – All events logged to `C:\EN_Log.txt`.

### Requirements
- Windows 10 / 11 (inside VM)
- PowerShell 5.1 or later
- Administrator Privileges (inside VM)
- .NET Framework 4.8 or later

### Installation
1. Download this repo as ZIP or copy the folder.
2. Place all files in the same folder.
3. Double-click `EN.bat` or run as administrator.

### How to Run
1. `EN.bat` will ask for a password (default: `EN_I_am_not_happy_at_all_with_my_life/:(`).
2. If the password is correct, the program starts.
3. All modules run in the background.
4. The program stops automatically after 8-10 minutes (duration can be adjusted in `config.txt`).

### Module Structure
The project consists of 60+ modules, each with a specific function:

| Module | Function |
|--------|----------|
| `modul_guvenlik_duvari.ps1` | VM / host detection, attempt counter, self-destruct |
| `modul_ayar_oku.ps1` | Reads all settings from `config.txt` |
| `modul_kernel_ye.ps1` | Real kernel deletion (VM only) |
| `modul_sistem_dosyasi_ye.ps1` | System file deletion (simulation) |
| `modul_sinir_seviyesi.ps1` | Anger system and module caller |
| `modul_chat.ps1` | Chat with user, swear/insult detection |
| `modul_tehdit_konusmasi.ps1` | 30+ threat messages and actions |
| `modul_kutuphane_kontrol.ps1` | Checks required .NET assemblies |
| `modul_kendi_tamir.ps1` | Automatically recreates missing files |

### Warning
⚠️ **This software must only be tested inside a virtual machine.**  
If run on a host system, it will stop itself and show a warning.  
**The developer is not responsible** for any malicious use.

### Disclaimer
This project is for **educational and entertainment purposes only**.  
Actions like deleting system files or eating the kernel **only happen inside a VM**.  
Running this on a real system is **strongly discouraged**, and the **developer cannot be held responsible** for any damage caused.

### Feedback & Bug Reports
If you encounter any issues, bugs, or have suggestions, please contact us at:

📧 **Email:** [YOUR EMAIL ADDRESS HERE]