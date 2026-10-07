# syntax=docker/dockerfile:1
# ECO client lab desktop. Does not download or contain the official client.
# Option A (default): bind-mount your local client at /eco
# Option B: build with --build-arg INSTALL_CLIENT=1 after placing files in client-src/

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    WINEPREFIX=/home/eco/.wine \
    WINEARCH=win32 \
    DISPLAY=:1 \
    ECO_ROOT=/eco \
    ECO_EXE=eco.exe \
    VNC_PORT=5900 \
    NOVNC_PORT=6080 \
    SCREEN=1280x720x24

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        fluxbox \
        fonts-noto-cjk \
        novnc \
        procps \
        websockify \
        wine \
        wine32 \
        wine64 \
        winbind \
        x11vnc \
        xvfb \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --shell /bin/bash eco \
    && mkdir -p /eco /opt/eco-baked \
    && chown -R eco:eco /home/eco /opt/eco-baked

# Option B source. Git only contains a placeholder; never commit the real client.
COPY client-src/ /tmp/client-src/
ARG INSTALL_CLIENT=0
RUN if [ "$INSTALL_CLIENT" = "1" ]; then \
      if [ ! -f /tmp/client-src/eco.exe ]; then \
        echo "INSTALL_CLIENT=1 but client-src/eco.exe is missing" >&2; \
        exit 1; \
      fi; \
      cp -a /tmp/client-src/. /opt/eco-baked/; \
    fi \
    && rm -rf /tmp/client-src \
    && chown -R eco:eco /opt/eco-baked

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

USER eco
WORKDIR /home/eco
EXPOSE 6080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
