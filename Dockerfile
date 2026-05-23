# Dockerfile para cross-compilação do Eldritch para R36S (aarch64)
# Base: Ubuntu 20.04 (Focal) — glibc 2.31, compatível com ArkOS/R36S
# IMPORTANTE: NÃO usar 22.04 (glibc 2.35) — o ArkOS tem glibc 2.31

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# ---------------------------------------------------------------------------
# 1. Configurar multiarch: amd64 de archive.ubuntu.com,
#                          arm64 de ports.ubuntu.com
# ---------------------------------------------------------------------------
RUN dpkg --add-architecture arm64 \
    && printf '\
deb [arch=amd64] http://archive.ubuntu.com/ubuntu focal main restricted universe multiverse\n\
deb [arch=amd64] http://archive.ubuntu.com/ubuntu focal-updates main restricted universe multiverse\n\
deb [arch=amd64] http://archive.ubuntu.com/ubuntu focal-security main restricted universe multiverse\n\
deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports focal main restricted universe multiverse\n\
deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports focal-updates main restricted universe multiverse\n\
deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports focal-security main restricted universe multiverse\n\
' > /etc/apt/sources.list

# ---------------------------------------------------------------------------
# 2. Instalar toolchain e libs
# ---------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu \
        binutils-aarch64-linux-gnu \
        cmake \
        make \
        pkg-config \
        file \
        libsdl2-dev:arm64 \
        libopenal-dev:arm64 \
        libgles2-mesa-dev:arm64 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
