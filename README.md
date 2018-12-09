# rpi-alpine-couchpotato

# DEPRECATED: Please use https://hub.docker.com/r/lsioarmhf/couchpotato/ instead


[![Build Status](https://travis-ci.org/koukihai/rpi-alpine-couchpotato.svg?branch=master)](https://travis-ci.org/koukihai/rpi-alpine-couchpotato)

Download movies automatically, easily and in the best quality as soon as they are available with [Couchpotato](https://couchpota.to/)

# Summary
This image is designed to run Couchpotato on Raspberry Pi.  
It is based on Alpine Linux to make it as lightweight as possible.  

# Usage
```
docker run -d --name couchpotato \
  -v /etc/localtime:/etc/localtime:ro \
  -v /media/conf/couchpotato:/config \
  -v /media/Movies:/sorted \
  -v /media/Unsorted:/unsorted \
  -v /media/blackhole:/blackhole \
  -p 5050:5050 \
  koukihai/rpi-alpine-couchpotato
```
where:  
`/media/conf/couchpotato` is the folder on the host where you will store couchpotato configurations  
`/media/Movies` is the folder on the host where you will store completed and organized downloads  
`/media/Unsorted` is the folder on the host where you will store complete files waiting to be organized  
`/media/blackhole` is... just in case you need to plug a blackhole listener  

# Details
Couchpotato daemon will run as `couchpotato:users`  
Ensure that the `users` group has write permissions on the mapped volumes

# Credits
https://hub.docker.com/r/couchpotato/couchpotato/

