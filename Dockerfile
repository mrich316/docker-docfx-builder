FROM mono:6.10

ARG DOCFX_VERSION=v2.56.2
ARG DOCFX_SHA512SUM=5e265e5789178e913ce156a56f6fb42addcae1fd07058204b1fb0831a3f76d5d52dfb557e0587d69406d72a43b6458e45d59670b7a46d2ade13d99bbabfb4fec

ENV \
  DOCFX_VERSION=$DOCFX_VERSION \
  DOCFX_SHA512SUM=$DOCFX_SHA512SUM

COPY docker-entrypoint.sh /

RUN apt-get update \
 && apt-get -y install unzip \
 && mkdir -p /opt/docfx \
 && curl -sSL --output docfx.zip "https://github.com/dotnet/docfx/releases/download/${DOCFX_VERSION}/docfx.zip" \
 && sha512sum docfx.zip \
 && docfx_sha512=${DOCFX_SHA512SUM} \
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
