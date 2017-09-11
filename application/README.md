# Simple NodeJS Application

Use this as an example application to install.

To run this, you would want to run the command:
> /path/to/nodejs /opt/app/app.js

## systemd

This could be configured in `system.d` with the following:

```
[Unit]
Description=app

[Service]
ExecStart=/path/to/nodejs /opt/app/app.js
ExecStop=/bin/kill $MAINPID
KillMode=process
Restart=on-failure
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
```

Or `upstart`:

```
respawn
respawn limit 15 5

start on runlevel [2345]
stop on runlevel [06]

script
su - youruser -c "NODE_ENV=test exec /path/to/node /opt/app/app.js 2>&1" >> /var/log/app.log
end script
```
