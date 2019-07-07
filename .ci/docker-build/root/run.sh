#!/usr/bin/env bash

set -ex

OS="$(grep '^ID=' /etc/os-release | sed 's/ID=\(.*\)/\1/')"

if [ "${OS}" = 'debian' ]; then
  apt-get -qq update
  DEBIAN_FRONTEND=noninteractive apt-get -yqq --no-install-suggests --no-install-recommends install \
    git \
    libc6-dev libffi-dev gcc g++ make \
     > /dev/null
  rm -rf -- /var/lib/apt/lists/* /var/cache/apt/*
  useradd -ms /bin/sh -u 888 -UG users tox
elif [ "${OS}" = 'alpine' ]; then
  apk add --no-cache \
    shadow \
    git \
    libc-dev libffi-dev gcc g++ make \
    > /dev/null
  useradd -mu 888 -UG users tox
  apk del --no-cache shadow
else
  printf '\nERROR: Could not determine Linux disto.\n'
  exit 1
fi

printf '[global]\nno-cache-dir = true\ndisable-pip-version-check = true' > /etc/pip.conf
pip --quiet install -r /opt/docker-build/requirements.txt
