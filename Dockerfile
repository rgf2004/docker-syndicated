FROM phusion/baseimage

RUN apt-get update && apt-get install unzip

ADD https://github.com/SyndicateLtd/SyndicateQT/releases/download/v2.0.0/Syndicate-2.0.0-x86_64-linux-gnu.zip /tmp/
RUN unzip /tmp/Syndicate-*.zip -d /tmp/
RUN rm /tmp/*.zip
RUN cp /tmp/*  /usr/local/bin
RUN rm -rf /tmp/*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.

EXPOSE 25992 25993

CMD  ["synx_oneshot"]
