FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# We use aliyun mirrors.
RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list 
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list 
RUN sed -i "s/security.debian.org/mirrors.aliyun.com\/debian-security/g" /etc/apt/sources.list 
RUN sed -i "s/security.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list
 
RUN apt update
RUN apt upgrade -y
RUN apt install -y python3 python3-pip 
RUN apt install -y apt-transport-https git

RUN pip install -U pip
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
RUN pip config set install.trusted-host mirrors.aliyun.com

RUN mkdir /usr/local/codes
WORKDIR /usr/local/codes

# RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

RUN apt install -y cmake build-essential pkg-config libgoogle-perftools-dev openjdk-8-jdk
# RUN apt install -y libgoogle-perftools-dev
RUN git clone https://github.com/google/sentencepiece.git
WORKDIR /usr/local/codes/sentencepiece
RUN mkdir build
WORKDIR /usr/local/codes/sentencepiece/build
RUN cmake ..
RUN make -j $(nproc)
RUN make install
RUN ldconfig -v

#COPY ./sentencepiece.sh ./sentencepiece.sh
#RUN bash ./sentencepiece.sh

COPY ./requirements.txt ./requirements.txt
RUN python3 -m pip install -r ./requirements.txt
