install nodejs dependencies:
  pkg.installed:
    - pkgs:
      - build-essential
      - memcached: {{ salt['pillar.get']('nodejs:deps:memcached:version') }}

setup nodejs repository:
  pkg.installed:
    - name: apt-transport-https
    - require_in:
      - pkgrepo: "setup nodejs repository"
  pkgrepo.managed:
    - humanname: nodejs package repository
    - name: deb {{ salt['pillar.get']('nodejs:repository_url', 'https://deb.nodesource.com/node_6.x') }} {{ grains['oscodename'] }} main
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/nodesource.list
    - keyid: "68576280"
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: nodejs

install nodejs package:
  pkg.installed:
    - name: nodejs
    - reload_modules: true
{%- if salt['pillar.get']('nodejs:version') %}
    - version: {{ salt['pillar.get']('nodejs:version') }}
{%- endif %}