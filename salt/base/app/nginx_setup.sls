ensure nginx is installed:
  pkg.installed:
    - pkgs:
      - nginx

replace nginx config file:
  file.managed:
    - name: /etc/nginx/sites-available/default
    - source: salt://app/files/nginx.jinja
    - template: jinja

#TODO: Check nginx updated config via "sudo nginx -t"

restart nginx service:
  cmd.run:
    - name: "sudo service nginx restart"

#TODO: Salt service module fails for nginx restart
#  service.running:
#    - name: nginx
#    - init_delay: 3
#    - watch:
#      - file: /etc/nginx/sites-available/default