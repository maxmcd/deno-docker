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
RUN mkdir -p /root/.ccache/ && touch /root/.ccache/ccache.conf
ENV CCACHE_SLOPPINESS=time_macros
ENV CCACHE_CPP2=yes

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g yarn

RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

RUN cd /opt/ && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH=$PATH:/opt/depot_tools
