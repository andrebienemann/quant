FROM ubuntu

RUN apt update && apt upgrade -y

RUN apt install -y htop make gcc python3 pip git nano curl wget zsh

RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz

RUN tar -xzf ta-lib-0.4.0-src.tar.gz && rm ta-lib-0.4.0-src.tar.gz

RUN cd ta-lib && ./configure && make && make install && cd .. && rm -r ta-lib

RUN pip install numpy pandas matplotlib sympy scipy

RUN pip install scikit-learn tensorflow jupyterlab

RUN pip install zipline-reloaded alphalens-reloaded pyfolio-reloaded empyrical-reloaded

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ENV SHELL=/usr/bin/zsh

CMD python3 -m jupyterlab --ip 0.0.0.0 --allow-root ~
