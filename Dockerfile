ARG VERSION=3.11-slim

FROM python:${VERSION} AS base

RUN apt update && apt -y upgrade
RUN apt install -y gcc cntlm htop
RUN apt install -y make git vim nano
RUN apt install -y curl wget jq zip unzip

FROM base AS python

SHELL ["/bin/bash", "-c"]

RUN python3 -m venv ~/.venv
RUN source ~/.venv/bin/activate && pip install jupyterlab
RUN source ~/.venv/bin/activate && pip install numpy pandas matplotlib scipy scikit-learn

FROM python AS ta

SHELL ["/bin/bash", "-c"]

RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar -xzf ta-lib-0.4.0-src.tar.gz && rm ta-lib-0.4.0-src.tar.gz
RUN cd ta-lib && ./configure --build=$(arch)-unknown-linux-gnu && make && make install
RUN rm -r ta-lib

FROM ta AS zipline

SHELL ["/bin/bash", "-c"]

RUN source ~/.venv/bin/activate && if [ "$(arch)" != "x86_64" ]; then export DISABLE_BCOLZ_AVX2=1 DISABLE_BCOLZ_SSE2=1; fi && pip install git+https://github.com/stefan-jansen/bcolz-zipline.git@main
RUN source ~/.venv/bin/activate && pip install empyrical-reloaded alphalens-reloaded pyfolio-reloaded zipline-reloaded

FROM zipline AS zsh

RUN apt install -y zsh
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
