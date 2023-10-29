FROM ubuntu:23.04

ARG ENV_FILE=/home/ubuntu/.env_setup

RUN \
apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
curl \
git \
ca-certificates \
ruby-full \
build-essential \
sudo \
zlib1g-dev

# Disable password prompt for sudo commands
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN \
echo "#!/bin/bash" >> $ENV_FILE && \
echo "export GEM_HOME=/home/ubuntu/gems" >> $ENV_FILE && \
echo "export GEM_PATH=/home/ubuntu/gems" >> $ENV_FILE && \
echo "export NVM_DIR=/home/ubuntu/.nvm" >> $ENV_FILE && \
echo "export PATH=\"/home/ubuntu/gems/bin:$PATH\"" >> $ENV_FILE && \
echo '[ -s $NVM_DIR/nvm.sh ] && \. $NVM_DIR/nvm.sh || true' >> $ENV_FILE

# Temporarily add Makefile, Gemfile and NPM package files so that installation is done during
# the container build phase.
ADD \
Makefile \
Gemfile \
Gemfile.lock \
package.json \
package-lock.json \
/home/ubuntu

RUN \
sudo chown ubuntu:ubuntu \
/home/ubuntu/package.json \
/home/ubuntu/package-lock.json \
&& \
make install && \
rm \
/home/ubuntu/Makefile \
/home/ubuntu/Gemfile \
/home/ubuntu/Gemfile.lock \
/home/ubuntu/package.json \
/home/ubuntu/package-lock.json

EXPOSE 3000