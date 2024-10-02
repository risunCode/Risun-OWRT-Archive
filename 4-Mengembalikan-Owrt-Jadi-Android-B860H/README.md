# Cara mengembalikan Android dari OpenWRT
> Device B860H V1/V2

## Langkah utama
![driver-aml](https://github.com/user-attachments/assets/8be07f81-fbcd-4577-bd67-19c509c7ff15)
> [!NOTE]
> Pastikan sudah terinstall driver amlogicnya
> 1. Boot ke openwrt
> 2. upload file uboot.bin dan bootloader.img 
> 3. upload ke folder: root
> 4. Lalu ke terminal owrt

## Method pertama
> [!NOTE]
> 1. ketik: cd
> 2. lalu pastekan ini:
```bash
dd if=uboot.bin of=/dev/bootloader
 ```
## Method kedua

> [!NOTE]
> 1. kalau error no space blablabla
> 2. pakai method kedua ini
```bash
dd if=bootloader.img | pv | dd of=/dev/mmcblk2
```
## Langkah kedua
 ![set-up-bootloader](https://github.com/user-attachments/assets/654b0504-c748-4a09-9b46-afca256f5162)
> [!WARNING]
> wajib sudah install driver ya.
> 1. Flash android pakai male to male (colok ke usb2)
> 2. Tunggu flashing selesai sampai reboot otomatis.
> 3. kalo udah selesai, cabut male2male dan colok adaptor stb

### Tahap finishing
> [!IMPORTANT]
> 1. tunggu android sampai booting.
> 2. Kalo terlalu lama, cabut adaptor (tunggu 5 detik)lalu colok lagi
> 3. Tunggu aja sampai selesai (first boot emang lama)
> 4. done
