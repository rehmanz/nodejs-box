ensure systemd dependencies are installed:
  pkg.installed:
    - pkgs:
      - systemd
    #TODO: Do we need npm?

setup app via systemd:
  file.managed:
    - name: "/etc/systemd/system/{{ salt['pillar.get']('nodejs:application:name', 'app') }}.service"
    - source: salt://app/files/systemd_definition.jinja
    - template: jinja

  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: "setup app via systemd"

ensure app service is enabled:
  service.running:
    - name: "{{ salt['pillar.get']('nodejs:application:name', 'app') }}"
    - reload: True
    - init_delay: 3