# Dockerized Kibana with Read Only Rest Plugin

## Building
```
docker build \
--build-arg THEME=nfors \
-t prominentedgestatengine/nfors-kibana:HEAD-latest-development \
--no-cache \
.
```

