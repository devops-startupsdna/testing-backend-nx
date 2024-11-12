#!/usr/bin/env bash

source ./deployment/config.sh

# enable strict mode
set -eu

## Configure docker to use gcloud as credential helper
gcloud auth configure-docker ${REGION}-docker.pkg.dev
