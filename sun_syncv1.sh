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

ngecurl() {
    [[ -z "$cv_type" ]] && { echo -e "${nmfl}: Error: cv_type is not set."; exit 1; }
    curl -si "$cv_type" | grep Date > "$dtdir"
    echo -e "${nmfl}: Gas $cv_type sebagai server waktu."
    logger "${nmfl}: Gas $cv_type sebagai server waktu."

    if read hari bulan tahun jam menit < <(awk '{print $3, $2, $6, $4}' "$dtdir"); then
        declare -A bulan_map=( ["Jan"]="01" ["Feb"]="02" ["Mar"]="03" ["Apr"]="04" ["May"]="05" ["Jun"]="06" ["Jul"]="07" ["Aug"]="08" ["Sep"]="09" ["Oct"]="10" ["Nov"]="11" ["Dec"]="12" )
        bulan=${bulan_map[$bulan]}
        if date -u -s "$tahun-$bulan-$hari $jam:$menit" > /dev/null 2>&1; then
            echo -e "${nmfl}: Set time to [ $(date) ]"
            logger "${nmfl}: Set time to [ $(date) ]"
        else
            echo -e "${nmfl}: Error setting date and time."
            logger "${nmfl}: Error setting date and time."
        fi
    else
        echo -e "${nmfl}: Error reading date from file."
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

[[ "$2" == "cron" ]] && stop_tunnel || { ngecurl; tun_start; }
