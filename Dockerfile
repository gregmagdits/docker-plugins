FROM ubuntu:14.04.5
MAINTAINER Jeff Lindsay <progrium@gmail.com>

RUN apt-get update && apt-get install -y curl jq git gcc wget \
&& curl -O https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz \
&& tar -xf go1.9.1.linux-amd64.tar.gz  \
&& mv go /usr/local/ \
&& chmod +x /usr/local/go \ 
&& chown root:root /usr/local/go

ADD https://get.docker.com/builds/Linux/x86_64/docker-17.03.0-ce.tgz  /tmp/docker.tgz
RUN    cd /tmp && tar -zxf /tmp/docker.tgz     && rm /tmp/docker.tgz && mv /tmp/docker/* /bin \
    && chmod +x /bin/docker* \
    && chown root:root /bin/docker*

ADD ./plugins /plugins 
ENV PLUGIN_PATH /plugins

ADD setup.sh /
RUN bash -c "/setup.sh"
ADD start.sh /start.sh
CMD ["/start"]