#!/bin/bash

# Run Kibana
/usr/share/kibana/bin/kibana \
  -e $ELASTICSEARCH_URI \
  --server.host=$SERVER_HOST \
  --elasticsearch.username=$ELASTICSEARCH_KIBANA_USER \
  --elasticsearch.password=$ELASTICSEARCH_KIBANA_PASSWORD \
  --readonlyrest_kbn.custom_logout_link=$ROR_CUSTOM_LOGOUT_LINK \
  --readonlyrest_kbn.jwt_query_param="jwt" \
  --readonlyrest_kbn.session_timeout_minutes=525600 \
  --server.basePath=$SERVER_BASEPATH \
  --server.rewriteBasePath=true \
  --verbose
