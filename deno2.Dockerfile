FROM golang:1.10-stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    ca-certificates \
    # Deps for v8worker2 build
    ccache \
    xz-utils \
    lbzip2 \
    libglib2.0 \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* 

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g yarn

RUN cd /opt/ && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH=$PATH:/opt/depot_tools

RUN mkdir -p $GOPATH/src/github.com/ry/deno 
WORKDIR $GOPATH/src/github.com/ry/deno
RUN git clone https://github.com/ry/deno.git .
RUN git checkout deno2
WORKDIR $GOPATH/src/github.com/ry/deno/deno2
RUN cd js; yarn install
RUN ./tools/build.py --use_ccache --debug
