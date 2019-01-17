# Dockerized Kibana with Read Only Rest Plugin

## Building
```
docker build \
--build-arg THEME=nfors \
-t prominentedgestatengine/kibana:HEAD-b174f90-development \
-t prominentedgestatengine/public-kibana:HEAD-b174f90-development \
--no-cache
```

