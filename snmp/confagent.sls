{% from "snmp/map.jinja" import snmp with context %}

include:
  - snmp

{% for name, source in salt['pillar.get']("snmp:conf:mibs").items() %}
{% if source %}
snmp_mib_{{ name }}:
  file.managed:
    - name: {{ snmp.mibsdir }}/{{ name }}.txt
    - source: {{ source }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: {{ snmp.service }}
{% endif %}
{% endfor %}

snmp_agentconf:
  file.managed:
    - name: {{ snmp.configagent }}
    - source: {{ snmp.sourceagent }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: {{ snmp.service }}
