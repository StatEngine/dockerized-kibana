# Dockerized Kibana with Read Only Rest Plugin

## Building
* Pull plugin from S3:
```
aws s3 cp s3://statengine-artifacts/readonlyrest_kbn_enterprise-1.21.0_es7.1.1.zip ./plugins/
```

Obtain copy of readonly_rest_kbn_enterprise_<version>.zip and copy to the root of this directory, then run
```
docker build \
--build-arg THEME=nfors \
-t prominentedgestatengine/kibana-nfors:HEAD-latest-development \
--no-cache \
.
```
## Running
```
docker run -p 5601:5601 prominentedgestatengine/kibana-nfors:HEAD-latest-development
```
