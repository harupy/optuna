ARG PYTHON_VERSION=3.7

FROM python:${PYTHON_VERSION}

RUN apt-get update \
    && apt-get -y install openmpi-bin libopenmpi-dev \
    && apt-get -y install swig  \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir --progress-bar off -U setuptools

WORKDIR /workspaces

RUN mkdir optuna \
    && touch optuna/version.py \
    && echo '__version__ = "0.0.1"' >> optuna/version.py \
    && cat  optuna/version.py \
    && touch README.md
COPY setup.py .

RUN ls

ARG BUILD_TYPE='dev'

RUN if [ "${BUILD_TYPE}" = "dev" ]; then \
        if [ "${PYTHON_VERSION}" \< "3.6" ]; then \
            pip install --no-cache-dir -e '.[doctest, document, example, testing]' -f https://download.pytorch.org/whl/torch_stable.html; \
        else \
            pip install --no-cache-dir -e '.[checking, doctest, document, example, testing]' -f https://download.pytorch.org/whl/torch_stable.html; \
        fi \
    else \
        pip install --no-cache-dir -e .; \
    fi \
    && pip install jupyter notebook

# Note that optuna is installed in "editable" mode
# so any changes under the optuna directory will be reflected on the installed optuna.
COPY . .

RUN python -c "import optuna; print(optuna.__version__)"
