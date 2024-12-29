## otomatis sinkron jam menggunakan modem hp, tanpa bug
> [!IMPORTANT]
> Credit to : risunturu

## Langkah utama
> [!NOTE]
> Buka Terminal openwrt dan pastekan.
```bash
wget --no-check-certificate "https://raw.githubusercontent.com/risunCode/Risun-OWRT-Archive/refs/heads/main/sun_hp_sync.sh" -O /usr/bin/sun_hp_sync.sh && chmod +x /usr/bin/sun_hp_sync.sh
```
## Langkah terakhir
> [!WARNING]
> Buka System OpenWRT > Local Startup.
> ![image](https://github.com/user-attachments/assets/a1fa7bb3-269b-4b68-81f7-ac756c5a9783)
- Taruh script ini sebelum exit 0
```javascript
sleep 5 && /etc/init.d/ttyd restart && sleep 3 && chmod +x /usr/bin/sun_hp_sync.sh && sun_hp_sync.sh
```

> [!NOTE]
> **Khusus untuk vmess auto sinkron**      
> Terakhir diubah oleh : RisunTuru
> pada : 4 Oktober 2024    
