FROM ubuntu

RUN apt update && apt upgrade -y

RUN apt install -y make gcc python3 pip git wget

RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz

RUN tar -xzf ta-lib-0.4.0-src.tar.gz && rm ta-lib-0.4.0-src.tar.gz

RUN cd ta-lib && ./configure && make && make install && cd .. && rm -r ta-lib

RUN pip install numpy pandas matplotlib sympy scipy

RUN pip install scikit-learn tensorflow jupyterlab

RUN pip install zipline-reloaded alphalens-reloaded pyfolio-reloaded empyrical-reloaded

CMD python3 -m jupyterlab --ip 0.0.0.0 --allow-root ~
