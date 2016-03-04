alpine-confd
=============

A base image to run confd. It's based in alpine-base, adding confd as config management

##Build

```
docker build -t <repo>/alpine-confd:<version> .
```

## Config management

This image compiles and intall [confd][confd] under /opt/tools/confd, to make it super simple to get dinamic configuration for your service. 


## Versions

- `0.11.0` [(Dockerfile)](https://github.com/rawmind0/alpine-confd/blob/master/Dockerfile)

## Usage

To use this image include `FROM rawmind/alpine-confd` at the top of your `Dockerfile`. Starting from `rawmind/alpine-confd` provides you with the ability to easily get dinamic configuration using confd. confd will also keep running checking for config changes, restarting your service.

This image has to be started once as a sidekick of your service (based in alpine-monit), exporting a /opt/tools volume to it. It adds monit conf.d to start confd with a default parameters, that you can overwrite with environment variables.


## Examples

An example of using this image can be found in the [rawmind/alpine-zk][alpine-zk].

[confd]: http://www.confd.io/
