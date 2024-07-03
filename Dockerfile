FROM ubuntu:noble
LABEL maintainer="Tiago Hillebrandt <tiago@tiagohillebrandt.com>"

SHELL ["/bin/bash", "-c"]

ENV TZ=America/New_York

RUN chsh -s /bin/bash root

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -yq \
    curl \
    wget \
    jq \
    git \
    unzip \
    software-properties-common

RUN add-apt-repository ppa:ondrej/php -y --no-update
RUN apt-get update && apt-get install -yq \
    php7.4-cli \
    php7.4-curl \
    php7.4-xml \
    php7.4-zip

RUN add-apt-repository ppa:tiagohillebrandt/wp-cli -y --no-update
RUN apt-get update && apt-get install -yq wp-cli
RUN mv /usr/bin/wp /usr/bin/wp-cli

RUN echo '#!/bin/bash' >> /usr/local/bin/wp
RUN echo '/usr/bin/wp-cli --allow-root "$@"' >> /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

RUN cd /tmp && curl -sS https://getcomposer.org/installer | php
RUN mv /tmp/composer.phar /usr/local/bin/composer

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
RUN \. ~/.nvm/nvm.sh && nvm install lts/hydrogen
