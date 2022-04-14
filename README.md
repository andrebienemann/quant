# Quant

Quant is a preconfigured JupyterLab for quantitative analysis, provisioned in a Docker image.

The image contains:
  - scientific libraries (
        [numpy](https://numpy.org/), 
        [pandas](https://pandas.pydata.org/), 
        [matplotlib](https://matplotlib.org/),
        [scipy](https://scipy.org/),
        [sympy](https://www.sympy.org/)
    )
  - machine-learning libraries (
        [scikit-learn](https://scikit-learn.org/stable/),
        [tensorflow](https://www.tensorflow.org/)
    )
  - financial libraries (
        [empyrical](https://empyrical.ml4trading.io/),
        [alphalens](https://alphalens.ml4trading.io/),
        [zipline](https://zipline.ml4trading.io/),
        [pyfolio](https://pyfolio.ml4trading.io/)
    )

## Quick Start

With the command below, you can create a Docker container in detached mode and publish it on port *8888*.

```txt
docker run --detach --publish 8888:8888 --name <name> andrebienemann/quant
```

Once created, open the URL - found in the logs - with a web browser of your choice.
