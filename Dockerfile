# Container image that runs your code
FROM debian:bookworm-slim
LABEL org.opencontainers.image.source="https://github.com/loonwerks/INSPECTA-CI-Action-Container"
ARG SIREUM_VERSION=4.20250825.20d1bda

# Fetch some basics
RUN apt-get update -q \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        jq \
        libgtk-3-0 \
        tar \
        xauth \
        xvfb \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Copies script for installation of Sireum toolsuite into the container
COPY install_sireum.sh /install_sireum.sh
RUN chmod +x /install_sireum.sh

# Run the install script to download and install Sireum
RUN SIREUM_V=${SIREUM_VERSION} /install_sireum.sh


