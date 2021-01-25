
# t-rex container

FROM debian:testing

RUN apt-get update \
    && apt-get install -y \
    curl \
    libssl1.1 \
    gdal-bin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG VERSION_TAG=0.12.0

RUN curl -O -L \
    https://github.com/t-rex-tileserver/t-rex/releases/download/v${VERSION_TAG}/t-rex-v${VERSION_TAG}-x86_64-linux-gnu.tar.gz \
    && tar xf t-rex-v${VERSION_TAG}-x86_64-linux-gnu.tar.gz -C /usr/local/bin \
    && rm t-rex-v${VERSION_TAG}-x86_64-linux-gnu.tar.gz

RUN mkdir -p /var/data/in
WORKDIR /var/data/in
COPY ./myconfig.toml /var/data/in/myconfig.toml

# VOLUME ["/var/data/in"]
# VOLUME ["/var/data/out"]

EXPOSE 6767

# ENTRYPOINT /bin/bash
# CMD ls -al
ENTRYPOINT ["/usr/local/bin/t_rex"]
CMD serve --openbrowser=false --config=/var/data/in/myconfig.toml

