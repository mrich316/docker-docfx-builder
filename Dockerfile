FROM mono:5.16

ENV DOCFX_VERSION=v2.40.4

RUN apt-get update \
 && apt-get -y install unzip \
 && mkdir -p /opt/docfx \
 && curl -sSL --output docfx.zip "https://github.com/dotnet/docfx/releases/download/${DOCFX_VERSION}/docfx.zip" \
 && sha512sum docfx.zip \
 && docfx_sha512='3ee0b39d4ac2c7d9b42a7387639a2e7f535ae4ed16d8e55cc1d7ef08063bb757b3231d8d75890b37dc24bb418c0fc1b05c021f68de3ae4435bf2dfc8c4c5e6ce' \
 && echo "$docfx_sha512  docfx.zip" | sha512sum -c - \
 && unzip docfx.zip -d /opt/docfx/ \
 && rm docfx.zip \
 && apt-get -y purge unzip \
 && rm -rf /var/cache/apt/*

WORKDIR /app
