FROM ubuntu:trusty
MAINTAINER Arcus "http://arcus.io"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget nginx-full
RUN cd /tmp \
  && wget -nv https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz -O kibana.tar.gz \
  && tar zxf kibana.tar.gz \
  && cd kibana-* \
  && cp -rf ./* /usr/share/nginx/www/ \
  && rm kibana.tar.gz
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 80
CMD ["/usr/local/bin/run"]
