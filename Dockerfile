FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD sources.list /etc/apt/sources.list

# Update Repos
RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends build-essential sudo git wget curl nmap ruby \
  && apt-get clean

RUN apt-get install -y python-dev python python-pip

# Install Python dependecies
RUN pip install requests

# Install fsociety
RUN git clone https://github.com/Manisso/fsociety.git \
  && cd fsociety \
  && chmod +x install.sh \
  && ./install.sh

# Change workdir
WORKDIR /root/.fsociety/

# Hack to keep the container running
CMD python -c "import signal; signal.pause()"
