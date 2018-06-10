FROM maxmcd/deno:_build-cache-jessie as deno_jessie
RUN make
FROM debian:jessie-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates
WORKDIR /opt/
COPY --from=deno_jessie /go/src/github.com/ry/deno/deno .
CMD ["./deno"]  
