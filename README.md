alpine-tools
=============

A base image to expose tools to services. It's based in alpine-base, adding [confd][confd] as config management and [jq][jq] as tool.

##Build

```
docker build -t <repo>/alpine-tools:<version> .
```

## Tools volume

This images creates a volume ${SERVICE_VOLUME} and permits share tools with the services, avoiding coupling service with configuration.

That volume has the following structure:

```
|- /opt/tools 		# SERVICE_VOLUME base path
|-|- confd 			# Confd directory
|-|-|- etc
|-|-|-|- templates
|-|-|-|- conf.d
|-|-|- bin
|-|- monit/conf.d 	# Monit start script directory
|-|- scripts 		# Scripts directory
```

## Volume owner

The entrypoint set correct owner to ${SERVICE_VOLUME} volume. You must provide UID and GID for your service, overriding env variables:

- SERVICE_UID=${SERVICE_UID:-"0"} 
- SERVICE_GID=${SERVICE_GID:-"0"}
- SERVICE_VOLUME=${SERVICE_VOLUME:-"/opt/tools"}
- SERVICE_ARCHIVE=${SERVICE_ARCHIVE:-"/opt/tools.tgz"}
- KEEP_ALIVE=${KEEP_ALIVE:-"0"} 	# Set to "1" to run in kubernetes as multicontainer pod. To keep alive.


## Config management

This image compiles and intall confd under ${SERVICE_VOLUME}/confd, to make it super simple to get dinamic configuration for your service. 


## Versions

- `3.5-1` [(Dockerfile)](https://github.com/rawmind0/alpine-tools/blob/3.5-1/Dockerfile)
- `0.3.4-7` [(Dockerfile)](https://github.com/rawmind0/alpine-tools/blob/0.3.4-7/Dockerfile)

## Usage

To use this image include `FROM rawmind/alpine-tools` at the top of your `Dockerfile`, and add whaever tool you need your services under /opt/tools.

Starting from `rawmind/alpine-tools` provides you with the ability to easily get dinamic configuration using confd. confd will also keep running checking for config changes, restarting your service.

This image has to be started once as a sidekick of your service (based in alpine-monit), exporting a ${SERVICE_VOLUME} volume to it. It adds monit conf.d to start confd with a default parameters, that you can overwrite with environment variables.


## Examples

An example of using this image can be found in the [rawmind/rancher-tools][rancher-tools].

An example of using this image can be found in the [rawmind/k8s-tools][k8s-tools].


[confd]: http://www.confd.io/
[jq]: https://github.com/stedolan/jq
[rancher-tools]: https://github.com/rawmind0/rancher-tools
[k8s-tools]: https://github.com/rawmind0/k8s-tools

