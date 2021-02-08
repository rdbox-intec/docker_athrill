FROM ubuntu:xenial-20200916 as athrill-builder

ARG DEBIAN_FRONTEND=noninteractive

COPY . /root

RUN apt-get update && apt-get install -y \
        build-essential

WORKDIR /root/athrill-target-ARMv7-A/build_linux
RUN make timer32=true clean && \
    make timer32=true -f Makefile.static

FROM ubuntu:xenial-20200916
COPY --from=athrill-builder /root/athrill/bin/linux/athrill2 /usr/local/bin