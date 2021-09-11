# [Choice] Node.js version: 16, 14, 12
ARG VARIANT=16

FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

RUN su node -c "umask 0002 && npm install -g @vue/cli @vue/cli-service-global"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev 

# Cypress dependencies
RUN apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev \
    libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb


RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

ENV PYTHON_VERSION=3.9.1
RUN pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}

RUN echo "alias dc='docker-compose'" >> /etc/bash.bashrc
RUN echo "alias dc-up='docker-compose -f docker-compose.yml -f .devcontainer/docker-compose.yml up -d --build'" >> /etc/bash.bashrc

# Install Heroku CLI
RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install docker and docker-compose linked to host instance
COPY .devcontainer/scripts/docker-debian.sh /tmp/scripts/
RUN apt-get update && bash /tmp/scripts/docker-debian.sh
ENTRYPOINT ["/usr/local/share/docker-init.sh"]
CMD ["sleep", "infinity"]

