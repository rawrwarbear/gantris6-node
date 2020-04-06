
FROM jenkins/jnlp-slave:latest
MAINTAINER rawrwarbear <w.a.capili@accenture.com>
#SHELL ["/bin/bash", "-c"]
USER root
# INSTALL node
RUN apt update
RUN apt install -y build-essential libssl-dev
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install -y awscli zip unzip
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install -y nodejs
RUN apt install -y gettext

USER jenkins
WORKDIR /home/jenkins
ENV NODE_VERSION 10.16.3
ENV NVM_DIR /home/jenkins/.nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

RUN npm config set prefix "$NVM_DIR/v$NODE_VERSION/.npm-global"
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $PATH:$NVM_DIR/v$NODE_VERSION/bin:/usr/lib/node_modules:$NVM_DIR/v$NODE_VERSION/.npm-global/bin:/usr/bin

RUN npm install -g node-sass node-sass-chokidar npm-run-all
RUN npm install -g react-scripts

# NODE INSTALLED

WORKDIR /home/jenkins/agent
ENTRYPOINT ["jenkins-agent"]
