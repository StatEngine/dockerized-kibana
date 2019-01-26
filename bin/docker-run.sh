#!/bin/bash

# Run Kibana
/usr/share/kibana/bin/kibana \
  -e $ELASTICSEARCH_URI \
  --server.host=$SERVER_HOST \
  --server.basePath=$SERVER_BASEPATH \
  --server.rewriteBasePath=false \
  --elasticsearch.username=$ELASTICSEARCH_KIBANA_USER \
  --elasticsearch.password=$ELASTICSEARCH_KIBANA_PASSWORD \
  --readonlyrest_kbn.custom_logout_link=$ROR_CUSTOM_LOGOUT_LINK \
  --readonlyrest_kbn.jwt_query_param="jwt" \
  #--readonlyrest_kbn.cookiePass=${COOKIE_PASS} \
  --verbose
