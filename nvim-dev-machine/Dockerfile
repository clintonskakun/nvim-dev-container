FROM alpine:3.23 as builder

LABEL maintainer="Clinton Skakun <clinton.d.skakun@dedupe.ly>"

RUN apk update && apk add --no-cache --virtual .build-deps \
    make \
    curl \
    wget \
    unzip \
    gcc \
    g++ \
    python3 \
    linux-headers \
    binutils-gold \
    build-base \
    coreutils \
    gettext-tiny-dev \
    git \
    gnupg \
    libstdc++ \
    cmake \
    python3 \
    git

ENV NODE_VERSION=24.13.0

RUN git clone --depth 1 https://github.com/neovim/neovim /tmp/neovim && \
    cd /tmp/neovim && \
    make -j1 CMAKE_BUILD_TYPE=Release && \
    make install DESTDIR=/tmp/nvim-install && \
    cd / && \
    rm -rf /tmp/neovim

RUN apk del .build-deps

FROM alpine:3.23

RUN apk update && apk add --no-cache \
    libstdc++ \
    ripgrep \
    zig \
    wl-clipboard \
    curl \
    build-base \
    lua5.1 \
    luarocks5.1 \
    docker-cli \
    openssh-client \
    git \
    nodejs \
    npm \
    python3 \
    bash

COPY --from=builder /tmp/nvim-install/usr/local /usr/local

RUN npm install -g typescript typescript-language-server svelte-language-server @prisma/language-server @prisma/engines neovim

COPY nvim-dev-machine/xdg-open /usr/local/bin/xdg-open
RUN chmod +x /usr/local/bin/xdg-open

RUN git config --global user.name "Your Name Here" && \
    git config --global user.email "your.email@example.com" && \
    git config --global --add safe.directory /repo && \
    git config --global pull.rebase false

WORKDIR /repo
ENV REMOTE_CONTAINERS='true'

EXPOSE 3000
EXPOSE 5173
EXPOSE 5555

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["sleep infinity"]
