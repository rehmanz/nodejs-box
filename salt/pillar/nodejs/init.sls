nodejs:
  major_version: 6
  version: 6.11.3-1nodesource1
  repository_url: "https://deb.nodesource.com/node_6.x"
  package:
    path: "/usr/bin"
  application:
    name: "app"
    path: "/opt/app/src"
    port: 8080
  firewall:
    ip: "10.0.0.0"
    subnet_mask: "8"
  deps:
    memcached:
      version:  1.4.14-0ubuntu9.1
    mysql:
      version: test