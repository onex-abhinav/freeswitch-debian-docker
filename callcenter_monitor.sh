#!/bin/bash

echo "FreeSWITCH Call Center Monitor"
echo "=============================="

while true; do
    clear
    echo "$(date) - Call Center Status"
    echo "=============================="
    
    # Agent Status
    echo ""
    echo "AGENT STATUS:"
    echo "-------------"
    fs_cli -x "callcenter_config agent list" | grep -E "agent(7001|7002|8001|8002|9001|9002)" | while read line; do
        agent=$(echo $line | awk '{print $1}')
        status=$(echo $line | awk '{print $3}')
        state=$(echo $line | awk '{print $5}')
        calls=$(echo $line | awk '{print $7}')
        echo "$agent: Status=$status, State=$state, Calls=$calls"
    done
    
    # Queue Status
    echo ""
    echo "QUEUE STATUS:"
    echo "-------------"
    fs_cli -x "callcenter_config queue list" | grep -E "(sbi|hdfc|axis)" | while read line; do
        queue=$(echo $line | awk '{print $1}')
        strategy=$(echo $line | awk '{print $3}')
        waiting=$(echo $line | awk '{print $5}')
        agents=$(echo $line | awk '{print $7}')
        echo "$queue: $waiting waiting, $agents agents (Strategy: $strategy)"
    done
    
    # Queue Members
    echo ""
    echo "QUEUE MEMBERS:"
    echo "--------------"
    for queue in sbi_sales sbi_marketing sbi_accounts hdfc_sales axis_sales; do
        count=$(fs_cli -x "callcenter_config queue count members $queue" | grep -o '[0-9]\+')
        if [ "$count" -gt "0" ]; then
            echo "$queue: $count callers waiting"
            fs_cli -x "callcenter_config queue list members $queue" | grep -v "UUID" | while read member; do
                if [ ! -z "$member" ]; then
                    echo "  - $member"
                fi
            done
        fi
    done
    
    # Active Calls
    echo ""
    echo "ACTIVE CALLS:"
    echo "-------------"
    fs_cli -x "show calls" | grep -E "total|UUID" | head -10
    
    sleep 5
done