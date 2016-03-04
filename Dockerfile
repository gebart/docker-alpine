FROM armhf/alpine:edge
MAINTAINER Joakim Nohlgård <joakim.nohlgard@eistec.se>

ADD . /build

# emulation for binfmt-misc support when cross-building
COPY qemu-arm-cortex-a8 /usr/bin/
COPY qemu-arm /usr/bin/

RUN chmod 750 /build/system_services.sh
RUN /build/system_services.sh

CMD ["/sbin/my_init"]
