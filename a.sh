#!/bin/bash
while true; do
    echo "Network information menu:"
    echo "1) Show network connections and listening ports"
    echo "2) Show network usage"
    echo "3) Show routing table"
    echo "4) Show network interface details"
    echo "5) Show connections with an especific protocol"
    echo "6) Exit"
    read option
    case $option in
        1)
            echo "Showing listening ports and services:"
            netstat -tuln
        ;;
        2)
            echo "Network stadistics: "
            netstat -i
        ;;
        3)
            echo "Routing table:"
            route -n
        ;;
        4)
            echo "Network interface details"
            ethtool eth1
        ;;
        5)
            echo "Select protocol:"
            echo "1. UDP"
            echo "2. TCP"
            read protocol
            case $protocol in
                1)
                    echo "TCP Connections: "
                    netstat -tan
                ;;
                2)
                    echo "UDP Connections: "
                    netstat -uan
                ;;
                *)
                    echo "Invalid Protocol Option"
                ;;
            esac
        ;;
        6)
            echo "Killing Program..."
            break
        ;;
        *)
            echo "Invalid Option"
        ;;
    esac
done
