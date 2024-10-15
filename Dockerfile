
FROM debian:bookworm-20230725-slim

ENV DEBIAN_FRONTEND=noninteractive

ARG ARCH=amd64

RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    jq \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO https://github.com/ipfs/kubo/releases/download/v0.30.0/kubo_v0.30.0_linux-$ARCH.tar.gz && \
    tar -xvzf kubo_v0.30.0_linux-$ARCH.tar.gz && \
    bash kubo/install.sh && \
    rm -rf kubo kubo_v0.30.0_linux-$ARCH.tar.gz

COPY ./carize.sh /carize.sh
RUN chmod +x /carize.sh

CMD ["/carize.sh"]