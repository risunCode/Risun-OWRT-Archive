#!/bin/bash

dtdir="/root/date"
initd="/etc/init.d"
nmfl="$(basename "$0")"
scver="1.0"

function stop_tunnel() {
    echo -e "${nmfl}: Tunnel sudah di stop"
    for service in openclash mihomo zerotier; do
        if [[ -f "$initd/$service" && $(uci -q get ${service}.config.enable) == "1" ]]; then
            "$initd/$service" stop && echo -e "${nmfl}: Stopping $service"
            sleep 5
        fi
    done
}
function sandal() {
    hari=$(cat "$dtdir" | cut -b 12-13)
    bulan=$(cat "$dtdir" | cut -b 15-17)
    tahun=$(cat "$dtdir" | cut -b 19-22)
    jam=$(cat "$dtdir" | cut -b 24-25)
    menit=$(cat "$dtdir" | cut -b 26-31)

    case $bulan in
        "Jan")
           bulan="01"
            ;;
        "Feb")
            bulan="02"
            ;;
        "Mar")
            bulan="03"
            ;;
        "Apr")
            bulan="04"
            ;;
        "May")
            bulan="05"
            ;;
        "Jun")
            bulan="06"
            ;;
        "Jul")
            bulan="07"
            ;;
        "Aug")
            bulan="08"
            ;;
        "Sep")
            bulan="09"
            ;;
        "Oct")
            bulan="10"
            ;;
        "Nov")
            bulan="11"
            ;;
        "Dec")
            bulan="12"
            ;;
        *)
           return

    esac

	date -u -s "$tahun"."$bulan"."$hari"-"$jam""$menit" > /dev/null 2>&1
	echo -e "${nmfl}: Set time to [ $(date) ]"
	logger "${nmfl}: Set time to [ $(date) ]"
}

ngecurl() {
    local attempt=1
    local max_attempts=10

    while [[ $attempt -le $max_attempts ]]; do
        if [[ $(curl -si ${cv_type} | grep -c 'Date:') == "1" ]]; then
            echo -e "${nmfl}: Konek ${cv_type} tersedia, melanjutkan tugas"
            logger "${nmfl}: Konek ${cv_type} tersedia, melanjutkan tugas"
            return 0
        else
            echo -e "${nmfl}: Gagal mengekstrak waktu, percobaan ke-$attempt"
            logger "${nmfl}: Gagal mengekstrak waktu, percobaan ke-$attempt"
            attempt=$((attempt + 1))
            sleep 3
        fi
    done

    if [[ "$2" == "cron" ]]; then
        echo -e "${nmfl}: mode cron terdeteksi dan koneksi ke ${cv_type} tidak tersedia setelah $max_attempts percobaan, melanjutkan tugas"
        logger "${nmfl}: mode cron terdeteksi dan koneksi ke ${cv_type} tidak tersedia setelah $max_attempts percobaan, melanjutkan tugas"
        stop_tunnel
        tun_start
    else
        echo -e "${nmfl}: Konek ke ${cv_type} tidak tersedia setelah $max_attempts percobaan"
        logger "${nmfl}: Konek ke ${cv_type} tidak tersedia setelah $max_attempts percobaan"
        sleep 3
        ngepink
    fi
}


tun_start() {
    echo -e "${nmfl}: Restarting VPN tunnels jika tersedia."
    zerotier_running=false
    pgrep -x "zerotier" > /dev/null && zerotier_running=true

    for service in openclash mihomo zerotier; do
        if [[ -f "$initd/$service" && $(uci -q get ${service}.config.enable) == "1" ]]; then
            [[ "$service" == "zerotier" && "$zerotier_running" == true ]] && sleep 5
            "$initd/$service" restart && echo -e "${nmfl}: Restarting $service"
        fi
    done
}

if [[ "$1" =~ ^https?:// ]]; then
    cv_type="$1"
elif [[ "$1" =~ \. ]]; then
    cv_type="http://$1"
else
    echo -e "=> Tambakan domain atau URL di belakang script!"
    exit 1
fi

echo -e "${nmfl}: Script v${scver}"
logger "${nmfl}: Script v${scver}"

[[ "$2" == "cron" ]] && stop_tunnel || { ngecurl; sandal; tun_start; }
