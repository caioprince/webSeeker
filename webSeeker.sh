#!/bin/bash

wordlist=""
url=""
user_agent="webSeeker"
output_file=""

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'
RED='\033[0;31m'

usage() {
    echo "Usage: $0 -w <wordlist> -u <url> [-a <user_agent>] [-o <output_file>]"
    echo "Examples:"
    echo "  $0 -w wordlist.txt -u http://example.com"
    echo "  $0 -w wordlist.txt -u http://example.com -a customAgent -o output.txt"
    exit 1
}

get_domain_info() {
    domain=$1
    echo -e "${GREEN}Getting information about the domain $domain...${NC}"
    whois "$domain" | grep -E "^(Registrar:|Domain:|Expires:)"
}

test_zone_transfer() {
    domain=$1
    echo -e "${CYAN}Testing zone transfer for $domain...${NC}"
    host -t ns "$domain" | cut -d " " -f4 | while read server; do host -l -a "$domain" "$server"; done
}

get_ip_range() {
    ip=$1
    echo -e "${GREEN}Getting IP range for $ip...${NC}"
    whois "$ip" | grep "inetnum"
}

scan_files_and_dirs() {
    domain=$1
    wordlist=$2
    output_file=$3
    total_lines=$(wc -l < "$wordlist")
    found_items=0
    current_line=0

    echo -e "${CYAN}[+] Initiating scan of directories and files..."
    echo -e "[+] URL: $domain"
    echo -e "[+] Wordlist: $wordlist"
    echo -e "[+] User Agent: $user_agent"

    if [ -n "$output_file" ]; then
        echo -e "[+] Output File: $output_file${NC}"
    else
        echo -e "${NC}"
    fi

    while read -r line; do
        ((current_line++))
        url="$domain/$line"

        echo -e -n "\r${CYAN}[+] Scanning in progress... [${GREEN}$current_line${CYAN}/$total_lines]${NC}"

        (
            http_code=$(curl -s -o /dev/null -w '%{http_code}' -H "User-Agent: $user_agent" "$url")

            if [ "$http_code" -ne 404 ] && [ "$http_code" -ne 000 ]; then
                ((found_items++))
                echo -e "\r${CYAN}[+] Scanning in progress... [${GREEN}$current_line${CYAN}/$total_lines]${NC}"
                echo -e "[${GREEN}$current_line${CYAN}/$total_lines] ${RED}URL Found: $url - HTTP Status: $http_code${NC}"

                if [ -n "$output_file" ]; then
                    echo "$url - HTTP Status: $http_code" >> "$output_file"
                fi
            fi
        ) &

        sleep 0.1
    done < "$wordlist"

    wait

    if [ -n "$output_file" ]; then
        echo -e "${GREEN}[+] Location of the output file: $output_file${NC}"
    fi
}

while getopts "w:u:a:o:" opt; do
    case $opt in
        w)
            wordlist="$OPTARG"
            ;;
        u)
            url="$OPTARG"
            ;;
        a)
            user_agent="$OPTARG"
            ;;
        o)
            output_file="$OPTARG"
            ;;
        \?)
            usage
            ;;
    esac
done

if [ -z "$wordlist" ] || [ -z "$url" ]; then
    usage
fi

get_domain_info "$url"
test_zone_transfer "$url"
ip_range=$(get_ip_range "$url")
scan_files_and_dirs "$url" "$wordlist" "$output_file"
