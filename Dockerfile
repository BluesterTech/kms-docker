# stream oriented kurento
#
# VERSION               0.0.1

FROM daocloud.io/library/ubuntu:14.04
MAINTAINER Sirormy <sirormy@gmail.com>
RUN sed -i 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/mirrors\.163\.com\/ubuntu\//g' /etc/apt/sources.list
RUN apt-get update \
  && apt-get -y dist-upgrade \
  && apt-get install -y wget

RUN echo "deb http://ubuntu.kurento.org/ trusty kms6" | tee /etc/apt/sources.list.d/kurento.list
RUN wget -O - http://ubuntu.kurento.org/kurento.gpg.key | apt-key add - 
RUN apt-get update
RUN apt-get -y install kurento-media-server-6.0
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8888

COPY ./entrypoint.sh /entrypoint.sh

ENV GST_DEBUG=Kurento*:5

ENTRYPOINT ["/entrypoint.sh"]