# Quant

[![Docker Hub](https://img.shields.io/docker/stars/andrebienemann/quant.svg)](https://hub.docker.com/r/andrebienemann/quant)
[![Docker Hub](https://img.shields.io/docker/pulls/andrebienemann/quant.svg)](https://hub.docker.com/r/andrebienemann/quant)
[![Docker Hub](https://img.shields.io/docker/image-size/andrebienemann/quant.svg)](https://hub.docker.com/r/andrebienemann/quant)

Quant is a preconfigured JupyterLab designed for quantitative analysis and provisioned inside of a Docker container.

The image contains:
  - scientific libraries (
        [numpy](https://numpy.org/), 
        [pandas](https://pandas.pydata.org/), 
        [matplotlib](https://matplotlib.org/),
        [scipy](https://scipy.org/)
    )
  - machine-learning libraries (
        [scikit-learn](https://scikit-learn.org/stable/)
    )
  - financial libraries (
        [empyrical](https://empyrical.ml4trading.io/),
        [alphalens](https://alphalens.ml4trading.io/),
        [zipline](https://zipline.ml4trading.io/),
        [pyfolio](https://pyfolio.ml4trading.io/)
    )

Additionally, it provides software for:
  - shell ([bash](https://www.gnu.org/software/bash/), [zsh](https://www.zsh.org/))
  - data transfer ([curl](https://curl.se/), [wget](https://www.gnu.org/software/wget/))
  - archiving ([tar](https://www.gnu.org/software/tar/), [zip](https://linux.die.net/man/1/zip), [unzip](https://linux.die.net/man/1/unzip))
  - package management ([apt](https://wiki.debian.org/Apt))
  - code editing ([nano](https://nano-editor.org/), [vim](https://www.vim.org/))
  - stream processing ([grep](https://www.gnu.org/software/grep/manual/grep.html), [sed](https://www.gnu.org/software/sed/manual/sed.html), [jq](https://stedolan.github.io/jq/))
  - system monitoring ([htop](https://htop.dev/))
  - build automation ([make](https://www.gnu.org/software/make/))
  - version control ([git](https://git-scm.com/))
  - proxy ([cntlm](https://cntlm.sourceforge.net/))

## Quick Start

With the command below, you can create an instance of Quant in a detached mode and publish it on the port *8888*.

```txt
docker run --detach --publish 8888:8888 --name <name> andrebienemann/quant
```

Access JupyterLab by following the URL provided in the container logs.

## Changing Port

If you intend to publish DJL on a different port, provide the port number through an environment.

```txt
--env JUPYTER_PORT=<port> --publish <port>:<port>
```

Ensure to substitute the placeholder *port* with it respective values.

## Links

- [Source Code](https://github.com/andrebienemann/quant/)
- [Issue Tracker](https://github.com/andrebienemann/quant/issues/)
