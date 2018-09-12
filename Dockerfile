FROM maxmcd/deno:_build-cache

RUN git pull origin master && git submodule update
RUN ccache -s
RUN ./tools/build.py
RUN mv /opt/deno/out/release/deno /usr/local/bin/deno
