FROM maxmcd/deno:_build-cache

# Will not exit cleanly before make populates proto structs
RUN go get -u github.com/ry/deno/... || true

WORKDIR $GOPATH/src/github.com/ry/deno
RUN make

CMD make
