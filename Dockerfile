FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xvfb \
    x11vnc \
    fluxbox \
    supervisor \
    novnc \
    websockify \
    wget \
    gpg \
    ca-certificates

RUN wget -O /tmp/chrome.deb "https://www.slimjet.com/chrome/download-chrome.php?file=files%2F102.0.5005.63%2Fgoogle-chrome-stable_current_amd64.deb" \
    && apt install -y /tmp/chrome.deb || true \
    && apt --fix-broken install -y \
    && rm /tmp/chrome.deb

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5900 6080
CMD ["/usr/bin/supervisord"]
