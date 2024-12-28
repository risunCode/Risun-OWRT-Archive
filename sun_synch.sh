#!/bin/bash

dtdir="/root/date"
initd="/etc/init.d"
nmfl="$(basename "$0")"
scver="1.0"

function nyetop() {
	stopvpn="${nmfl}: Stopping"  
	    echo -e "${nmfl}: Tunnel sudah di stop"
    for service in openclash mihomo zerotier; do
        if [[ -f "$initd/$service" && $(uci -q get ${service}.config.enable) == "1" ]]; then
            "$initd/$service" stop && echo -e "${nmfl}: Stopping $service"
        fi
    done
}

stop_tunnel() {
    echo -e "${nmfl}: Stopping Tunnel sudah di stop"
    for service in openclash mihomo zerotier; do
        if [[ -f "$initd/$service" && $(uci -q get ${service}.config.enable) == "1" ]]; then
            "$initd/$service" stop && echo -e "${nmfl}: Stopping $service"
        fi
    done
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

ngecurl() {
    [[ -z "$cv_type" ]] && { echo -e "${nmfl}: Error: cv_type is not set."; exit 1; }
    curl -si "$cv_type" | grep Date > "$dtdir"
    echo -e "${nmfl}: Gas $cv_type sebagai server waktu."
    logger "${nmfl}: Gas $cv_type sebagai server waktu."

    if read hari bulan tahun jam menit < <(awk '{print $3, $2, $6, $4}' "$dtdir"); then
        bulan=$(date -d "01 $bulan 2000" '+%m')
        if date -u -s "$tahun-$bulan-$hari $jam:$menit" > /dev/null 2>&1; then
            echo -e "${nmfl}: Set time to [ $(date) ]"
        else
            echo -e "${nmfl}: Error setting date and time."
            logger "${nmfl}: Error setting date and time."
        fi
    else
        echo -e "${nmfl}: Error reading date from file."
    fi
}

ngepink() {
    max_retry=5
    attempt=1
    while [[ $attempt -le $max_retry ]]; do
        if curl -si "$cv_type" | grep -q 'Date:'; then
            echo -e "${nmfl}: Konek ${cv_type} tersedia, melanjutkan tugas"
            logger "${nmfl}: Konek ${cv_type} tersedia, melanjutkan tugas"
            break
        else
            echo -e "${nmfl}: Koneksi gagal, mencoba lagi..."
            ((attempt++))
            sleep 3
        fi
    done
    if [[ $attempt -gt $max_retry ]]; then
        echo -e "${nmfl}: Gagal terhubung ke $cv_type setelah $max_retry percobaan."
        exit 1
    fi
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

[[ "$2" == "cron" ]] && ngepink || { stop_tunnel; ngepink; ngecurl; tun_start; }
