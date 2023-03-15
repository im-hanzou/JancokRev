#!/bin/bash
# Using GNU Parallel
# Copyright by L
# Anti encode-encode club, everyone has the right to be rich!

function ctrl_c() {
    echo ""
    echo "CTRL+C? Reversing Stopped!"
    total_domains=$(wc -l < reversed.txt | tr -d '[:space:]')
    echo "Total domains: $total_domains"
    exit 1
}
trap ctrl_c INT

cat << "EOF"
       __                       __   ____           
      / /___ _____  _________  / /__/ __ \___ _   __
 __  / / __ `/ __ \/ ___/ __ \/ //_/ /_/ / _ \ | / /
/ /_/ / /_/ / / / / /__/ /_/ / ,< / _, _/  __/ |/ / 
\____/\__,_/_/ /_/\___/\____/_/|_/_/ |_|\___/|___/  
                                                    
EOF
printf "                 Jancok Reverse IP\n"
printf "                 Github : im-hanzou\n\n"

read -p "IPS list file: " ip_list_file
read -p "Number of threads: " threads
touch reversed.txt

cat $ip_list_file | parallel -j $threads 'response=$(curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "url={}&submit=Check+Reverse+Ip+Domains" https://www.prepostseo.com/reverse-ip-domain-checker); if [[ "$response" == *"No domains found"* ]]; then echo "No domains found from {}"; elif [[ "$response" == *"Could not connect to host"* ]]; then echo "Could not connect to host for {}"; else domain=$(echo "$response" | grep -o "<td>.*</td>" | grep -o "[^<>]\+\.[^<>]\+"); if [ ! -z "$domain" ]; then echo "$domain" >> reversed.txt; count=$(echo "$domain" | wc -l); echo "We got $count domains from {}"; else echo "No domains found from {}"; fi; fi'

total_domains=$(wc -l < reversed.txt | tr -d '[:space:]')
echo "TOTAL DOMAINS: $total_domains"
