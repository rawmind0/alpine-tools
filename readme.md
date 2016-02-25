alpine-conf
============

alpine-conf image with confd and monit installed.

Expose a Volume /opt/tools which contains monit and confd. /opt/tools/confd/bin/confd and /opt/tools/monit/bin/monit

Copy confd config files to /opt/tools/confd/etc/templates and /opt/tools/confd/etc/conf.d
Copy monit config files to /opt/tools/monit/etc/conf.d

To build

```
docker build -t <repo>/alpine-conf:<version> .
```

To run:

```
docker run -it <repo>/alpine-conf:<version> 
```

