#  Dockerfile -- for a nikola run-time environment
#  Copyright (C) 2016-2019  Olaf Meeuwissen
#
#  License: GPL-3.0+

FROM        alpine:3.9
MAINTAINER  Olaf Meeuwissen <paddy-hack@member.fsf.org>

ENV PIP_OPTS --no-cache-dir --disable-pip-version-check
ARG _VERSION

RUN apk add --no-cache                                                  \
        python3                                                         \
        libxml2                                                         \
        libxslt                                                         \
        jpeg                                                            \
                                                                     && \
    apk add --no-cache --virtual .build-deps                            \
        gcc                                                             \
        musl-dev                                                        \
        python3-dev                                                     \
        libxml2-dev                                                     \
        libxslt-dev                                                     \
        jpeg-dev                                                        \
                                                                     && \
    CFLAGS="$CFLAGS -L/lib"                                             \
    pip3 install $PIP_OPTS nikola$_VERSION                              \
                                                                     && \
    apk del .build-deps                                              && \
    find /usr/lib/python3.*                                             \
        \( -type d -a -name test -o -name tests \)                      \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \)              \
        -exec rm -rf '{}' +

RUN apk add --no-cache                                                  \
        libstdc++                                                       \
                                                                     && \
    apk add --no-cache --virtual .extra-build-deps                      \
        g++                                                             \
        musl-dev                                                        \
        python3-dev                                                     \
        zeromq-dev                                                      \
                                                                     && \
    pip3 install $PIP_OPTS 'nikola[extras]'$_VERSION                    \
                                                                     && \
    apk del .extra-build-deps                                        && \
    find /usr/lib/python3.*                                             \
        \( -type d -a -name test -o -name tests \)                      \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \)              \
        -exec rm -rf '{}' +
