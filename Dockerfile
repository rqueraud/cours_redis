FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y python3.9
RUN apt-get install -y python3-pip

# ##### Binder doc #####

RUN python3.9 -m pip install --no-cache-dir notebook jupyterlab

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

USER root

######################

# Install tools
RUN python3.9 -m pip install --no-cache-dir notebook pymongo pandas xmltodict elasticsearch
RUN apt-get install -y htop curl
RUN apt-get update
RUN apt-get install -y default-jre default-jdk

# Install redis
RUN apt-get install -y lsb-release
RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list
RUN apt-get update
RUN apt-get install -y redis

# Set directory
WORKDIR /home/${NB_USER}
COPY . ${HOME}

# Download dependencies
RUN python3.9 -m pip install gdown
RUN gdown https://drive.google.com/uc?id=1KU2LAaY3dpc9f24Da1j1gAW4CG7zce4k
RUN apt-get install -y unzip
RUN unzip data.zip
RUN rm data.zip

# Set user
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
