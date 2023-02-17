FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
 
RUN apt update
#RUN apt upgrade -y
RUN apt install -y python3 python3-pip 
RUN apt install -y apt-transport-https git

RUN mkdir /usr/local/codes
WORKDIR /usr/local/codes


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
