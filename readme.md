alpine-conf
============

alpine-conf image with confd installed.

Expose a Volume /opt/tools which contains confd and scripts.

Copy confd config files to /opt/tools/confd/etc/templates and /opt/tools/confd/etc/conf.d

Copy monit config files to /opt/tools/monit/conf.d

To build

```
docker build -t <repo>/alpine-conf:<version> .
```

To run:

```
docker run -it <repo>/alpine-conf:<version> 
```

