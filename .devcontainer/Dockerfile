FROM ubuntu:22.04

ARG USER=shanteacontrols
ARG ENV_FILE=/home/$USER/.env_setup

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

# Don't run as root!
RUN adduser --disabled-password --gecos '' $USER

# Add user to sudo group
RUN adduser $USER sudo

# Disable password prompt for sudo commands
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Run everything below as $USER
USER $USER
WORKDIR /home/$USER

RUN \
echo "#!/bin/bash" >> $ENV_FILE && \
echo "export GEM_HOME=/home/$USER/gems" >> $ENV_FILE && \
echo "export GEM_PATH=/home/$USER/gems" >> $ENV_FILE && \
echo "export NVM_DIR=/home/$USER/.nvm" >> $ENV_FILE && \
echo "export PATH=\"/home/$USER/gems/bin:$PATH\"" >> $ENV_FILE && \
echo '[ -s $NVM_DIR/nvm.sh ] && \. $NVM_DIR/nvm.sh || true' >> $ENV_FILE

# Temporarily add Makefile, Gemfile and NPM package files so that installation is done during
# the container build phase.
ADD \
Makefile \
Gemfile \
Gemfile.lock \
package.json \
package-lock.json \
/home/$USER

RUN \
sudo chown $USER:$USER \
/home/$USER/package.json \
/home/$USER/package-lock.json \
&& \
make install && \
rm \
/home/$USER/Makefile \
/home/$USER/Gemfile \
/home/$USER/Gemfile.lock \
/home/$USER/package.json \
/home/$USER/package-lock.json

EXPOSE 3000