FROM --platform=linux/amd64 ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install tzdata
RUN apt-get -y install nginx-full
RUN apt-get -y install curl
RUN apt-get -y install xz-utils


ENV USER_ID=1000
ENV USER_NAME=webuser

RUN useradd -ms /bin/bash ${USER_NAME} -u ${USER_ID}

COPY ./deploy /deploy
RUN chown -R ${USER_NAME}:${USER_NAME} /deploy
RUN chmod +x /deploy/service.sh


RUN ln -sf /deploy/nginx.conf /etc/nginx/nginx.conf
RUN ln -sf /deploy/proxy.conf /etc/nginx/proxy.conf


CMD bash -c "/deploy/service.sh"
