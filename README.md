# Dockerized Kibana with Read Only Rest Plugin

## Building
Obtain copy of readonly_rest_kbn_enterprise_<version>.zip and copy to the root of this directory, then run
```
docker build \
--build-arg THEME=nfors \
-t prominentedgestatengine/nfors-kibana:HEAD-latest-development \
--no-cache \
.
```
## Running
```
docker run -p 5601:5601 prominentedgestatengine/nfors-kibana:HEAD-latest-development
```