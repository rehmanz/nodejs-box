setting up firewall to limit access to app:
  cmd.script:
    - name: configure_firewall.sh
    - source: salt://app/files/firewall.jinja
    - template: jinja