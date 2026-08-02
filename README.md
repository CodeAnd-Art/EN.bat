# EN.bat

![EN](EN.png)

---

## 🇹🇷 TÜRKÇE

### Uyarı
⚠️ **Bu yazılım yalnızca sanal makine (VM) içinde test edilmelidir.**  
Ana cihazda çalıştırılırsa kendini durdurur ve uyarı verir.  
Kötü niyetli kullanımdan **geliştirici sorumlu değildir.**

### Tavsiye Edilen Windows Sürümleri
- **Windows 10** (sürüm 1903 ve üzeri) – Tam destek
- **Windows 11** – Tam destek
- **Windows Server 2016 / 2019 / 2022** – Desteklenir (test ortamı)
- **Windows 7 / 8.1** – Sınırlı destek (PowerShell sürümü eski olabilir)

> **Not:** PowerShell 5.1 veya üzeri önerilir.

### Bir Hata Oluşursa Ne Yapmalısınız?

1. **Log dosyasını kontrol edin:**  
   `C:\EN_Log.txt` ve `C:\EN_Tamir_Log.txt`

2. **Eksik dosyaları kontrol edin:**  
   `modul_kendi_tamir.ps1` eksik dosyaları otomatik oluşturur.

3. **Yönetici olarak çalıştırın:**  
   `EN.bat` dosyasına sağ tıklayıp **"Yönetici olarak çalıştır"** seçin.

4. **PowerShell sürümünü kontrol edin:**  
   `$PSVersionTable.PSVersion` komutu ile sürümü öğrenin. 5.1 veya üzeri olmalıdır.

5. **.NET Framework kontrolü:**  
   .NET Framework 4.8 veya üzeri yüklü olmalıdır.

6. **Antivirüs geçici olarak devre dışı bırakın:**  
   (VM içinde test ederken güvenlidir)

7. **VM ortamı kullanın:**  
   Bu yazılım yalnızca sanal makine içinde çalışır.

8. **Hata bildirimi:**  
   Eğer sorun devam ederse, aşağıdaki e-posta adresine log dosyalarını gönderin.

---

### Sorumluluk Reddi
Bu proje **eğitim ve eğlence amaçlıdır**.  
Sistem dosyalarını silme, kernel yeme gibi işlemler **yalnızca sanal makine içinde** gerçekleşir.  
Gerçek bir sistemde çalıştırılması **kesinlikle önerilmez** ve oluşabilecek her türlü hasardan **geliştirici sorumlu tutulamaz.**

---

### Geri Bildirim
📧 **E-posta:** [Daha Sonra Gelcek!]

---

## 🇬🇧 ENGLISH

### Warning
⚠️ **This software must only be tested inside a virtual machine (VM).**  
If run on a host system, it will stop itself and show a warning.  
**The developer is not responsible** for any malicious use.

### Recommended Windows Versions
- **Windows 10** (version 1903 and later) – Full support
- **Windows 11** – Full support
- **Windows Server 2016 / 2019 / 2022** – Supported (test environment)
- **Windows 7 / 8.1** – Limited support (older PowerShell version)

> **Note:** PowerShell 5.1 or later is recommended.

### What to Do If an Error Occurs

1. **Check the log files:**  
   `C:\EN_Log.txt` and `C:\EN_Tamir_Log.txt`

2. **Check for missing files:**  
   `modul_kendi_tamir.ps1` automatically creates missing files.

3. **Run as administrator:**  
   Right-click `EN.bat` and select **"Run as administrator"**.

4. **Check PowerShell version:**  
   Run `$PSVersionTable.PSVersion` to check the version. It must be 5.1 or later.

5. **Check .NET Framework:**  
   .NET Framework 4.8 or later must be installed.

6. **Temporarily disable antivirus:**  
   (Safe while testing in a VM)

7. **Use a VM environment:**  
   This software only runs inside a virtual machine.

8. **Report the issue:**  
   If the problem persists, send the log files to the email address below.

---

### Disclaimer
This project is for **educational and entertainment purposes only**.  
Actions like deleting system files or eating the kernel **only happen inside a VM**.  
Running this on a real system is **strongly discouraged**, and the **developer cannot be held responsible** for any damage caused.

---

### Feedback
📧 **Email:** [Coming Soon!]