# Fix TTL OpenWRT
- Working start from Luci Ver 22.03

## Langkah utama
> [!NOTE]
> This method using Nftables.d (means only work on 22.03+ with fw4 support)
> Kalo bisa gunakan Browser selain Chrome!
> 1. Buka File Manager/TinyFM pada OpenWRT
> 2. Pergi ke etc > nftables.d > 10-custom-filter-chains.nft
> 3. Copy dan paste ke tempat yang sama (UNTUK BACKUP)

## Langkah kedua
> [!WARNING]
> 1. Buka dan edit file > 10-custom-filter-chains.nft
> 2. Tambahkan Script dibawah ini.
> 3. Jangan Lupa di save ya setelah paste.
```javascript
chain mangle_postrouting_ttl65 {
    type filter hook postrouting priority 300; policy accept;
    ip ttl set 65;
}

chain mangle_prerouting_ttl65 {
    type filter hook prerouting priority 300; policy accept;
    ip ttl set 65;
}
```
![image](https://github.com/user-attachments/assets/89584c07-c5ae-477f-a40c-c9fa7fa7dbf5)

## Langkah Terakhir
> [!IMPORTANT]
> Pergi ke terminal dan ketik: fw4 reload
> Hasilnya akan seperti ini, ttl 65
> Selesai !
![image](https://github.com/user-attachments/assets/58626a70-0021-46dd-a596-19ccc023978d)

## Frequently asked Question (FAQ)
> [!IMPORTANT]
> 1. Tanya : Apakah perlu untuk menyalakan OpenClash atau alat injek lain?
> 2. Jawab : Tidak perlu.
> 3. Tanya : Apa ini work untuk semua operator dengan paket unlimited?
> 4. Jawab : Ya itu dapat bekerja, jangan lupa bersyukur & semoga berhasil!

# End of this blog
- Last Edited by RisunTuru at: 23 September 2024