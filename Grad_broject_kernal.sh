#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
pcap_file="/home/ahmedomar/Downloads/capture.pcap"

extract_top_5_dest_ip() {
    # extract all ip destionations 
    sudo tshark -r "${pcap_file}" -T fields -e ip.dst > ip_dest.txt

    # remove white spaces in txt
    sed -i '/^$/d;s/[[:blank:]]//g' ip_dest.txt

    python3 Hashmap.py ip_dest.txt

    cat top_dest_ips.txt

    rm ip_dest.txt top_dest_ips.txt
}


extract_top_5_source_ip() {
    # extract all ip destionations 
    sudo tshark -r "${pcap_file}" -T fields -e ip.src > ip_src.txt

    # remove white spaces in txt
    sed -i '/^$/d;s/[[:blank:]]//g' ip_src.txt

    python3 Hashmap.py ip_src.txt

    cat top_source_ips.txt

    rm ip_src.txt top_source_ips.txt
}

total_packet () {
    sudo tshark -r "${pcap_file}" -T fields -e ip.dst > ip_dest.txt

    # counting the lines (total packer)

    wc -l < ip_dest.txt

    rm ip_dest.txt
}

your_http_packets() {
    # Count the number of HTTP packets
    packet_count=$(sudo tshark -r "${pcap_file}" -Y http | wc -l)

    # Check if the count is zero
    if (( packet_count == 0 )); then
        echo 'no packets for this protocol'
    else
        echo "HTTP packets found: $packet_count"
    fi
}

your_https_packets() {
    # Count the number of HTTPS packets
    packet_count=$(sudo tshark -r "${pcap_file}" -Y https | wc -l)

    # Check if the count is zero
    if (( packet_count == 0 )); then
        echo 'no packets for this protocol'
    else
        echo "HTTP packets found: $packet_count"
    fi
}


# Function to extract information from the pcap file
analyze_traffic() {
    # Use sudo tshark or similar commands for packet analysis.
    # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
    # extract IP addresses, and generate summary statistics.

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    # Provide summary information based on your analysis
    # Hints: Total packets, protocols, top source, and destination IP addresses.
    echo "1. Total Packets: [your_total_packets]"
    total_packet
    echo "2. Protocols:"
    echo "   - HTTP: [your_http_packets] packets"
    your_http_packets
    echo "   - HTTPS/TLS: [your_https_packets] packets"
    your_https_packets
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    echo "[your_top_source_ips]"
    extract_top_5_source_ip
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresses
    echo "[your_top_dest_ips]"
    extract_top_5_dest_ip
    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic



