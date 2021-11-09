FROM flomesh/pipy-pjs:0.4.0-205
LABEL maintainer="Kevein Liu<kevein@flomesh.cn>"

ARG RELEASE_VERSION
ENV RELEASE_VERSION=${RELEASE_VERSION:-0.4.0}

ARG REVISION
ENV REVISION=${REVISION:-1}

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

STOPSIGNAL SIGQUIT

CMD ["pipy", "node-start"]
