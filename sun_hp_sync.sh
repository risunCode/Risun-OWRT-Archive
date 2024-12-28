#!/bin/bash

timeout=5 
while true; do 
    adb devices | grep -w "device" > /dev/null
    if [ $? -eq 0 ]; then 
        adb shell date > /root/datemate
        hari=$(cat /root/datemate | cut -b 9-10)
        bulan=$(cat /root/datemate | cut -b 5-7)
        tahun=$(cat /root/datemate | cut -b 25-28)
        waktu=$(cat /root/datemate | cut -b 12-19)
        
        case $bulan in
            "Jan") bulan="01" ;;
            "Feb") bulan="02" ;;
            "Mar") bulan="03" ;;
            "Apr") bulan="04" ;;
            "May") bulan="05" ;;
            "Jun") bulan="06" ;;
            "Jul") bulan="07" ;;
            "Aug") bulan="08" ;;
            "Sep") bulan="09" ;;
            "Oct") bulan="10" ;;
            "Nov") bulan="11" ;;
            "Dec") bulan="12" ;;
            *) echo "Data bulan salah!"; exit 1 ;;
        esac
        
        case $hari in
            " 1") hari="01" ;;
            " 2") hari="02" ;;
            " 3") hari="03" ;;
            " 4") hari="04" ;;
            " 5") hari="05" ;;
            " 6") hari="06" ;;
            " 7") hari="07" ;;
            " 8") hari="08" ;;
            " 9") hari="09" ;;
            *) hari="${hari// /}" ;;
        esac
        
        date -s "$tahun.$bulan.$hari-$waktu"
        echo "Waktu berhasil disinkronkan."
        echo "script by risunCode."
        exit 0  
    else 
        echo "Perangkat ADB tidak terdeteksi. Menunggu $timeout detik untuk mencoba lagi..."
        sleep $timeout
    fi
done
