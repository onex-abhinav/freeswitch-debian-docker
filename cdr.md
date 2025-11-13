# Call Detail Records [CDR] 

## CDRs in JSON Configuration 


### FreeSWITCH Configuration

#### 1. Add These in vars.xml file 

**File:** `/usr/local/freeswitch/config/vars.xml`


```xml

  <X-PRE-PROCESS cmd="set" data="cdr_enable=true"/>
  <X-PRE-PROCESS cmd="set" data="enable_json_cdr=true"/>
  <X-PRE-PROCESS cmd="set" data="cdr_log_all_variables=true"/>
  <X-PRE-PROCESS cmd="set" data="cdr_include_all_variables=true"/>

```

#### 2. Create json_cdr.conf.xml in autoload_config

**File:** `/usr/local/freeswitch/config/autoload_config/json_cdr.conf.xml`

```xml

<configuration name="json_cdr.conf" description="JSON CDR Configuration">
  <settings>
    <param name="enable" value="true"/>
    <param name="log-dir" value="/var/log/freeswitch/cdr"/>
    <param name="file-name" value="cdr.json"/>
    <param name="rollover" value="daily"/>
    <param name="include-all-vars" value="true"/>
    <param name="pretty-print" value="true"/>
    <param name="timestamp-format" value="iso8601"/>
  </settings>
</configuration>

```

#### 3. Add these lines in modules.cong.xml if missing 

**File:** `/usr/local/freeswitch/config/autoload_config/modules.conf.xml`

```xml
    <load module="mod_json_cdr"/>
    <load module="mod_cdr_sqlite"/>
    <load module="mod_odbc_cdr"/>
```

#### 4. Add this Global CDR Extension in default.xml file

**File:** `/usr/local/freeswitch/config/dialplan/default.xml`

```xml
      <extension name="global_cdr" continue="true">
            <condition>
                  <!-- Set CDR variables without execute_on_* applications -->
                  <action application="set" data="cdr_enable=true"/>
                  <action application="set" data="cdr_include_all_variables=true"/>
                  <action application="export" data="cdr_include_all_variables=true"/>
            </condition>
      </extension>
```
## Run Freeswitch and check the CDR 

# JSON Responses of CDR

`/var/log/freeswitch/cdr` check in this path inside Freeswitch Container 
```bash
docker exec -it freeswitch bash
``` 


### Inbound Call (call originated from twinkle)

```json
{
  "core-uuid": "60e127b7-2c12-49ca-aacf-00bba4eea101",
  "switchname": "OL03LTL-GNR0092",
  "channel_data": {
    "state": "CS_REPORTING",
    "direction": "inbound",
    "state_number": "11",
    "flags": "0=1;3=1;39=1;40=1;42=1;55=1;95=1;113=1;114=1;123=1;160=1;165=1;166=1",
    "caps": "1=1;2=1;3=1;4=1;5=1;6=1;8=1;9=1;10=1"
  },
  "callStats": {
    "audio": {
      "inbound": {
        "raw_bytes": 0,
        "media_bytes": 0,
        "packet_count": 0,
        "media_packet_count": 0,
        "skip_packet_count": 175,
        "jitter_packet_count": 0,
        "dtmf_packet_count": 0,
        "cng_packet_count": 0,
        "flush_packet_count": 0,
        "largest_jb_size": 0,
        "jitter_min_variance": 0,
        "jitter_max_variance": 0,
        "jitter_loss_rate": 0,
        "jitter_burst_rate": 0,
        "mean_interval": 0,
        "flaw_total": 0,
        "quality_percentage": 100,
        "mos": 4.5
      },
      "outbound": {
        "raw_bytes": 29928,
        "media_bytes": 29928,
        "packet_count": 174,
        "media_packet_count": 174,
        "skip_packet_count": 0,
        "dtmf_packet_count": 0,
        "cng_packet_count": 0,
        "rtcp_packet_count": 0,
        "rtcp_octet_count": 0
      }
    }
  },
  "variables": {
    "direction": "inbound",
    "uuid": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
    "session_id": "5",
    "sip_from_user": "1001",
    "sip_from_uri": "1001%4010.30.40.77",
    "sip_from_host": "10.30.40.77",
    "video_media_flow": "disabled",
    "text_media_flow": "disabled",
    "channel_name": "sofia/internal/1001%4010.30.40.77",
    "sip_call_id": "wxyidphjtkvkvka%40OL03LTL-GNR0092",
    "sip_local_network_addr": "27.107.1.210",
    "sip_network_ip": "10.30.40.77",
    "sip_network_port": "5070",
    "sip_invite_stamp": "1762923102707743",
    "sip_received_ip": "10.30.40.77",
    "sip_received_port": "5070",
    "sip_via_protocol": "udp",
    "sip_authorized": "true",
    "Event-Name": "REQUEST_PARAMS",
    "Core-UUID": "60e127b7-2c12-49ca-aacf-00bba4eea101",
    "FreeSWITCH-Hostname": "OL03LTL-GNR0092",
    "FreeSWITCH-Switchname": "OL03LTL-GNR0092",
    "FreeSWITCH-IPv4": "10.30.40.77",
    "FreeSWITCH-IPv6": "%3A%3A1",
    "Event-Date-Local": "2025-11-12%2010%3A21%3A42",
    "Event-Date-GMT": "Wed,%2012%20Nov%202025%2004%3A51%3A42%20GMT",
    "Event-Date-Timestamp": "1762923102707743",
    "Event-Calling-File": "sofia.c",
    "Event-Calling-Function": "sofia_handle_sip_i_invite",
    "Event-Calling-Line-Number": "10723",
    "Event-Sequence": "1076",
    "sip_number_alias": "1001",
    "sip_auth_username": "1001",
    "sip_auth_realm": "10.30.40.77",
    "number_alias": "1001",
    "requested_user_name": "1001",
    "requested_domain_name": "10.30.40.77",
    "record_stereo": "true",
    "default_gateway": "example.com",
    "default_areacode": "918",
    "transfer_fallback_extension": "operator",
    "toll_allow": "domestic,international,local",
    "accountcode": "1001",
    "user_context": "default",
    "effective_caller_id_name": "Extension%201001",
    "effective_caller_id_number": "1001",
    "outbound_caller_id_name": "FreeSWITCH",
    "outbound_caller_id_number": "0000000000",
    "callgroup": "techsupport",
    "user_name": "1001",
    "domain_name": "10.30.40.77",
    "sip_from_user_stripped": "1001",
    "sip_from_tag": "qdkuv",
    "sofia_profile_name": "internal",
    "sofia_profile_url": "sip%3Amod_sofia%4027.107.1.210%3A5060",
    "recovery_profile_name": "internal",
    "sip_full_via": "SIP/2.0/UDP%2010.30.40.77%3A5070%3Brport%3D5070%3Bbranch%3Dz9hG4bKbhunfeqx",
    "sip_from_display": "1001",
    "sip_full_from": "%221001%22%20%3Csip%3A1001%4010.30.40.77%3E%3Btag%3Dqdkuv",
    "sip_full_to": "%3Csip%3A1003%4010.30.40.77%3E",
    "sip_allow": "INVITE,%20ACK,%20BYE,%20CANCEL,%20OPTIONS,%20PRACK,%20REFER,%20NOTIFY,%20SUBSCRIBE,%20INFO,%20MESSAGE",
    "sip_req_user": "1003",
    "sip_req_uri": "1003%4010.30.40.77",
    "sip_req_host": "10.30.40.77",
    "sip_to_user": "1003",
    "sip_to_uri": "1003%4010.30.40.77",
    "sip_to_host": "10.30.40.77",
    "sip_contact_user": "1001",
    "sip_contact_port": "5070",
    "sip_contact_uri": "1001%4010.30.40.77%3A5070",
    "sip_contact_host": "10.30.40.77",
    "sip_user_agent": "Twinkle/1.10.2",
    "sip_via_host": "10.30.40.77",
    "sip_via_port": "5070",
    "sip_via_rport": "5070",
    "max_forwards": "70",
    "presence_id": "1001%4010.30.40.77",
    "switch_r_sdp": "v%3D0%0D%0Ao%3Dtwinkle%20917472465%20644139925%20IN%20IP4%2010.30.40.77%0D%0As%3D-%0D%0Ac%3DIN%20IP4%2010.30.40.77%0D%0At%3D0%200%0D%0Am%3Daudio%208000%20RTP/AVP%2098%2097%208%200%203%20101%0D%0Aa%3Drtpmap%3A98%20speex/16000%0D%0Aa%3Drtpmap%3A97%20speex/8000%0D%0Aa%3Drtpmap%3A8%20PCMA/8000%0D%0Aa%3Drtpmap%3A0%20PCMU/8000%0D%0Aa%3Drtpmap%3A3%20GSM/8000%0D%0Aa%3Drtpmap%3A101%20telephone-event/8000%0D%0Aa%3Dfmtp%3A101%200-15%0D%0Aa%3Dptime%3A20%0D%0A",
    "ep_codec_string": "CORE_PCM_MODULE.PCMA%408000h%4020i%4064000b,CORE_PCM_MODULE.PCMU%408000h%4020i%4064000b",
    "DP_MATCH": "ARRAY%3A%3A1003%7C%3A1003",
    "call_uuid": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
    "cdr_enable": "true",
    "cdr_include_all_variables": "true",
    "open": "true",
    "RFC2822_DATE": "Wed,%2012%20Nov%202025%2010%3A21%3A52%20%2B0530",
    "dialed_extension": "1003",
    "export_vars": "cdr_include_all_variables,RFC2822_DATE,dialed_extension",
    "ringback": "%25(2000,4000,440,480)",
    "transfer_ringback": "local_stream%3A//moh",
    "call_timeout": "30",
    "hangup_after_bridge": "true",
    "continue_on_fail": "true",
    "called_party_callgroup": "techsupport",
    "current_application_data": "user/1003%4010.30.40.77",
    "current_application": "bridge",
    "dialed_user": "1003",
    "dialed_domain": "10.30.40.77",
    "originate_signal_bond": "ab0aa08a-ead3-42c6-a365-99553a001fba",
    "originated_legs": "ab0aa08a-ead3-42c6-a365-99553a001fba%3BOutbound%20Call%3B1003",
    "rtp_use_codec_string": "OPUS,G722,PCMU,PCMA,H264,VP8",
    "remote_video_media_flow": "inactive",
    "remote_text_media_flow": "inactive",
    "remote_audio_media_flow": "sendrecv",
    "audio_media_flow": "sendrecv",
    "rtp_audio_recv_pt": "8",
    "rtp_use_codec_name": "PCMA",
    "rtp_use_codec_rate": "8000",
    "rtp_use_codec_ptime": "20",
    "rtp_use_codec_channels": "1",
    "rtp_last_audio_codec_string": "PCMA%408000h%4020i%401c",
    "original_read_codec": "PCMA",
    "original_read_rate": "8000",
    "write_codec": "PCMA",
    "write_rate": "8000",
    "dtmf_type": "rfc2833",
    "local_media_ip": "10.30.40.77",
    "local_media_port": "16458",
    "advertised_media_ip": "10.30.40.77",
    "rtp_use_timer_name": "soft",
    "rtp_use_pt": "8",
    "rtp_use_ssrc": "2836815815",
    "rtp_2833_send_payload": "101",
    "rtp_2833_recv_payload": "101",
    "remote_media_ip": "10.30.40.77",
    "remote_media_port": "8000",
    "endpoint_disposition": "EARLY%20MEDIA",
    "rtp_local_sdp_str": "v%3D0%0D%0Ao%3DFreeSWITCH%201762906654%201762906655%20IN%20IP4%2010.30.40.77%0D%0As%3DFreeSWITCH%0D%0Ac%3DIN%20IP4%2010.30.40.77%0D%0At%3D0%200%0D%0Am%3Daudio%2016458%20RTP/AVP%208%20101%0D%0Aa%3Drtpmap%3A8%20PCMA/8000%0D%0Aa%3Drtpmap%3A101%20telephone-event/8000%0D%0Aa%3Dfmtp%3A101%200-15%0D%0Aa%3Dptime%3A20%0D%0Aa%3Dsendrecv%0D%0A",
    "sip_hangup_disposition": "recv_cancel",
    "sip_invite_failure_status": "487",
    "sip_invite_failure_phrase": "CANCEL",
    "sip_term_status": "487",
    "proto_specific_hangup_cause": "sip%3A487",
    "sip_term_cause": "487",
    "read_codec": "PCMA",
    "read_rate": "8000",
    "originate_causes": "ab0aa08a-ead3-42c6-a365-99553a001fba%3BORIGINATOR_CANCEL",
    "originate_disposition": "ORIGINATOR_CANCEL",
    "DIALSTATUS": "CANCEL",
    "originate_failed_cause": "ORIGINATOR_CANCEL",
    "hangup_cause": "ORIGINATOR_CANCEL",
    "hangup_cause_q850": "16",
    "digits_dialed": "none",
    "start_stamp": "2025-11-12%2010%3A21%3A42",
    "profile_start_stamp": "2025-11-12%2010%3A21%3A42",
    "progress_stamp": "2025-11-12%2010%3A21%3A52",
    "progress_media_stamp": "2025-11-12%2010%3A21%3A52",
    "end_stamp": "2025-11-12%2010%3A21%3A56",
    "start_epoch": "1762923102",
    "start_uepoch": "1762923102707743",
    "profile_start_epoch": "1762923102",
    "profile_start_uepoch": "1762923102707743",
    "answer_epoch": "0",
    "answer_uepoch": "0",
    "bridge_epoch": "0",
    "bridge_uepoch": "0",
    "last_hold_epoch": "0",
    "last_hold_uepoch": "0",
    "hold_accum_seconds": "0",
    "hold_accum_usec": "0",
    "hold_accum_ms": "0",
    "resurrect_epoch": "0",
    "resurrect_uepoch": "0",
    "progress_epoch": "1762923112",
    "progress_uepoch": "1762923112727744",
    "progress_media_epoch": "1762923112",
    "progress_media_uepoch": "1762923112747745",
    "end_epoch": "1762923116",
    "end_uepoch": "1762923116247748",
    "last_app": "bridge",
    "last_arg": "user/1003%4010.30.40.77",
    "caller_id": "%221001%22%20%3C1001%3E",
    "duration": "14",
    "billsec": "0",
    "progresssec": "10",
    "answersec": "0",
    "waitsec": "0",
    "progress_mediasec": "10",
    "flow_billsec": "0",
    "mduration": "13540",
    "billmsec": "0",
    "progressmsec": "10020",
    "answermsec": "0",
    "waitmsec": "0",
    "progress_mediamsec": "10040",
    "flow_billmsec": "0",
    "uduration": "13540005",
    "billusec": "0",
    "progressusec": "10020001",
    "answerusec": "0",
    "waitusec": "0",
    "progress_mediausec": "10040002",
    "flow_billusec": "0",
    "rtp_audio_in_raw_bytes": "0",
    "rtp_audio_in_media_bytes": "0",
    "rtp_audio_in_packet_count": "0",
    "rtp_audio_in_media_packet_count": "0",
    "rtp_audio_in_skip_packet_count": "175",
    "rtp_audio_in_jitter_packet_count": "0",
    "rtp_audio_in_dtmf_packet_count": "0",
    "rtp_audio_in_cng_packet_count": "0",
    "rtp_audio_in_flush_packet_count": "0",
    "rtp_audio_in_largest_jb_size": "0",
    "rtp_audio_in_jitter_min_variance": "0.00",
    "rtp_audio_in_jitter_max_variance": "0.00",
    "rtp_audio_in_jitter_loss_rate": "0.00",
    "rtp_audio_in_jitter_burst_rate": "0.00",
    "rtp_audio_in_mean_interval": "0.00",
    "rtp_audio_in_flaw_total": "0",
    "rtp_audio_in_quality_percentage": "100.00",
    "rtp_audio_in_mos": "4.50",
    "rtp_audio_out_raw_bytes": "29928",
    "rtp_audio_out_media_bytes": "29928",
    "rtp_audio_out_packet_count": "174",
    "rtp_audio_out_media_packet_count": "174",
    "rtp_audio_out_skip_packet_count": "0",
    "rtp_audio_out_dtmf_packet_count": "0",
    "rtp_audio_out_cng_packet_count": "0",
    "rtp_audio_rtcp_packet_count": "0",
    "rtp_audio_rtcp_octet_count": "0"
  },
  "app_log": {
    "applications": [
      {
        "app_name": "set",
        "app_data": "cdr_enable=true",
        "app_stamp": "1762923103537244"
      },
      {
        "app_name": "set",
        "app_data": "cdr_include_all_variables=true",
        "app_stamp": "1762923103537435"
      },
      {
        "app_name": "export",
        "app_data": "cdr_include_all_variables=true",
        "app_stamp": "1762923103537644"
      },
      {
        "app_name": "set",
        "app_data": "open=true",
        "app_stamp": "1762923103537825"
      },
      {
        "app_name": "log",
        "app_data": "CRIT WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING ",
        "app_stamp": "1762923103538004"
      },
      {
        "app_name": "log",
        "app_data": "CRIT Open /etc/freeswitch/vars.xml and change the default_password.",
        "app_stamp": "1762923103538190"
      },
      {
        "app_name": "log",
        "app_data": "CRIT Once changed type 'reloadxml' at the console.",
        "app_stamp": "1762923103538367"
      },
      {
        "app_name": "log",
        "app_data": "CRIT WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING ",
        "app_stamp": "1762923103538556"
      },
      {
        "app_name": "sleep",
        "app_data": "10000",
        "app_stamp": "1762923103538738"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-spymap/1001/51156b0b-f91b-4fd3-9c8f-15226f6098be",
        "app_stamp": "1762923113544510"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-last_dial/1001/1003",
        "app_stamp": "1762923113544704"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-last_dial/global/51156b0b-f91b-4fd3-9c8f-15226f6098be",
        "app_stamp": "1762923113544865"
      },
      {
        "app_name": "export",
        "app_data": "RFC2822_DATE=Wed, 12 Nov 2025 10:21:52 +0530",
        "app_stamp": "1762923113545273"
      },
      {
        "app_name": "export",
        "app_data": "dialed_extension=1003",
        "app_stamp": "1762923113545419"
      },
      {
        "app_name": "bind_meta_app",
        "app_data": "1 b s execute_extension::dx XML features",
        "app_stamp": "1762923113545590"
      },
      {
        "app_name": "bind_meta_app",
        "app_data": "2 b s record_session::/var/lib/freeswitch/recordings/1001.2025-11-12-10-21-52.wav",
        "app_stamp": "1762923113545775"
      },
      {
        "app_name": "bind_meta_app",
        "app_data": "3 b s execute_extension::cf XML features",
        "app_stamp": "1762923113545911"
      },
      {
        "app_name": "bind_meta_app",
        "app_data": "4 b s execute_extension::att_xfer XML features",
        "app_stamp": "1762923113546029"
      },
      {
        "app_name": "set",
        "app_data": "ringback=%(2000,4000,440,480)",
        "app_stamp": "1762923113546145"
      },
      {
        "app_name": "set",
        "app_data": "transfer_ringback=local_stream://moh",
        "app_stamp": "1762923113546250"
      },
      {
        "app_name": "set",
        "app_data": "call_timeout=30",
        "app_stamp": "1762923113546364"
      },
      {
        "app_name": "set",
        "app_data": "hangup_after_bridge=true",
        "app_stamp": "1762923113546488"
      },
      {
        "app_name": "set",
        "app_data": "continue_on_fail=true",
        "app_stamp": "1762923113546618"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-call_return/1003/1001",
        "app_stamp": "1762923113546749"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-last_dial_ext/1003/51156b0b-f91b-4fd3-9c8f-15226f6098be",
        "app_stamp": "1762923113546904"
      },
      {
        "app_name": "set",
        "app_data": "called_party_callgroup=techsupport",
        "app_stamp": "1762923113547108"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-last_dial_ext/techsupport/51156b0b-f91b-4fd3-9c8f-15226f6098be",
        "app_stamp": "1762923113547222"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-last_dial_ext/global/51156b0b-f91b-4fd3-9c8f-15226f6098be",
        "app_stamp": "1762923113547346"
      },
      {
        "app_name": "hash",
        "app_data": "insert/10.30.40.77-last_dial/techsupport/51156b0b-f91b-4fd3-9c8f-15226f6098be",
        "app_stamp": "1762923113547455"
      },
      {
        "app_name": "bridge",
        "app_data": "user/1003@10.30.40.77",
        "app_stamp": "1762923113547598"
      }
    ]
  },
  "callflow": [
    {
      "dialplan": "XML",
      "profile_index": "1",
      "extension": {
        "name": "global_cdr",
        "number": "1003",
        "applications": [
          {
            "app_name": "set",
            "app_data": "cdr_enable=true"
          },
          {
            "app_name": "set",
            "app_data": "cdr_include_all_variables=true"
          },
          {
            "app_name": "export",
            "app_data": "cdr_include_all_variables=true"
          },
          {
            "app_name": "set",
            "app_data": "open=true"
          },
          {
            "app_name": "log",
            "app_data": "CRIT WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING "
          },
          {
            "app_name": "log",
            "app_data": "CRIT Open /etc/freeswitch/vars.xml and change the default_password."
          },
          {
            "app_name": "log",
            "app_data": "CRIT Once changed type 'reloadxml' at the console."
          },
          {
            "app_name": "log",
            "app_data": "CRIT WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING "
          },
          {
            "app_name": "sleep",
            "app_data": "10000"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-spymap/${caller_id_number}/${uuid}"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-last_dial/${caller_id_number}/${destination_number}"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-last_dial/global/${uuid}"
          },
          {
            "app_name": "export",
            "app_data": "RFC2822_DATE=${strftime(%a, %d %b %Y %T %z)}"
          },
          {
            "app_name": "export",
            "app_data": "dialed_extension=1003"
          },
          {
            "app_name": "bind_meta_app",
            "app_data": "1 b s execute_extension::dx XML features"
          },
          {
            "app_name": "bind_meta_app",
            "app_data": "2 b s record_session::/var/lib/freeswitch/recordings/${caller_id_number}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav"
          },
          {
            "app_name": "bind_meta_app",
            "app_data": "3 b s execute_extension::cf XML features"
          },
          {
            "app_name": "bind_meta_app",
            "app_data": "4 b s execute_extension::att_xfer XML features"
          },
          {
            "app_name": "set",
            "app_data": "ringback=${us-ring}"
          },
          {
            "app_name": "set",
            "app_data": "transfer_ringback=local_stream://moh"
          },
          {
            "app_name": "set",
            "app_data": "call_timeout=30"
          },
          {
            "app_name": "set",
            "app_data": "hangup_after_bridge=true"
          },
          {
            "app_name": "set",
            "app_data": "continue_on_fail=true"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-call_return/${dialed_extension}/${caller_id_number}"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-last_dial_ext/${dialed_extension}/${uuid}"
          },
          {
            "app_name": "set",
            "app_data": "called_party_callgroup=${user_data(${dialed_extension}@${domain_name} var callgroup)}"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-last_dial_ext/${called_party_callgroup}/${uuid}"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-last_dial_ext/global/${uuid}"
          },
          {
            "app_name": "hash",
            "app_data": "insert/${domain_name}-last_dial/${called_party_callgroup}/${uuid}"
          },
          {
            "app_name": "bridge",
            "app_data": "user/${dialed_extension}@${domain_name}"
          },
          {
            "last_executed": "true",
            "app_name": "answer",
            "app_data": ""
          },
          {
            "app_name": "sleep",
            "app_data": "1000"
          },
          {
            "app_name": "bridge",
            "app_data": "loopback/app=voicemail:default ${domain_name} ${dialed_extension}"
          }
        ],
        "current_app": "answer"
      },
      "caller_profile": {
        "username": "1001",
        "dialplan": "XML",
        "caller_id_name": "1001",
        "ani": "1001",
        "aniii": "",
        "caller_id_number": "1001",
        "network_addr": "10.30.40.77",
        "rdnis": "",
        "destination_number": "1003",
        "uuid": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
        "source": "mod_sofia",
        "context": "default",
        "chan_name": "sofia/internal/1001@10.30.40.77"
      },
      "times": {
        "created_time": "1762923102707743",
        "profile_created_time": "1762923102707743",
        "progress_time": "1762923112727744",
        "progress_media_time": "1762923112747745",
        "answered_time": "0",
        "bridged_time": "0",
        "last_hold_time": "0",
        "hold_accum_time": "0",
        "hangup_time": "1762923116247748",
        "resurrect_time": "0",
        "transfer_time": "0"
      }
    }
  ]
}
```

### Outbound Call (call originated from twinkle)

```json
{
  "core-uuid": "60e127b7-2c12-49ca-aacf-00bba4eea101",
  "switchname": "OL03LTL-GNR0092",
  "channel_data": {
    "state": "CS_REPORTING",
    "direction": "outbound",
    "state_number": "11",
    "flags": "0=1;2=1;22=1;40=1;42=1;45=1;113=1;114=1",
    "caps": "1=1;2=1;3=1;4=1;5=1;6=1;8=1;9=1;10=1"
  },
  "callStats": {},
  "variables": {
    "direction": "outbound",
    "is_outbound": "true",
    "uuid": "ab0aa08a-ead3-42c6-a365-99553a001fba",
    "session_id": "6",
    "sip_profile_name": "internal",
    "text_media_flow": "disabled",
    "channel_name": "sofia/internal/1003%4010.30.40.77%3A5070",
    "sip_destination_url": "sip%3A1003%4010.30.40.77%3A5070",
    "max_forwards": "69",
    "originator_codec": "CORE_PCM_MODULE.PCMA%408000h%4020i%4064000b,CORE_PCM_MODULE.PCMU%408000h%4020i%4064000b",
    "originator": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
    "signal_bond": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
    "switch_m_sdp": "v%3D0%0D%0Ao%3Dtwinkle%20917472465%20644139925%20IN%20IP4%2010.30.40.77%0D%0As%3D-%0D%0Ac%3DIN%20IP4%2010.30.40.77%0D%0At%3D0%200%0D%0Am%3Daudio%208000%20RTP/AVP%2098%2097%208%200%203%20101%0D%0Aa%3Drtpmap%3A98%20speex/16000%0D%0Aa%3Drtpmap%3A97%20speex/8000%0D%0Aa%3Drtpmap%3A8%20PCMA/8000%0D%0Aa%3Drtpmap%3A0%20PCMU/8000%0D%0Aa%3Drtpmap%3A3%20GSM/8000%0D%0Aa%3Drtpmap%3A101%20telephone-event/8000%0D%0Aa%3Dfmtp%3A101%200-15%0D%0Aa%3Dptime%3A20%0D%0A",
    "call_uuid": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
    "dialed_user": "1003",
    "dialed_domain": "10.30.40.77",
    "export_vars": "cdr_include_all_variables,RFC2822_DATE,dialed_extension",
    "cdr_include_all_variables": "true",
    "RFC2822_DATE": "Wed,%2012%20Nov%202025%2010%3A21%3A52%20%2B0530",
    "dialed_extension": "1003",
    "sip_invite_domain": "10.30.40.77",
    "presence_id": "1003%4010.30.40.77",
    "originate_early_media": "true",
    "originating_leg_uuid": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
    "originate_endpoint": "sofia",
    "rtp_use_codec_string": "CORE_PCM_MODULE.PCMA%408000h%4020i%4064000b,CORE_PCM_MODULE.PCMU%408000h%4020i%4064000b",
    "local_media_ip": "10.30.40.77",
    "local_media_port": "20590",
    "advertised_media_ip": "10.30.40.77",
    "audio_media_flow": "sendrecv",
    "video_media_flow": "sendrecv",
    "rtp_local_sdp_str": "v%3D0%0D%0Ao%3DFreeSWITCH%201762902522%201762902523%20IN%20IP4%2010.30.40.77%0D%0As%3DFreeSWITCH%0D%0Ac%3DIN%20IP4%2010.30.40.77%0D%0At%3D0%200%0D%0Am%3Daudio%2020590%20RTP/AVP%208%200%20101%0D%0Aa%3Drtpmap%3A8%20PCMA/8000%0D%0Aa%3Drtpmap%3A0%20PCMU/8000%0D%0Aa%3Drtpmap%3A101%20telephone-event/8000%0D%0Aa%3Dfmtp%3A101%200-15%0D%0Aa%3Dptime%3A20%0D%0Aa%3Dsendrecv%0D%0A",
    "sip_outgoing_contact_uri": "%3Csip%3Amod_sofia%4027.107.1.210%3A5060%3E",
    "sip_req_uri": "1003%4010.30.40.77%3A5070",
    "sofia_profile_name": "internal",
    "recovery_profile_name": "internal",
    "sofia_profile_url": "sip%3Amod_sofia%4027.107.1.210%3A5060",
    "sip_local_network_addr": "27.107.1.210",
    "sip_reply_host": "10.30.40.77",
    "sip_reply_port": "5070",
    "sip_network_ip": "10.30.40.77",
    "sip_network_port": "5070",
    "sip_user_agent": "Twinkle/1.10.2",
    "sip_recover_contact": "%3Csip%3A1003%4010.30.40.77%3A5070%3E",
    "sip_full_via": "SIP/2.0/UDP%2027.107.1.210%3Breceived%3D10.30.40.77%3Brport%3D5060%3Bbranch%3Dz9hG4bK0ZaH59HD2m3Up",
    "sip_recover_via": "SIP/2.0/UDP%2027.107.1.210%3Breceived%3D10.30.40.77%3Brport%3D5060%3Bbranch%3Dz9hG4bK0ZaH59HD2m3Up",
    "sip_from_display": "Extension%201001",
    "sip_full_from": "%22Extension%201001%22%20%3Csip%3A1001%4010.30.40.77%3E%3Btag%3D2evS6XXy6204K",
    "sip_full_to": "%3Csip%3A1003%4010.30.40.77%3A5070%3E%3Btag%3Drhdgh",
    "sip_from_user": "1001",
    "sip_from_uri": "1001%4010.30.40.77",
    "sip_from_host": "10.30.40.77",
    "sip_to_user": "1003",
    "sip_to_port": "5070",
    "sip_to_uri": "1003%4010.30.40.77%3A5070",
    "sip_to_host": "10.30.40.77",
    "sip_contact_user": "1003",
    "sip_contact_port": "5070",
    "sip_contact_uri": "1003%4010.30.40.77%3A5070",
    "sip_contact_host": "10.30.40.77",
    "sip_to_tag": "rhdgh",
    "sip_from_tag": "2evS6XXy6204K",
    "sip_cseq": "106907764",
    "sip_call_id": "265e0473-3a26-123f-61ab-d0ad08a61780",
    "sip_hangup_phrase": "Request%20Terminated",
    "last_bridge_hangup_cause": "ORIGINATOR_CANCEL",
    "last_bridge_proto_specific_hangup_cause": "sip%3A487",
    "hangup_cause": "ORIGINATOR_CANCEL",
    "hangup_cause_q850": "16",
    "digits_dialed": "none",
    "start_stamp": "2025-11-12%2010%3A21%3A52",
    "profile_start_stamp": "2025-11-12%2010%3A21%3A52",
    "progress_stamp": "2025-11-12%2010%3A21%3A52",
    "end_stamp": "2025-11-12%2010%3A21%3A56",
    "start_epoch": "1762923112",
    "start_uepoch": "1762923112727744",
    "profile_start_epoch": "1762923112",
    "profile_start_uepoch": "1762923112727744",
    "answer_epoch": "0",
    "answer_uepoch": "0",
    "bridge_epoch": "0",
    "bridge_uepoch": "0",
    "last_hold_epoch": "0",
    "last_hold_uepoch": "0",
    "hold_accum_seconds": "0",
    "hold_accum_usec": "0",
    "hold_accum_ms": "0",
    "resurrect_epoch": "0",
    "resurrect_uepoch": "0",
    "progress_epoch": "1762923112",
    "progress_uepoch": "1762923112727744",
    "progress_media_epoch": "0",
    "progress_media_uepoch": "0",
    "end_epoch": "1762923116",
    "end_uepoch": "1762923116247748",
    "caller_id": "%22Extension%201001%22%20%3C1001%3E",
    "duration": "4",
    "billsec": "0",
    "progresssec": "0",
    "answersec": "0",
    "waitsec": "0",
    "progress_mediasec": "0",
    "flow_billsec": "0",
    "mduration": "3520",
    "billmsec": "0",
    "progressmsec": "0",
    "answermsec": "0",
    "waitmsec": "0",
    "progress_mediamsec": "0",
    "flow_billmsec": "0",
    "uduration": "3520004",
    "billusec": "0",
    "progressusec": "0",
    "answerusec": "0",
    "waitusec": "0",
    "progress_mediausec": "0",
    "flow_billusec": "0",
    "sip_hangup_disposition": "send_cancel",
    "sip_invite_failure_status": "487",
    "sip_invite_failure_phrase": "CANCEL"
  },
  "callflow": [
    {
      "dialplan": "XML",
      "profile_index": "1",
      "caller_profile": {
        "username": "1001",
        "dialplan": "XML",
        "caller_id_name": "Extension 1001",
        "ani": "1001",
        "aniii": "",
        "caller_id_number": "1001",
        "network_addr": "10.30.40.77",
        "rdnis": "",
        "destination_number": "1003",
        "uuid": "ab0aa08a-ead3-42c6-a365-99553a001fba",
        "source": "mod_sofia",
        "context": "default",
        "chan_name": "sofia/internal/1003@10.30.40.77:5070",
        "originator": {
          "originator_caller_profiles": [
            {
              "username": "1001",
              "dialplan": "XML",
              "caller_id_name": "1001",
              "ani": "1001",
              "aniii": "",
              "caller_id_number": "1001",
              "network_addr": "10.30.40.77",
              "rdnis": "",
              "destination_number": "1003",
              "uuid": "51156b0b-f91b-4fd3-9c8f-15226f6098be",
              "source": "mod_sofia",
              "context": "default",
              "chan_name": "sofia/internal/1001@10.30.40.77"
            }
          ]
        }
      },
      "times": {
        "created_time": "1762923112727744",
        "profile_created_time": "1762923112727744",
        "progress_time": "1762923112727744",
        "progress_media_time": "0",
        "answered_time": "0",
        "bridged_time": "0",
        "last_hold_time": "0",
        "hold_accum_time": "0",
        "hangup_time": "1762923116247748",
        "resurrect_time": "0",
        "transfer_time": "0"
      }
    }
  ]
}
```

### Outbound call (Call originated by freeswitch originate command)

```json
{
  "core-uuid": "60e127b7-2c12-49ca-aacf-00bba4eea101",
  "switchname": "OL03LTL-GNR0092",
  "channel_data": {
    "state": "CS_REPORTING",
    "direction": "outbound",
    "state_number": "11",
    "flags": "0=1;1=1;2=1;22=1;39=1;40=1;42=1;45=1;55=1;62=1;95=1;100=1;113=1;114=1;160=1;166=1",
    "caps": "1=1;2=1;3=1;4=1;5=1;6=1;8=1;9=1;10=1"
  },
  "callStats": {
    "audio": {
      "inbound": {
        "raw_bytes": 0,
        "media_bytes": 0,
        "packet_count": 0,
        "media_packet_count": 0,
        "skip_packet_count": 337,
        "jitter_packet_count": 0,
        "dtmf_packet_count": 0,
        "cng_packet_count": 0,
        "flush_packet_count": 0,
        "largest_jb_size": 0,
        "jitter_min_variance": 0,
        "jitter_max_variance": 0,
        "jitter_loss_rate": 0,
        "jitter_burst_rate": 0,
        "mean_interval": 0,
        "flaw_total": 0,
        "quality_percentage": 100,
        "mos": 4.5
      },
      "outbound": {
        "raw_bytes": 57964,
        "media_bytes": 57964,
        "packet_count": 337,
        "media_packet_count": 337,
        "skip_packet_count": 0,
        "dtmf_packet_count": 0,
        "cng_packet_count": 0,
        "rtcp_packet_count": 0,
        "rtcp_octet_count": 0
      }
    }
  },
  "variables": {
    "direction": "outbound",
    "is_outbound": "true",
    "uuid": "16c22a18-eccc-4974-adf9-44d2b6152838",
    "session_id": "15",
    "sip_gateway_name": "sipptester",
    "sip_profile_name": "gateway",
    "text_media_flow": "disabled",
    "channel_name": "sofia/external/3868158407",
    "sip_destination_url": "sip%3A3868158407%4010.30.40.77%3A15001",
    "sip_h_X-callId": "da1d8360-5612-4237-a387-bef6995995af",
    "sip_h_X-campaignId": "8111001",
    "sip_h_X-campaignInstanceId": "699d925d-f443-4f44-a03d-09472151f00e",
    "sip_h_X-responseQueueName": "CALL_EVENTS_campaign-service-0",
    "sip_h_X-campaignServiceId": "campaign-service-0",
    "sip_h_X-gateway": "sipptester",
    "sip_h_X-callServiceId": "call-service-1",
    "origination_caller_id_name": "9111110001",
    "origination_caller_id_number": "9111110001",
    "originate_early_media": "true",
    "originate_endpoint": "sofia",
    "audio_media_flow": "sendrecv",
    "local_video_ip": "10.30.40.77",
    "local_video_port": "25000",
    "video_media_flow": "sendrecv",
    "rtp_local_sdp_str": "v%3D0%0D%0Ao%3DFreeSWITCH%201762903024%201762903025%20IN%20IP4%2010.30.40.77%0D%0As%3DFreeSWITCH%0D%0Ac%3DIN%20IP4%2010.30.40.77%0D%0At%3D0%200%0D%0Am%3Daudio%2029814%20RTP/AVP%20102%209%200%208%20104%20101%0D%0Aa%3Drtpmap%3A102%20opus/48000/2%0D%0Aa%3Dfmtp%3A102%20useinbandfec%3D1%3B%20maxaveragebitrate%3D30000%3B%20maxplaybackrate%3D48000%3B%20ptime%3D20%3B%20minptime%3D10%3B%20maxptime%3D40%0D%0Aa%3Drtpmap%3A9%20G722/8000%0D%0Aa%3Drtpmap%3A0%20PCMU/8000%0D%0Aa%3Drtpmap%3A8%20PCMA/8000%0D%0Aa%3Drtpmap%3A104%20telephone-event/48000%0D%0Aa%3Dfmtp%3A104%200-15%0D%0Aa%3Drtpmap%3A101%20telephone-event/8000%0D%0Aa%3Dfmtp%3A101%200-15%0D%0Aa%3Dptime%3A20%0D%0Aa%3Dsendrecv%0D%0Am%3Dvideo%2025000%20RTP/AVP%20103%0D%0Ab%3DAS%3A3072%0D%0Aa%3Drtpmap%3A103%20VP8/90000%0D%0Aa%3Dsendrecv%0D%0Aa%3Drtcp-fb%3A103%20ccm%20fir%0D%0Aa%3Drtcp-fb%3A103%20ccm%20tmmbr%0D%0Aa%3Drtcp-fb%3A103%20nack%0D%0Aa%3Drtcp-fb%3A103%20nack%20pli%0D%0A",
    "sip_outgoing_contact_uri": "%3Csip%3Agw%2Bsipptester%4027.107.1.210%3A5080%3Btransport%3Dudp%3Bgw%3Dsipptester%3E",
    "sip_req_uri": "3868158407%4010.30.40.77%3A15001",
    "sofia_profile_name": "external",
    "recovery_profile_name": "external",
    "sofia_profile_url": "sip%3Amod_sofia%4027.107.1.210%3A5080",
    "sip_local_network_addr": "27.107.1.210",
    "sip_reply_host": "10.30.40.77",
    "sip_reply_port": "15001",
    "sip_network_ip": "10.30.40.77",
    "sip_network_port": "15001",
    "sip_recover_contact": "%3Csip%3A127.0.1.1%3A15001%3Btransport%3DUDP%3E",
    "sip_full_via": "SIP/2.0/UDP%2027.107.1.210%3A5080%3Brport%3Bbranch%3Dz9hG4bK53XKvv9ZNtr3N",
    "sip_recover_via": "SIP/2.0/UDP%2027.107.1.210%3A5080%3Brport%3Bbranch%3Dz9hG4bK53XKvv9ZNtr3N",
    "sip_from_display": "9111110001",
    "sip_full_from": "%229111110001%22%20%3Csip%3AFreeSWITCH%4010.30.40.77%3A15001%3E%3Btag%3D26Qc81v8NeFpa",
    "sip_full_to": "%3Csip%3A3868158407%4010.30.40.77%3A15001%3E%3Btag%3D212847SIPpTag014",
    "sip_from_user": "FreeSWITCH",
    "sip_from_port": "15001",
    "sip_from_uri": "FreeSWITCH%4010.30.40.77%3A15001",
    "sip_from_host": "10.30.40.77",
    "sip_to_user": "3868158407",
    "sip_to_port": "15001",
    "sip_to_uri": "3868158407%4010.30.40.77%3A15001",
    "sip_to_host": "10.30.40.77",
    "sip_contact_params": "transport%3DUDP",
    "sip_contact_user": "nobody",
    "sip_contact_port": "15001",
    "sip_contact_uri": "nobody%40127.0.1.1%3A15001",
    "sip_contact_host": "127.0.1.1",
    "sip_to_tag": "212847SIPpTag014",
    "sip_from_tag": "26Qc81v8NeFpa",
    "sip_cseq": "106914872",
    "sip_call_id": "3f5e5264-3a47-123f-61ab-d0ad08a61780",
    "switch_r_sdp": "v%3D0%0D%0Ao%3Duser1%2053655765%202353687637%20IN%20IP4%20127.0.1.1%0D%0As%3D-%0D%0Ac%3DIN%20IP4%20127.0.1.1%0D%0At%3D0%200%0D%0Am%3Daudio%206000%20RTP/AVP%200%0D%0Aa%3Drtpmap%3A0%20PCMU/8000%0D%0A",
    "ep_codec_string": "CORE_PCM_MODULE.PCMU%408000h%4020i%4064000b",
    "rtp_use_codec_string": "OPUS,G722,PCMU,PCMA,H264,VP8",
    "remote_video_media_flow": "inactive",
    "remote_text_media_flow": "inactive",
    "remote_audio_media_flow": "sendrecv",
    "rtp_audio_recv_pt": "0",
    "rtp_use_codec_name": "PCMU",
    "rtp_use_codec_rate": "8000",
    "rtp_use_codec_ptime": "20",
    "rtp_use_codec_channels": "1",
    "rtp_last_audio_codec_string": "PCMU%408000h%4020i%401c",
    "read_codec": "PCMU",
    "original_read_codec": "PCMU",
    "read_rate": "8000",
    "original_read_rate": "8000",
    "write_codec": "PCMU",
    "write_rate": "8000",
    "dtmf_type": "rfc2833",
    "local_media_ip": "10.30.40.77",
    "local_media_port": "29814",
    "advertised_media_ip": "10.30.40.77",
    "rtp_use_timer_name": "soft",
    "rtp_use_pt": "0",
    "rtp_use_ssrc": "1964422024",
    "rtp_2833_send_payload": "101",
    "rtp_2833_recv_payload": "101",
    "remote_media_ip": "127.0.1.1",
    "remote_media_port": "6000",
    "endpoint_disposition": "ANSWER",
    "pre_transfer_caller_id_name": "9111110001",
    "pre_transfer_caller_id_number": "9111110001",
    "channel_cid_flipped": "yes",
    "call_uuid": "16c22a18-eccc-4974-adf9-44d2b6152838",
    "current_application_data": "/usr/share/freeswitch/sounds/en/us/callie/ivr/8000/ivr-you_are_number_one.wav",
    "current_application": "playback",
    "playback_last_offset_pos": "53794",
    "playback_seconds": "6",
    "playback_ms": "6724",
    "playback_samples": "53794",
    "current_application_response": "FILE%20PLAYED",
    "hangup_cause": "NORMAL_CLEARING",
    "hangup_cause_q850": "16",
    "digits_dialed": "none",
    "start_stamp": "2025-11-12%2013%3A03%3A58",
    "profile_start_stamp": "2025-11-12%2013%3A03%3A58",
    "answer_stamp": "2025-11-12%2013%3A03%3A58",
    "progress_stamp": "2025-11-12%2013%3A03%3A58",
    "end_stamp": "2025-11-12%2013%3A04%3A05",
    "start_epoch": "1762932838",
    "start_uepoch": "1762932838915872",
    "profile_start_epoch": "1762932838",
    "profile_start_uepoch": "1762932838915872",
    "answer_epoch": "1762932838",
    "answer_uepoch": "1762932838915872",
    "bridge_epoch": "0",
    "bridge_uepoch": "0",
    "last_hold_epoch": "0",
    "last_hold_uepoch": "0",
    "hold_accum_seconds": "0",
    "hold_accum_usec": "0",
    "hold_accum_ms": "0",
    "resurrect_epoch": "0",
    "resurrect_uepoch": "0",
    "progress_epoch": "1762932838",
    "progress_uepoch": "1762932838915872",
    "progress_media_epoch": "0",
    "progress_media_uepoch": "0",
    "end_epoch": "1762932845",
    "end_uepoch": "1762932845655895",
    "last_app": "playback",
    "last_arg": "/usr/share/freeswitch/sounds/en/us/callie/ivr/8000/ivr-you_are_number_one.wav",
    "caller_id": "%22Outbound%20Call%22%20%3C3868158407%3E",
    "duration": "7",
    "billsec": "7",
    "progresssec": "0",
    "answersec": "0",
    "waitsec": "0",
    "progress_mediasec": "0",
    "flow_billsec": "7",
    "mduration": "6740",
    "billmsec": "6740",
    "progressmsec": "0",
    "answermsec": "0",
    "waitmsec": "0",
    "progress_mediamsec": "0",
    "flow_billmsec": "6740",
    "uduration": "6740023",
    "billusec": "6740023",
    "progressusec": "0",
    "answerusec": "0",
    "waitusec": "0",
    "progress_mediausec": "0",
    "flow_billusec": "6740023",
    "sip_hangup_disposition": "send_bye",
    "rtp_audio_in_raw_bytes": "0",
    "rtp_audio_in_media_bytes": "0",
    "rtp_audio_in_packet_count": "0",
    "rtp_audio_in_media_packet_count": "0",
    "rtp_audio_in_skip_packet_count": "337",
    "rtp_audio_in_jitter_packet_count": "0",
    "rtp_audio_in_dtmf_packet_count": "0",
    "rtp_audio_in_cng_packet_count": "0",
    "rtp_audio_in_flush_packet_count": "0",
    "rtp_audio_in_largest_jb_size": "0",
    "rtp_audio_in_jitter_min_variance": "0.00",
    "rtp_audio_in_jitter_max_variance": "0.00",
    "rtp_audio_in_jitter_loss_rate": "0.00",
    "rtp_audio_in_jitter_burst_rate": "0.00",
    "rtp_audio_in_mean_interval": "0.00",
    "rtp_audio_in_flaw_total": "0",
    "rtp_audio_in_quality_percentage": "100.00",
    "rtp_audio_in_mos": "4.50",
    "rtp_audio_out_raw_bytes": "57964",
    "rtp_audio_out_media_bytes": "57964",
    "rtp_audio_out_packet_count": "337",
    "rtp_audio_out_media_packet_count": "337",
    "rtp_audio_out_skip_packet_count": "0",
    "rtp_audio_out_dtmf_packet_count": "0",
    "rtp_audio_out_cng_packet_count": "0",
    "rtp_audio_rtcp_packet_count": "0",
    "rtp_audio_rtcp_octet_count": "0"
  },
  "app_log": {
    "applications": [
      {
        "app_name": "playback",
        "app_data": "/usr/share/freeswitch/sounds/en/us/callie/ivr/8000/ivr-you_are_number_one.wav",
        "app_stamp": "1762937328906989"
      }
    ]
  },
  "callflow": [
    {
      "profile_index": "1",
      "extension": {
        "name": "playback",
        "number": "/usr/share/freeswitch/sounds/en/us/callie/ivr/8000/ivr-you_are_number_one.wav",
        "applications": [
          {
            "app_name": "playback",
            "app_data": "/usr/share/freeswitch/sounds/en/us/callie/ivr/8000/ivr-you_are_number_one.wav"
          }
        ]
      },
      "caller_profile": {
        "username": "",
        "dialplan": "",
        "caller_id_name": "Outbound Call",
        "ani": "9111110001",
        "aniii": "",
        "caller_id_number": "3868158407",
        "network_addr": "10.30.40.77",
        "rdnis": "",
        "destination_number": "3868158407",
        "uuid": "16c22a18-eccc-4974-adf9-44d2b6152838",
        "source": "src/switch_ivr_originate.c",
        "context": "default",
        "chan_name": "sofia/external/3868158407"
      },
      "times": {
        "created_time": "1762932838915872",
        "profile_created_time": "1762932838915872",
        "progress_time": "1762932838915872",
        "progress_media_time": "0",
        "answered_time": "1762932838915872",
        "bridged_time": "0",
        "last_hold_time": "0",
        "hold_accum_time": "0",
        "hangup_time": "1762932845655895",
        "resurrect_time": "0",
        "transfer_time": "0"
      }
    }
  ]
}
```
### Commands for originate call from freeswitch sip gateway

```bash
fs_cli
```
```fs_cli
bgapi originate {sip_h_X-callId=da1d8360-5612-4237-a387-bef6995995af,sip_h_X-campaignId=8111001,sip_h_X-campaignInstanceId=699d925d-f443-4f44-a03d-09472151f00e,sip_h_X-responseQueueName=CALL_EVENTS_campaign-service-0,sip_h_X-campaignServiceId=campaign-service-0,sip_h_X-gateway=sipptester1,sip_h_X-callServiceId=call-service-1}sofia/gateway/sipptester1/3868158407 &playback(/usr/share/freeswitch/sounds/en/us/callie/ivr/8000/ivr-you_are_number_one.wav) default public 9111110001 9111110001 30
```
### Note : Add siptester Gateway to oiginate call from sipptester gateway

**File:** `/freeswitch/config/sip_profiles/external/sipptester.xml`

```xml
<include>
  <gateway name="sipptester">
    <param name="realm" value="10.30.40.77:15001"/>
    <param name="proxy" value="10.30.40.77:15001"/>
    <param name="register" value="false"/>
  </gateway>
</include>
```
### Add this in Domains to allow (System IP) at acl.conf.xml file 

**File:** `/freeswitch/config/autoload_configs/acl.conf.xml`
```xml
<node type="allow" cidr="10.30.40.77/24"/>
```

# CDR Commands 
```bash

# Reload JSON CDR module
fs_cli -x "reload mod_json_cdr"

# Or reload all configurations
fs_cli -x "reloadxml"

# Reload the JSON CDR module
fs_cli -x "unload mod_json_cdr"
fs_cli -x "load mod_json_cdr"

# Check if configuration is applied
fs_cli -x "show json_cdr"

fs_cli -x "show modules" | grep json_cdr

```