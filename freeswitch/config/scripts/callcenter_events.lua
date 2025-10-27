-- callcenter_events.lua
-- Real-time call center event monitoring

api = freeswitch.API()

function onCallCenterEvent(event)
    local action = event:getHeader("CC-Action")
    local queue = event:getHeader("CC-Queue")
    local agent = event:getHeader("CC-Agent")
    local member = event:getHeader("CC-Member-UUID")
    
    if action == "agent-status-change" then
        local status = event:getHeader("CC-Agent-Status")
        freeswitch.consoleLog("INFO", "Agent " .. agent .. " status changed to: " .. status .. "\n")
    
    elseif action == "agent-state-change" then
        local state = event:getHeader("CC-Agent-State")
        freeswitch.consoleLog("INFO", "Agent " .. agent .. " state changed to: " .. state .. "\n")
    
    elseif action == "member-queue-start" then
        local cid_name = event:getHeader("CC-Member-CID-Name")
        local cid_number = event:getHeader("CC-Member-CID-Number")
        freeswitch.consoleLog("INFO", "Caller " .. cid_number .. " entered queue: " .. queue .. "\n")
    
    elseif action == "member-queue-end" then
        local cause = event:getHeader("CC-Cause")
        local reason = event:getHeader("CC-Cancel-Reason")
        freeswitch.consoleLog("INFO", "Caller left queue: " .. queue .. " - Cause: " .. cause .. " Reason: " .. (reason or "N/A") .. "\n")
    
    elseif action == "bridge-agent-start" then
        freeswitch.consoleLog("INFO", "Agent " .. agent .. " bridged with caller in queue: " .. queue .. "\n")
    
    elseif action == "bridge-agent-end" then
        freeswitch.consoleLog("INFO", "Agent " .. agent .. " call ended in queue: " .. queue .. "\n")
    end
end

-- Subscribe to callcenter events
freeswitch.bgapi("event", "plain ALL")

-- Event processing loop
while true do
    local event = freeswitch.Event("custom", "callcenter::info")
    local e = freeswitch.EventConsumer("all")
    local event = e:pop(1000)
    
    if event then
        local event_name = event:getHeader("Event-Name")
        local subclass = event:getHeader("Event-Subclass")
        
        if event_name == "CUSTOM" and subclass == "callcenter::info" then
            onCallCenterEvent(event)
        end
    end
end