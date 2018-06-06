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

RUN wget https://github.com/google/protobuf/releases/download/v3.1.0/protoc-3.1.0-linux-x86_64.zip \
    && unzip protoc-3.1.0-linux-x86_64.zip \
    && mv bin/protoc /usr/local/bin \
    && rm -rf include \
    && rm readme.txt \
    && rm protoc-3.1.0-linux-x86_64.zip

RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN go get -u github.com/jteeuwen/go-bindata/...

# v8worker2 build wants a valid git config
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"

# Pulling submodules manually, errors abound with go get
# See: https://github.com/ry/deno/issues/92
RUN mkdir -p $GOPATH/src/github.com/ry/v8worker2 
RUN cd $GOPATH/src/github.com/ry/v8worker2 \
    && git clone https://github.com/ry/v8worker2.git . \
    && rm -rf v8 \
    && git clone https://github.com/v8/v8.git && cd v8 \
    && cd .. \
    && rm -rf depot_tools \
    && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git \
    && git submodule update --init --recursive \
    && cd $GOPATH/src/github.com/ry/v8worker2 \
    && python -u ./build.py --use_ccache \
    && rm -rf $GOPATH/src/github.com/ry/v8worker2/v8/build \
    && rm -rf $GOPATH/src/github.com/ry/v8worker2/v8/.git \
    && rm -rf $GOPATH/src/github.com/ry/v8worker2/v8/third_party \
    && rm -rf $GOPATH/src/github.com/ry/v8worker2/v8/test \
    && rm -rf $GOPATH/src/github.com/ry/v8worker2/depot_tools 
