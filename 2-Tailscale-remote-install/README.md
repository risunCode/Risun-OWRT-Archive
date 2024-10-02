# Tailscale Install
> [!IMPORTANT]
> Tailscale - Untuk remote Perangkat openwrt dari jauh

## Langkah utama Instalasi Tailscale
![image](https://github.com/user-attachments/assets/4534a9c7-01c6-4939-bb8c-0cbe50b6a851)
> [!NOTE]
> 1. dowmload ipk disini https://github.com/asvow/luci-app-tailscale
> 2. Taruh/upload file .ipk di etc/root

## Langkah Kedua
![image](https://github.com/user-attachments/assets/c782c8c1-82cc-459b-9dc9-5e7f080ac479)
> [!WARNING]
> 1. Buka terminal dan ketik: opkg update
> 2. Kalau sudah selesai update
> 3. Selanjutnya ketik: cd

### Lanjutkan dengan menginstal file .ipk
- lalu Install sesuai dgn nama packagenya
- ketik: opkg install luci-app-tailscale_.ipk (sesuaikan)
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
