alpine-tools
=============

A base image to expose tools to services. It's based in alpine-base, adding confd as config management

##Build

```
docker build -t <repo>/alpine-tools:<version> .
```

## Config management

This image compiles and intall [confd][confd] under /opt/tools/confd, to make it super simple to get dinamic configuration for your service. 


## Versions

- `0.3.3` [(Dockerfile)](https://github.com/rawmind0/alpine-tools/blob/master/Dockerfile)

## Usage

To use this image include `FROM rawmind/alpine-tools` at the top of your `Dockerfile`, and add whaever tool you need your services under /opt/tools.

Starting from `rawmind/alpine-tools` provides you with the ability to easily get dinamic configuration using confd. confd will also keep running checking for config changes, restarting your service.

This image has to be started once as a sidekick of your service (based in alpine-monit), exporting a /opt/tools volume to it. It adds monit conf.d to start confd with a default parameters, that you can overwrite with environment variables.


## Examples

An example of using this image can be found in the [rawmind/alpine-zk][alpine-zk].

[confd]: http://www.confd.io/
