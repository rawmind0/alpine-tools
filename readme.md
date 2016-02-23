rancher-conf
============

rancher-conf image with confd and monit installed.

Expose a Volume /opt/tools which contains monit and confd.

Copy confd config files to /opt/tools/confd/etc/templates and /opt/tools/confd/etc/conf.d

Copy monit congif files to /opt/tools/monit/etc/conf.d

To build

```
docker build -t <repo>/rancher-conf:<version> .
```

To run:

```
docker run -it <repo>/rancher-conf:<version> 
```

