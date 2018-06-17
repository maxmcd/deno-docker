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

ENV PATH="/usr/lib/ccache/:$PATH"

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g yarn

RUN cd /opt/ && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH=$PATH:/opt/depot_tools

WORKDIR /opt/
RUN git clone https://github.com/ry/deno.git
WORKDIR /opt/deno/deno2
RUN cd js; yarn install
RUN gclient sync --no-history

RUN gn gen out/Debug --args='cc_wrapper="ccache" is_debug=true '
RUN ninja -C out/Debug/ deno

CMD /opt/deno/deno2/out/Debug/deno
