ARG  PY=python
ARG  PY_VER=latest
ARG  IMG_VARIANT=
FROM ${PY}:${PY_VER}${IMG_VARIANT}

COPY requirements.txt /tmp/

RUN set -ex &&\
    OS="$(grep '^ID=' /etc/os-release | sed 's/ID=\(.*\)/\1/')" &&\
    if [ "${OS}" = 'debian' ]; then \
      apt-get -qq update &&\
      DEBIAN_FRONTEND=noninteractive apt-get -yqq --no-install-suggests --no-install-recommends install \
        git \
        libc6-dev libffi-dev gcc g++ make \
         > /dev/null &&\
      rm -rf -- /var/lib/apt/lists/* /var/cache/apt/* ;\
      useradd -ms /bin/sh -u 888 -UG users tox ;\
    elif [ "${OS}" = 'alpine' ]; then \
      apk add --no-cache \
        shadow \
        git \
        libc-dev libffi-dev gcc g++ make \
        > /dev/null ;\
      useradd -mu 888 -UG users tox &&\
      apk del --no-cache shadow ;\
    else \
      printf '\nERROR: Could not determine Linux disto.\n' &&\
      exit 1 ;\
    fi &&\
    # mkdir -p ~/.ssh &&\
    # printf 'github.com,192.30.255.112 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==' \
    #   >> ~/.ssh/known_hosts &&\
    printf '[global]\nno-cache-dir = true\ndisable-pip-version-check = true' > /etc/pip.conf &&\
    pip --quiet install -r /tmp/requirements.txt

USER tox

COPY tox.sh /usr/local/bin

ENV PYTEST_XDIST_PROC_NR=auto \
    TOX_WORK_DIR=/home/tox/.tox

RUN set -ex &&\
    mkdir -p "${TOX_WORK_DIR}"

ENTRYPOINT [ "tox.sh" ]
