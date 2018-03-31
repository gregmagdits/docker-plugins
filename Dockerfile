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
RUN chmod +x /setup.sh
RUN chown root:root setup.sh
RUN bash -c "/setup.sh"
ADD start /start.sh
RUN cp /root/go/src/github.com/gregmagdits/dockerhook/dockerhook /bin/dockerhook
ADD https://github.com/dokku/plugn/releases/download/v0.3.0/plugn_0.3.0_linux_x86_64.tgz              /tmp/plugn.tgz
RUN  cd /bin && tar -zxf /tmp/plugn.tgz && rm /tmp/plugn.tgz \
    && chmod +x  /bin/plugn \
    && chown root:root  /bin/plugn
CMD ["/start.sh"]
