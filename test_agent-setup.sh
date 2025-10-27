#!/bin/bash

echo "Testing Call Center Agent Setup"
echo "==============================="

# Test 1: Check if callcenter module is loaded
if fs_cli -x "module_exists mod_callcenter" | grep -q "true"; then
    echo "✓ mod_callcenter is loaded"
else
    echo "✗ mod_callcenter not loaded"
    exit 1
fi

# Test 2: Check queues
echo ""
echo "QUEUES:"
fs_cli -x "callcenter_config queue list" | grep -E "(sbi|hdfc|axis)"

# Test 3: Check agents
echo ""
echo "AGENTS:"
fs_cli -x "callcenter_config agent list" | grep -E "agent(7001|7002|8001|8002|9001|9002)"

# Test 4: Check tiers
echo ""
echo "TIERS:"
fs_cli -x "callcenter_config tier list" | head -10

# Test 5: Make all agents available
echo ""
echo "Making all agents available..."
fs_cli -x "callcenter_config agent set status agent7001 Available"
fs_cli -x "callcenter_config agent set status agent7002 Available"
fs_cli -x "callcenter_config agent set status agent8001 Available"
fs_cli -x "callcenter_config agent set status agent8002 Available"
fs_cli -x "callcenter_config agent set status agent9001 Available"
fs_cli -x "callcenter_config agent set status agent9002 Available"

# Set states to Waiting
fs_cli -x "callcenter_config agent set state agent7001 Waiting"
fs_cli -x "callcenter_config agent set state agent7002 Waiting"
fs_cli -x "callcenter_config agent set state agent8001 Waiting"
fs_cli -x "callcenter_config agent set state agent8002 Waiting"
fs_cli -x "callcenter_config agent set state agent9001 Waiting"
fs_cli -x "callcenter_config agent set state agent9002 Waiting"

echo ""
echo "Final Agent Status:"
fs_cli -x "callcenter_config agent list" | grep -E "agent(7001|7002|8001|8002|9001|9002)"

echo ""
echo "TEST COMMANDS:"
echo "=============="
echo "Agent Login:     Dial 7001login"
echo "Agent Ready:     Dial 7001ready" 
echo "Agent Break:     Dial 7001break"
echo "Agent Logout:    Dial 7001logout"
echo "All Available:   Dial allavailable"
echo ""
echo "Test Calls:"
echo "SBI Sales:       1800123451"
echo "SBI Marketing:   1800123452"
echo "SBI Accounts:    1800123453"
echo "SBI IVR:         1800123456"
echo ""
echo "Monitor:         /home/abhinav-jalluri/Videos/fs/freeswitch-debian-docker/callcenter_monitor.sh"