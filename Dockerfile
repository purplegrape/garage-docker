FROM alpine:3.23
COPY --from=docker.io/dxflrs/garage:v2.3.0 --chmod=755 /garage /usr/bin/garage
ADD --chmod=644 garage.toml /etc/garage.toml
ADD --chmod=755 entrypoint.sh /entrypoint.sh

RUN install -d -m 755 -o nobody -g nobody /data/garage
RUN apk update && \
    apk add --no-cache bash bash-completion openssl su-exec tzdata && \
    rm -rf /var/cache/apk/*

RUN garage completions bash > /usr/share/bash-completion/completions/garage

VOLUME [ "/data" ]
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/usr/bin/garage","server" ]
EXPOSE 3900 3901 3902 3903
