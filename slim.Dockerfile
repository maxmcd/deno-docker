FROM maxmcd/deno:master as deno_from_scratch
RUN make
FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /opt/
COPY --from=deno_from_scratch /go/src/github.com/ry/deno/deno .
CMD ["./deno"]  
