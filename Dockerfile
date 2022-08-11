FROM debian:bullseye

RUN apt-get update -y && apt-get install -y --no-install-recommends ca-certificates curl xz-utils flex bison make gcc libelf-dev systemtap-sdt-dev libssl-dev libslang2-dev libperl-dev python-dev liblzma-dev libzstd-dev libcap-dev libnuma-dev libbabeltrace-ctf-dev libdw-dev libiberty-dev python3-pip patchelf
RUN pip3 install staticx
WORKDIR /workspace
RUN curl -L https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.19.tar.xz | tar -xJ
RUN cd linux-5.19/tools/perf && \
  LDFLAGS=-static make && \
  make install && \
  staticx --no-compress perf perf-static
