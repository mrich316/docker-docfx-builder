FROM mono:5.16

ENV DOCFX_VERSION=v2.40.7
COPY docker-entrypoint.sh /

RUN apt-get update \
 && apt-get -y install unzip \
 && mkdir -p /opt/docfx \
 && curl -sSL --output docfx.zip "https://github.com/dotnet/docfx/releases/download/${DOCFX_VERSION}/docfx.zip" \
 && sha512sum docfx.zip \
 && docfx_sha512='dd00b201d0b5d4afae79618e57ad5538c53ff914dbb259bf95ee5f78818503b81444deee8cd4c57f8e811f293a54a953c7822980fdf77631a1935091d7fa96b0' \
 && echo "$docfx_sha512  docfx.zip" | sha512sum -c - \
 && unzip docfx.zip -d /opt/docfx/ \
 && rm docfx.zip \
 && apt-get -y purge unzip \
 && rm -rf /var/cache/apt/* \
 && chmod 755 /docker-entrypoint.sh \
 && adduser \
        --uid 1000 \
        --shell /bin/false \
        --no-create-home \
        --gecos "" \
        --disabled-password \
        --disabled-login \
      docfx \
 && chmod 755 /docker-entrypoint.sh

USER docfx
EXPOSE 8080
ENTRYPOINT [ "/docker-entrypoint.sh" ]
WORKDIR /doc
