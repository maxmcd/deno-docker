FROM phusion/baseimage

# complete ccache setup
ENV DENO_BUILD_MODE=release
ENV PATH="/usr/lib/ccache/:$PATH"
ENV CCACHE_SLOPPINESS=time_macros
ENV CCACHE_CPP2=yes
ENV PATH=/root/.cargo/bin:$PATH

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
    && rm -rf /var/lib/apt/lists/* \
    # set up ccache
    && mkdir -p /root/.ccache/ && touch /root/.ccache/ccache.conf \
    # install nodejs
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g yarn \
    # install rust
    && curl -sSf https://sh.rustup.rs | sh -s -- -y \
    # deno
    && cd /opt/ && git clone https://github.com/denoland/deno.git \
    && cd deno && git submodule update --init --recursive \
    && ccache -s \
    && ./tools/setup.py \
    && ./tools/build.py 
    # Accepts ninja build args
    # https://github.com/ninja-build/ninja/blob/ca041d88f4d610332aa48c801342edfafb622ccb/src/ninja.cc#L197-L220

WORKDIR /opt/deno

