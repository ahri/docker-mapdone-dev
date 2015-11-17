FROM alpine:3.2

RUN apk add --update git=2.4.1-r0 openssh-client=6.8_p1-r4 \
        ruby-rake=2.2.2-r0 nodejs=0.12.2-r0 && \
    rm -rf /var/cache/apk/*

EXPOSE 13116

ADD go.sh /
ENTRYPOINT ["/go.sh"]
