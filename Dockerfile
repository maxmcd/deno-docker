FROM maxmcd/deno:_build-cache

RUN git pull origin master
RUN ccache -s
RUN ./tools/build.py
RUN mv /opt/deno/out/release/deno /usr/local/bin/deno
