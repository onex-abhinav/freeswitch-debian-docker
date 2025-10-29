# FreeSWITCH Call Center Setup Documentation

## Overview

This document describes the complete FreeSWITCH configuration for setting up an IVR menu system with call center queues and agent management for multiple departments.

## File Structure

### 1. IVR Menu Configuration

**File:** `/usr/local/freeswitch/conf/ivr_menus/sbi_ivr.xml`

```xml
<include>
    <menu name="sbi_ivr"
            greet-long="say:Welcome to One Metric. Press 1 for support, 2 for accounts, 3 for reception or 4 to join a confrence call"
            greet-short="say:Welcome to One Metric. Press 1 for support, 2 for accounts, 3 for reception or 4 to join a confrence call"
            invalid-sound="ivr/ivr-that_was_an_invalid_entry.wav"
            exit-sound="voicemail/vm-goodbye.wav"
            confirm-macro=""
            confirm-key=""
            tts-engine="flite"
            tts-voice="slt"
            confirm-attempts="3"
            timeout="3000"
            inter-digit-timeout="2000"
            max-failures="3"
            max-timeouts="3"
            digit-len="4">

            <entry action="menu-exec-app" digits="1" param="transfer 450 XML default"/>    <!-- SBI Sales -->
            <entry action="menu-exec-app" digits="2" param="transfer 451 XML default"/>    <!-- SBI Marketing -->
            <entry action="menu-exec-app" digits="3" param="transfer 452 XML default"/>    <!-- SBI Accounts -->
    </menu>
</include>
```

### 2. Dialplan Extensions

**File:** `/usr/local/freeswitch/conf/dialplan/default.xml`

Add the following extensions:

```xml
<!-- SBI IVR Menu Access -->
<extension name="sbi_ivr_menu">
    <condition field="destination_number" expression="^4000$">
        <action application="answer"/>
        <action application="sleep" data="2000"/>
        <action application="ivr" data="sbi_ivr"/>
    </condition>
</extension>

<!-- SBI Sales Queue -->
<extension>
    <condition field="destination_number" expression="^(450)$" break="true">
        <action application="set" data="caller_id_name=SBI Sales" />
        <action application="set" data="call_timeout=60" />
        <action application="set" data="originate_timeout=60" />
        <action application="callcenter" data="sbi_sales@default"/>
    </condition>
</extension>

<!-- SBI Marketing Queue -->
<extension>
    <condition field="destination_number" expression="^(451)$" break="true">
        <action application="set" data="caller_id_name=SBI Marketing" />
        <action application="callcenter" data="sbi_marketing@default"/>
    </condition>
</extension>

<!-- SBI Accounts Queue -->
<extension>
    <condition field="destination_number" expression="^(452)$" break="true">
        <action application="set" data="caller_id_name=SBI Accounts" />
        <action application="callcenter" data="sbi_accounts@default"/>
    </condition>
</extension>

<!-- Agent Login Extension -->
<extension name="agent_login">
    <condition field="destination_number" expression="^(453)$" break="true">
        <action application="set" data="res=${callcenter_config(agent set status ${caller_id_number} 'Available')}" />
        <action application="answer" data=""/>
        <action application="sleep" data="500"/>
        <action application="playback" data="ivr/ivr-you_are_now_logged_in.wav"/>
        <action application="hangup" data="NORMAL_CLEARING"/>
    </condition>
</extension>

<!-- Agent Logout Extension -->
<extension name="agent_logoff">
    <condition field="destination_number" expression="^301$" break="true">
        <action application="set" data="res=${callcenter_config(agent set status ${caller_id_number} 'Logged Out')}" />
        <action application="answer" data=""/>
        <action application="sleep" data="500"/>
        <action application="playback" data="ivr/ivr-you_are_now_logged_out.wav"/>
        <action application="hangup" data=""/>
    </condition>
</extension>
```

### 3. Call Center Configuration

**File:** `/usr/local/freeswitch/conf/autoload_configs/callcenter.conf.xml`

```xml
<configuration name="callcenter.conf" description="Call Center">
  <settings>
    <param name="dbname" value="/dev/shm/callcenter.db"/>
    <param name="truncate-agents-on-load" value="true"/>
    <param name="truncate-tiers-on-load" value="true"/>
  </settings>
  
  <queues>
    <!-- SBI Queues -->
    <queue name="sbi_sales@default">
      <param name="strategy" value="longest-idle-agent"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="time-base-score" value="system"/>
      <param name="max-wait-time" value="300"/>
      <param name="max-wait-time-with-no-agent" value="60"/>
      <param name="max-wait-time-with-no-agent-time-reached" value="10"/>
      <param name="discard-abandoned-after" value="60"/>
      <param name="abandoned-resume-allowed" value="false"/>
    </queue>
    
    <queue name="sbi_marketing@default">
      <param name="strategy" value="round-robin"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="time-base-score" value="queue"/>
      <param name="max-wait-time" value="300"/>
    </queue>
    
    <queue name="sbi_accounts@default">
      <param name="strategy" value="ring-all"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="time-base-score" value="system"/>
      <param name="ring-progressively-delay" value="5"/>
    </queue>

  <!-- Agents Configuration -->
  <agents>
    <!-- SBI Agents -->
    <agent name="7001" type="callback" contact="[call_timeout=60]user/7001" status="Logged Out" max-no-answer="3" wrap-up-time="10" reject-delay-time="5" busy-delay-time="30" />
    <agent name="7002" type="callback" contact="[call_timeout=60]user/7002" status="Logged Out" max-no-answer="3" wrap-up-time="10" reject-delay-time="5" busy-delay-time="30" />
    
  </agents>

  <!-- Tiers Configuration - Agent to Queue Mapping -->
  <tiers>
    <!-- SBI Tiers -->
    <tier agent="7001" queue="sbi_sales@default" level="1" position="1"/>
    <tier agent="7001" queue="sbi_marketing@default" level="2" position="1"/>
    <tier agent="7001" queue="sbi_accounts@default" level="3" position="1"/>
    
    <tier agent="7002" queue="sbi_sales@default" level="1" position="2"/>
    <tier agent="7002" queue="sbi_marketing@default" level="2" position="2"/>
    <tier agent="7002" queue="sbi_accounts@default" level="3" position="2"/>

  </tiers>
</configuration>
```

### 4. Agent Directory Configuration

**File:** `/usr/local/freeswitch/conf/directory/default/70XX.xml`

Example for agent 7001:

```xml
<include>
  <user id="7001">
    <params>
      <param name="password" value="$${default_password}"/>
      <param name="vm-password" value="7001"/>
    </params>
    <variables>
      <variable name="toll_allow" value="domestic,international,local"/>
      <variable name="accountcode" value="7001"/>
      <variable name="user_context" value="default"/>
      <variable name="effective_caller_id_name" value="Extension 7001"/>
      <variable name="effective_caller_id_number" value="7001"/>
      <variable name="outbound_caller_id_name" value="$${outbound_caller_name}"/>
      <variable name="outbound_caller_id_number" value="$${outbound_caller_id}"/>
      <variable name="callgroup" value="techsupport"/>
    </variables>
  </user>
</include>
```

## Usage Instructions

### For Callers

1. Dial **4000** to access the main IVR menu
2. Press **1** for Sales (routes to SBI Sales queue)
3. Press **2** for Marketing (routes to SBI Marketing queue)
4. Press **3** for Accounts (routes to SBI Accounts queue)

### Note

1. We can directly call the agent by dialing the number 
2. We can call the Queue which will redirect to Available agent
3. use unique agent numbers queue numbers and destination numbers 

### For Agents

- Dial **453** to log into all assigned queues
- Dial **301** to log out of all queues

## Important Notes

- **Database:** Call center uses SQLite database at `/dev/shm/callcenter.db`
- **Music on Hold:** All queues use `$${hold_music}` variable
- **Agent Types:** All agents are configured as "callback" type
- **Default Status:** Agents start as "Logged Out" and must login via extension 453

## Reload Configuration

After making changes, reload FreeSWITCH configurations:

```bash
fs_cli -x "reloadxml"
fs_cli -x "reload mod_callcenter"
```

---

## Configurations

1. **First, verify configuration:** 

``` 
   reloadxml

   reload mod_callcenter

   callcenter_config queue list 

   callcenter_config agent list 

   callcenter_config tier list 

   callcenter_config queue list agents sbi_sales@default

``` 

  

2. **Then, set agent status:** (Note We can change status by dialing the number in extension)

``` 

   callcenter_config agent set status 7001 'Available' 

   callcenter_config agent set status 7002 'Available' 

``` 


# If We Want Different Strategies then use these Strategies

# Queue Strategies
- we can use different strategies in queues for agents call routing 
```xml
<queues>
    <!-- SBI Queues with different strategies -->
    <queue name="sbi_sales@default">
      <param name="strategy" value="longest-idle-agent"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="time-base-score" value="system"/>
      <param name="max-wait-time" value="300"/>
      <param name="max-wait-time-with-no-agent" value="60"/>
      <param name="max-wait-time-with-no-agent-time-reached" value="10"/>
      <param name="discard-abandoned-after" value="60"/>
      <param name="abandoned-resume-allowed" value="false"/>
    </queue>
    
    <queue name="sbi_marketing@default">
      <param name="strategy" value="round-robin"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="time-base-score" value="queue"/>
      <param name="max-wait-time" value="300"/>
    </queue>
    
    <queue name="sbi_accounts@default">
      <param name="strategy" value="ring-all"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="time-base-score" value="system"/>
      <param name="ring-progressively-delay" value="5"/>
    </queue>

    <!-- HDFC Queues -->
    <queue name="hdfc_sales">
      <param name="strategy" value="agent-with-least-talk-time"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="time-base-score" value="system"/>
    </queue>
    
    <queue name="hdfc_marketing">
      <param name="strategy" value="top-down"/>
      <param name="moh-sound" value="$${hold_music}"/>
    </queue>
    
    <queue name="hdfc_accounts">
      <param name="strategy" value="sequentially-by-agent-order"/>
      <param name="moh-sound" value="$${hold_music}"/>
    </queue>

    <!-- AXIS Queues -->
    <queue name="axis_sales">
      <param name="strategy" value="random"/>
      <param name="moh-sound" value="$${hold_music}"/>
    </queue>
    
    <queue name="axis_marketing">
      <param name="strategy" value="agent-with-fewest-calls"/>
      <param name="moh-sound" value="$${hold_music}"/>
    </queue>
    
    <queue name="axis_accounts">
      <param name="strategy" value="ring-progressively"/>
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="ring-progressively-delay" value="8"/>
    </queue>
  </queues>
```

## Queue Strategies Explained

| Queue | Strategy | Description |
|-------|----------|-------------|
| sbi_sales | longest-idle-agent | Calls go to agent who has been idle longest |
| sbi_marketing | round-robin | Calls distributed evenly among agents |
| sbi_accounts | ring-all | Rings all available agents simultaneously |
| hdfc_sales | agent-with-least-talk-time | Calls go to agent with least total talk time |
| axis_marketing | agent-with-fewest-calls | Calls go to agent with fewest completed calls |
| hdfc_marketing | top-down | Calls Agents from Top to Down
| hdfc_accounts | sequentially-by-agent-order| 
| axis_sales | random |
| axis_accounts | ring-progressively | 