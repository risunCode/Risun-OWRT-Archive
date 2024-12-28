#!/bin/bash

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
    *) echo "data salah!"; exit 1 ;;
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
