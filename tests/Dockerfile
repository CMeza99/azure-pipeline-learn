ARG  PY=python
ARG  PY_VER=latest
ARG  IMG_VARIANT=
FROM ${PY}:${PY_VER}${IMG_VARIANT}

RUN set -ex &&\
    OS="$(grep '^ID=' /etc/os-release | sed 's/ID=\(.*\)/\1/')" &&\
    if [ "${OS}" = 'debian' ]; then \
      apt-get -qq update &&\
      DEBIAN_FRONTEND=noninteractive apt-get -yqq --no-install-suggests --no-install-recommends install \
        git \
        # libc6-dev libffi-dev gcc g++ make \
	    > /dev/null &&\
      rm -rf -- /var/lib/apt/lists/* /var/cache/apt/* ;\
    elif [ "${OS}" = 'alpine' ]; then \
      apk add --no-cache \
      git \
      # libc-dev libffi-dev gcc g++ make \
      > /dev/null ;\
    else \
      printf '\nERROR: Could not determine Linux disto.\n' &&\
      exit 1 ;\
    fi &&\
    mkdir -p .config/pip &&\
    printf '[global]\nno-cache-dir = true\ndisable-pip-version-check = true' > .config/pip/pip.conf &&\
    pip --quiet install 'tox<4'

ENTRYPOINT [ "tox" ]
