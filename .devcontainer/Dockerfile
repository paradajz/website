FROM ubuntu:22.04

ARG USER=shanteacontrols
ARG NODE_VERSION=16.13.2
ENV GEM_HOME /home/$USER/gems
ENV NVM_DIR /home/$USER/.nvm

RUN \
apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
curl \
git \
ca-certificates \
ruby-full \
build-essential \
zlib1g-dev

#don't run as root!
RUN adduser --disabled-password --gecos '' $USER

#add user to sudo group
RUN adduser $USER sudo

#disable password prompt for sudo commands
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#run everything below as $USER
USER $USER
WORKDIR /home/$USER

#setup gem install directory
RUN \
echo 'export GEM_HOME="$GEM_HOME"' >> ~/.bashrc && \
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc

RUN gem install jekyll bundler

RUN \
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
. $NVM_DIR/nvm.sh && \
nvm install $NODE_VERSION

EXPOSE 3000