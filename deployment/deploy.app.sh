#!/usr/bin/env bash

# enable strict mode
set -eu

# Load config environment variables
source ./deployment/config.sh

# Docker image names
export APP_DOCKER_IMAGE="${DOCKER_REGISTRY}/app:${BUILD_VERSION}"

## Render and deploy app service
gcloud run services replace $(./deployment/utils/render.sh deployment/services/app.service.yaml) --region=${REGION} --project=${PROJECT_ID}
