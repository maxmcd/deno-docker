FROM maxmcd/deno:_build-cache

RUN git pull origin master
RUN ccache -s
RUN ./tools/build.py


