#  Dockerfile -- for a nikola run-time environment
#  Copyright (C) 2016-2024  Olaf Meeuwissen
#
#  License: GPL-3.0+

FROM alpine
LABEL MAINTAINER="Olaf Meeuwissen <paddy-hack@member.fsf.org>"

ENV PIPX_HOME=/opt/pipx                                                 \
    PIPX_BIN_DIR=/usr/local/bin                                         \
    PIPX_MAN_DIR=/usr/local/share/man                                   \
    PIPX_OPTS="--pip-args=--no-cache-dir --disable-pip-version-check"
ARG _VERSION

RUN apk add --no-cache                                                  \
        python3                                                         \
        pipx                                                            \
        libxml2                                                         \
        libxslt                                                         \
        jpeg                                                            \
                                                                     && \
    apk add --no-cache --virtual .build-deps                            \
        gcc                                                             \
        musl-dev                                                        \
        py3-wheel                                                       \
        python3-dev                                                     \
        libxml2-dev                                                     \
        libxslt-dev                                                     \
        jpeg-dev                                                        \
                                                                     && \
    CFLAGS="$CFLAGS -L/lib"                                             \
    pipx install "$PIPX_OPTS" nikola$_VERSION                           \
                                                                     && \
    apk del .build-deps                                              && \
    rm -rf ~/.cache $PIPX_HOME/.cache $PIPX_HOME/logs                && \
    find /usr/lib/python3.* $PIPX_HOME                                  \
        \( -type d -a -name test -o -name tests \)                      \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \)              \
        -exec rm -rf '{}' +

RUN apk add --no-cache                                                  \
        libstdc++                                                       \
                                                                     && \
    apk add --no-cache --virtual .extra-build-deps                      \
        g++                                                             \
        libffi-dev                                                      \
        musl-dev                                                        \
        py3-wheel                                                       \
        python3-dev                                                     \
        zeromq-dev                                                      \
                                                                     && \
    pipx install --force "$PIPX_OPTS" 'nikola[extras]'$_VERSION         \
                                                                     && \
    apk del .extra-build-deps                                        && \
    rm -rf ~/.cache $PIPX_HOME/.cache $PIPX_HOME/logs                && \
    find /usr/lib/python3.* $PIPX_HOME                                  \
        \( -type d -a -name test -o -name tests \)                      \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \)              \
        -exec rm -rf '{}' +
