FROM phusion/baseimage

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libgtk-3-dev \
    pkg-config \
    ccache \
    curl \
    gnupg \
    build-essential \
    git \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* 

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g yarn

RUN cd /opt/ && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH=$PATH:/opt/depot_tools

WORKDIR /opt/
RUN git clone https://github.com/ry/deno.git
WORKDIR /opt/deno/deno2
RUN cd js; yarn install
RUN ./tools/build.py --use_ccache --debug

CMD /opt/deno/deno2/out/Debug/deno
