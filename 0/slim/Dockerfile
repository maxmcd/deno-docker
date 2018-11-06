FROM debian:jessie-slim

ENV DENO_VERSION 0.1.11

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSLO --compressed "https://github.com/denoland/deno/releases/download/v$DENO_VERSION/deno_linux_x64.gz" \
    && gunzip -c deno_linux_x64.gz > /usr/local/bin/deno \
    && chmod u+x /usr/local/bin/deno \
    && rm deno_linux_x64.gz 

CMD [ "deno" ]
