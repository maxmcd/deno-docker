FROM maxmcd/deno:master as deno_from_scratch
RUN make
FROM debian:stretch-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates
WORKDIR /opt/
COPY --from=deno_from_scratch /go/src/github.com/ry/deno/deno .
CMD ["./deno"]  
