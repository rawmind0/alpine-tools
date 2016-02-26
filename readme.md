alpine-conf
============

alpine-conf image with confd installed.

Expose a Volume /opt/tools which contains confd.

To build

```
docker build -t <repo>/alpine-conf:<version> .
```

To run:

```
docker run -it <repo>/alpine-conf:<version> 
```

