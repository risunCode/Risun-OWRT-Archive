# Tailscale Install
> [!IMPORTANT]
> Tailscale - Untuk remote Perangkat openwrt dari jauh

## Langkah utama Instalasi Tailscale
![image](https://github.com/user-attachments/assets/4534a9c7-01c6-4939-bb8c-0cbe50b6a851)
> [!NOTE]
> 1. dowmload ipk disini https://github.com/asvow/luci-app-tailscale
> 2. Taruh/upload file .ipk di etc/root

## Langkah Kedua Lanjutkan dengan menginstal file .ipk
![image](https://github.com/user-attachments/assets/c782c8c1-82cc-459b-9dc9-5e7f080ac479)
> [!WARNING]
> 1. Buka terminal dan ketik:
```bash
opkg update && cd && opkg install *.ipk
```
- Tunggu hingga proses instalasi selesai.

## Langkah Terakhir (Update Tailscale)
![image](https://github.com/user-attachments/assets/853360e4-4297-4d1e-8c27-ca3beab51b92)
> [!NOTE]
> 1. ketik: tailscale update
> 2. Tunggu sampai selesai.
> 3. Restart OpenWRT / Tailscale Service di bagian System > startup

## End of this blog.
> [!WARNING]
> - This blog Written by RisunTuru
> - at: 24 Sept 2024
