FROM alpine:3.7 as builder

RUN apk add --no-cache zip

ARG THEME=nfors
ENV THEME=${THEME}

COPY kibana /kibana

COPY themes/${THEME}/styles/custom_style.less /kibana/custom_style/public/less/custom_style.less

RUN zip -r /custom_style.zip kibana

FROM docker.elastic.co/kibana/kibana:6.4.1

ARG ROR_VERSION=readonlyrest_kbn_enterprise-1.16.33_es6.4.1.zip
ENV ROR_VERSION=${ROR_VERSION}

ARG THEME=nfors
ENV THEME=${THEME}

#ARG COOKIE_PASS=pv2PXhd5M6ILsa9WQw1wZ3u4QMSzrUjNMuBUV23pNy1nW
#ENV COOKIE_PASS=${COOKIE_PASS}

ENV SERVER_HOST=0.0.0.0
ENV SERVER_BASEPATH=/_plugin/kibana
ENV ELASTICSEARCH_URI=http://docker.for.mac.localhost:9200
ENV ELASTICSEARCH_KIBANA_USER=kibana
ENV ELASTICSEARCH_KIBANA_PASSWORD=kibana
ENV REPORTING_KEY=abc123
ENV ROR_CUSTOM_LOGOUT_LINK=https://statengine.io

# Custom plugins
COPY ${ROR_VERSION} /usr/share/kibana/${ROR_VERSION}

# Custom favicons
COPY themes/${THEME}/favicons/* /usr/share/kibana/src/ui/public/assets/favicons/

# Custom throbber
RUN sed -i 's/Kibana/Dashboard/g' /usr/share/kibana/src/core_plugins/kibana/translations/en.json
COPY themes/${THEME}/logo.b64 /usr/share/kibana/logo.b64
RUN sed -i "s/image\/svg+xml.*\");/image\/svg+xml;base64,$(cat /usr/share/kibana/logo.b64)\");/g" /usr/share/kibana/src/ui/ui_render/views/chrome.jade /usr/share/kibana/src/ui/ui_render/views/ui_app.jade;

# Custom back button
RUN sed -i "s/<\/global-nav-link>/<\/global-nav-link><global-nav-link tooltip-content=\"'Back to home'\" onclick=\"window.location.replace('\/'); return false;\" icon=\"'plugins\/kibana\/assets\/logout.svg'\" label=\"'Back'\"><\/global-nav-link><global-nav-link class=\"attribution-logo\" onclick=\"window.open('https:\/\/statengine.io'); return false;\"><\/global-nav-link>/g" /usr/share/kibana/src/ui/public/chrome/directives/global_nav/global_nav.html;

# Custom HTML title information
RUN sed -i 's/title Kibana/title Dashboard/g' /usr/share/kibana/src/ui/ui_render/views/chrome.jade

# Custom css plugin
COPY --from=builder /custom_style.zip /usr/share/kibana/custom_style.zip
RUN sed -i "s/createAnchor('{{bundlePath}}\/commons.style.css')/createAnchor('{{bundlePath}}\/commons.style.css'),createAnchor('{{bundlePath}}\/custom_style.style.css')/g" /usr/share/kibana/src/ui/ui_render/bootstrap/template.js.hbs

# Run script and config
COPY config/kibana.yml /usr/share/kibana/config/
COPY bin/docker-run.sh /usr/share/kibana/

# Plugins
RUN bin/kibana-plugin install file:///usr/share/kibana/custom_style.zip
RUN bin/kibana-plugin install file:///usr/share/kibana/${ROR_VERSION}
RUN bin/kibana-plugin install https://github.com/datasweet/kibana-datasweet-formula/releases/download/v2.0.0/datasweet_formula-2.0.0_kibana-6.4.1.zip
RUN bin/kibana-plugin install https://github.com/prelert/kibana-swimlane-vis/releases/download/v6.4.1/prelert_swimlane_vis-6.4.1.zip

CMD /usr/share/kibana/docker-run.sh

EXPOSE 5601

