FROM alpine:edge as builder
RUN apk upgrade --update-cache --available
RUN apk add ghc curl musl-dev zlib-dev
RUN curl -sSL https://get.haskellstack.org/ | sh
WORKDIR /opt/server
RUN stack update
COPY ./blockchain.cabal /opt/server/blockchain.cabal
RUN stack setup --system-ghc
COPY . /opt/server
RUN stack build --system-ghc --ghc-options '-optl-static -fPIC'

FROM alpine:3.6 
RUN apk upgrade --update-cache --available
RUN apk add musl-dev zlib-dev
WORKDIR /usr/bin
COPY --from=builder /opt/server/.stack-work/install/x86_64-linux/lts-9.6/8.0.2/bin .
EXPOSE 9000
ENV SEED localhost:9999
# workarround
# https://stackoverflow.com/questions/40873165/use-docker-run-command-to-pass-arguments-to-cmd-in-dockerfile
CMD ["sh", "-c", "./blockchain-exe 127.0.0.1 9000 ${SEED}"]