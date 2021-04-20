FROM docker.io/debian:buster-20210408-slim
MAINTAINER Daniel Kühne <dkhmailto@gmail.com>

LABEL maintainer="dkhmailto@gmail"

ENV GLAUTH_VERSION=1.1.2

RUN set -x && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl ca-certificates && \
  export DOWNLOAD_FILE="glauth64" && \
  if [ "$(uname -m)" = "aarch64" ]; then export DOWNLOAD_FILE="glauth-arm64"; fi && \
  curl -sSL "https://github.com/glauth/glauth/releases/download/v${GLAUTH_VERSION}/${DOWNLOAD_FILE}" -o /usr/local/bin/glauth && \
  chmod +x /usr/local/bin/glauth && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ADD docker-entrypoint.sh /

EXPOSE [1389, 1636, 5555]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["glauth"]
