ARG VERSION=3.11-slim

FROM python:${VERSION} AS base

RUN apt update && apt upgrade -y --fix-missing
RUN apt install -y htop make gcc git vim nano curl wget zsh cntlm jq zip unzip

FROM base AS python

SHELL ["/bin/bash", "-c"]
RUN python3 -m venv ~/.venv && source ~/.venv/bin/activate && pip install --upgrade pip setuptools
RUN source ~/.venv/bin/activate && pip install numpy pandas matplotlib scipy scikit-learn

FROM python AS ta

SHELL ["/bin/bash", "-c"]
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar -xzf ta-lib-0.4.0-src.tar.gz && rm ta-lib-0.4.0-src.tar.gz
RUN cd ta-lib && ./configure --build=$(arch)-unknown-linux-gnu && make && make install
RUN rm -r ta-lib

FROM ta AS zipline

SHELL ["/bin/bash", "-c"]
RUN source ~/.venv/bin/activate && export DISABLE_BCOLZ_AVX2=true && export DISABLE_BCOLZ_SSE2=true && pip install git+https://github.com/stefan-jansen/bcolz-zipline.git@main
RUN source ~/.venv/bin/activate && pip install zipline-reloaded alphalens-reloaded pyfolio-reloaded empyrical-reloaded

FROM zipline AS jupyter

SHELL ["/bin/bash", "-c"]
RUN source ~/.venv/bin/activate && pip install jupyterlab

FROM jupyter AS zsh

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ENV SHELL=/usr/bin/zsh

FROM zsh AS scripts

RUN mkdir /usr/local/etc/scripts
RUN echo -e "\nexport PATH=\$PATH:/usr/local/etc/scripts" >> ~/.bashrc
RUN echo -e "\nexport PATH=\$PATH:/usr/local/etc/scripts" >> ~/.zshrc

COPY scripts/configure-alpha-vantage.sh /usr/local/etc/scripts/configure-alpha-vantage
COPY scripts/configure-enigma.sh /usr/local/etc/scripts/configure-enigma
COPY scripts/configure-git.sh /usr/local/etc/scripts/configure-git
COPY scripts/configure-iex.sh /usr/local/etc/scripts/configure-iex
COPY scripts/configure-proxy.sh /usr/local/etc/scripts/configure-proxy
COPY scripts/configure-ssh.sh /usr/local/etc/scripts/configure-ssh
COPY scripts/configure-tiingo.sh /usr/local/etc/scripts/configure-tiingo
COPY scripts/configure-tz.sh /usr/local/etc/scripts/configure-tz
COPY scripts/configure.sh /usr/local/etc/scripts/configure

FROM scripts AS final

CMD source ~/.venv/bin/activate && python3 -m jupyterlab --ip 0.0.0.0 --allow-root ~

WORKDIR /root
