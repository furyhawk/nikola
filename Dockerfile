#  Dockerfile -- for a nikola run-time environment
#  Copyright (C) 2016  Olaf Meeuwissen
#
#  License: GPL-3.0+

FROM        alpine:3.4
MAINTAINER  Olaf Meeuwissen <paddy-hack@member.fsf.org>

ENV PIP_OPTS --no-cache-dir --disable-pip-version-check

RUN apk add --no-cache                                                  \
        python3 						        \
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
    pip3 install $PIP_OPTS nikola                                       \
                                                                     && \
    apk del .build-deps

RUN apk add --no-cache                                                  \
        libstdc++                                                       \
                                                                     && \
    apk add --no-cache --virtual .extra-build-deps                      \
        g++                                                             \
        musl-dev                                                        \
        python3-dev                                                     \
                                                                     && \
    pip3 install $PIP_OPTS 'nikola[extras]'                             \
                                                                     && \
    apk del .extra-build-deps
