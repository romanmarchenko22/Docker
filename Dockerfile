FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Kiev

LABEL maintainer="Roman Marchenko <roman.marchenko@globallogic.com>"

WORKDIR /root/

ENV USER root

ENV PATH="/android_build/bin:${PATH}"

RUN apt-get update && apt-get upgrade -y

#install essential build
RUN apt-get install -y bison build-essential cpio curl device-tree-compiler dosfstools flex fontconfig g++-multilib gcc-multilib gdisk gettext git git-core gnupg kmod lib32ncurses5-dev lib32z1-dev libc6-dev-i386 libgl1-mesa-dev libssl-dev libx11-dev libxml2-utils mtools python3-dev python3-pip python-dev python-pip rsync software-properties-common ssh swig unzip x11proto-core-dev xsltproc zip zlib1g-dev
                                     
#install Mako 
RUN apt-get update && pip install Mako

#install repo
RUN mkdir -p /android_build/bin && curl https://storage.googleapis.com/git-repo-downloads/repo > /android_build/bin/repo && chmod a+x /android_build/bin/repo

RUN rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists

#change dash to bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

#set volume
RUN mkdir /aosp

WORKDIR /aosp

RUN chown -R $USER:$USER /aosp 

RUN  mkdir -p /lib/modules/$(uname -r) && sudo depmod -a 2>/dev/null || true