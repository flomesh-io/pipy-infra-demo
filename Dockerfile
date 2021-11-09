FROM flomesh/pipy-pjs:0.4.0-203

COPY /scripts /scripts
ENTRYPOINT [ "pipy", "/scripts/main.js" ]