#!/usr/bin/env sh

set -ex

cp -Rf /mnt/pyproject ~/
tox -c ~/pyproject ${@}
