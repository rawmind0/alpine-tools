rancher-conf
============

rancher-conf image with confd and monit installed.

Expose a Volume /opt/tools which contains monit and confd.

To build

```
docker build -t <repo>/rancher-conf:<version> .
```

To run:

```
docker run -it <repo>/rancher-conf:<version> 
```

