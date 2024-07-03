FROM ubuntu:noble
LABEL maintainer="Tiago Hillebrandt <tiago@tiagohillebrandt.com>"

ENV SHELL=/bin/bash
ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -yq \
    curl \
    wget \
    software-properties-common

RUN add-apt-repository ppa:ondrej/php -y --no-update
RUN apt-get update && apt-get install -yq php7.4-cli

RUN cd /tmp && curl -sS https://getcomposer.org/installer | php
RUN mv /tmp/composer.phar /usr/local/bin/composer

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
RUN source $HOME/.nvm/nvm.sh && nvm install lts/hydrogen
