FROM python:3.6.6-slim

ENV GOLANG_VERSION 1.10.3
ENV NODE_VERSION 9.x

RUN apt-get update && apt-get install -y --no-install-recommends \
                ca-certificates \
                wget \
                git \
                curl \
                bzip2 \
                gcc \
                g++ \
                make \
                gnupg \
                gnupg2 \
                gnupg1 \
                build-essential \
                default-libmysqlclient-dev \
        && \
    set -eux; \
                goRelArch='linux-amd64'; goRelSha256='fa1b0e45d3b647c252f51f5e1204aba049cde4af177ef9f2181f43004f901035'; \
                url="https://golang.org/dl/go${GOLANG_VERSION}.${goRelArch}.tar.gz"; \
                wget -O go.tgz "$url"; \
                echo "${goRelSha256} *go.tgz" | sha256sum -c -; \
                tar -C /usr/local -xzf go.tgz; \
                rm go.tgz; \
                export PATH="/usr/local/go/bin:$PATH"; \
                go version \
        && mkdir -p "/go/src" "/go/bin" && chmod -R 777 "/go" \
        && \
    curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}" | bash - \
        && apt-get install -y --no-install-recommends \
                nodejs \
        && npm install -g \
                npm@latest \
                yarn \
        && \
    rm -rf /var/lib/apt/lists/*

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
