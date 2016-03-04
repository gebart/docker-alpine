FROM alpine:edge
MAINTAINER Joakim Nohlgård <joakim.nohlgard@eistec.se>

ADD . /build

RUN chmod 750 /build/system_services.sh
RUN /build/system_services.sh 

CMD ["/sbin/my_init"]
