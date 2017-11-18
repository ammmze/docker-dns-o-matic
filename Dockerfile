FROM alpine

VOLUME /config
COPY ./dns-o-matic.sh /

RUN chmod a+x /dns-o-matic.sh && apk add --no-cache curl

ENTRYPOINT ["/dns-o-matic.sh"]
