alpine-conf
============

Builds alpine-conf base image with confd installed, to use in with alpine-monit.

Expose a Volume /opt/tools which contains conf software and script directory. /opt/tools/confd/bin/confd /opt/tools/monit/conf.d /opt/tools/scripts

Copy confd config files to /opt/tools/confd/etc/templates and /opt/tools/confd/etc/conf.d

Copy monit config files to /opt/tools/monit/conf.d

Copy util script files to /opt/tools/scripts

To build

```
docker build -t <repo>/alpine-conf:<version> .
```

To run:

```
docker run -it <repo>/alpine-conf:<version> 
```

