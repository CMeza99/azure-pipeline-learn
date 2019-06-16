#!/usr/bin/env bash

set -ex

cp -Rf /mnt/pyproject ~/
tox -c ~/pyproject ${@}
