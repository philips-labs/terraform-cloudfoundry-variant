FROM prom/prometheus:v2.32.0 AS prometheus

## Variant
FROM philipssoftware/variant:v0.0.28 AS variant

## Build final image
FROM alpine:3.15.0
LABEL maintainer="andy.lo-a-foe@philips.com"
RUN apk add --no-cache supervisor jq curl && rm -rf /tmp/* /var/cache/apk/*
RUN apk add --no-cache yq --repository http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN mkdir -p /sidecars/bin /sidecars/supervisor/conf.d /sidecars/etc /prometheus

COPY --from=prometheus /bin/prometheus /sidecars/bin
COPY --from=prometheus /bin/promtool   /bin
COPY --from=variant    /app/app        /sidecars/bin/variant

COPY prometheus/  /sidecars/etc
COPY supervisord_configs/ /sidecars/supervisor/conf.d
COPY scripts/ /sidecars/bin

ENV ENABLE_VARIANT=true

EXPOSE 9090

COPY supervisord.conf /etc/
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
